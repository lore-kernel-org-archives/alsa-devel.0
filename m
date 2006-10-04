From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reset file->f_op in
	snd_card_file_remove(). Take 2
Date: Wed, 4 Oct 2006 22:01:53 +0200
Message-ID: <200610042201.53337.annabellesgarden@yahoo.de>
References: <200609282228.02611.annabellesgarden@yahoo.de>
	<200610041736.37639.annabellesgarden@yahoo.de>
	<s5hmz8cjcp6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz8cjcp6.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, 4. Oktober 2006 17:57 schrieb Takashi Iwai:
> > > 
> > > The problem is that we use kmalloc for allocating a dummy f_op.
> > > IMO, the simlest solution is to use a static dummy f_op.
> > > 
> > That'd take 1 static dummy f_op per snd_*_release().
> 
> Yes, but it'll remove extra codes at the same time, too.
> Well, OTOH, it requires more additions for assignment of dummy ops...
> 
> > I prefer the patch at the start of this thread :-)
> 
> I think it's not good to set NULL always there.  The NULL is necessary

I disagree. In snd_card_file_remove() the file has already been
released. Is file->f_op still used anywhere later on
except from __fput()'s call to fops_put(file->f_op); ?
First glance didn't show.... 

> only when the card is freed.  So, I prefer the patch like below.  Is
> it OK?
> 
IMO not:
Lets assume 2 cpus CA, CB and two processes PA, PB,
closing their file's after usb disconnect of 1 snd_card.
PA running on CA going through snd_card_file_remove() first would not
have it's file->f_op set NULL.
Now PA is back in __fput() right after the
	file->f_op->release(inode, file);
Some third process happens to be scheduled an CA.
Meanwhile PB running on CB goes through snd_card_file_remove()
and calls snd_card_do_free(card).
snd_card_do_free(card) frees PA's file->f_op.
PA is scheduled again and has a freed, non NULL file->f_op.
> 
> Takashi
> 
> diff -r f38b12373137 sound/core/init.c
> --- a/sound/core/init.c	Wed Oct 04 17:17:32 2006 +0200
> +++ b/sound/core/init.c	Wed Oct 04 17:50:11 2006 +0200
> @@ -721,8 +721,14 @@ int snd_card_file_remove(struct snd_card
>  	spin_unlock(&card->files_lock);
>  	if (last_close) {
>  		wake_up(&card->shutdown_sleep);
> -		if (card->free_on_last_close)
> +		if (card->free_on_last_close) {
> +			/* release and clear f_op here since the dummy f_ops will
> +			 * be freed in snd_card_do_free().
> +			 */
> +			fops_put(file->f_op);
> +			file->f_op = NULL;
>  			snd_card_do_free(card);
> +		}
>  	}
>  	if (!mfile) {
>  		snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
> 

How about a "disconnecting device" that can emulate a real one
for diconnect reasons?
I've sketched one here:

-------------------------------------------------------------------
/* virtual device
   hides a real device's f_ops,
   exept for release
*/

struct snd_disconnected_file {
	struct file *file;
	int (*release) (struct inode *, struct file *);
	struct snd_disconnected_file *next;
};

static struct snd_disconnected_file *disconnecting_files;
static struct file_operations snd_disconnect_f_ops;

int snd_disconnect_file(struct file *file, int (*release) (struct inode *, struct file *))
{
	int err;
// TODO:	zmalloc and initialize struct snd_disconnected_file,
//		rechain
	return err;

	file->f_op = snd_disconnect_f_ops;
	return 0;
}

static loff_t snd_disconnect_llseek(struct file *file, loff_t offset, int orig)
{
	return -ENODEV;
}

static ssize_t snd_disconnect_read(struct file *file, char __user *buf,
				   size_t count, loff_t *offset)
{
	return -ENODEV;
}

static ssize_t snd_disconnect_write(struct file *file, const char __user *buf,
				    size_t count, loff_t *offset)
{
	return -ENODEV;
}

static int snd_disconnect_release(struct inode *inode, struct file *file)
{
	struct snd_disconnected_file * df = disconnecting_files;
	int err = 0;
	while (df)
		if (df->file == file) {
			err = df->release(inode, file);
// TODO: free df, rechain
		}
	return err;
}

static unsigned int snd_disconnect_poll(struct file * file, poll_table * wait)
{
	return POLLERR | POLLNVAL;
}

static long snd_disconnect_ioctl(struct file *file,
				 unsigned int cmd, unsigned long arg)
{
	return -ENODEV;
}

static int snd_disconnect_mmap(struct file *file, struct vm_area_struct *vma)
{
	return -ENODEV;
}

static int snd_disconnect_fasync(int fd, struct file *file, int on)
{
	return -ENODEV;
}

static struct file_operations snd_disconnect_f_ops =
{
	.owner = 	THIS_MODULE,
	.llseek =	snd_disconnect_llseek,
	.read = 	snd_disconnect_read,
	.write =	snd_disconnect_write,
	.release =	snd_disconnect_release,
	.poll =		snd_disconnect_poll,
	.ioctl =	snd_disconnect_ioctl,
	.mmap =		snd_disconnect_mmap,
	.fasync =	snd_disconnect_fasync
};

----------------------------------------

snd_card_disconnect() would call 
  int snd_disconnect_file(file,	file->f_op->release)
instead of allocating/initing the special f_ops by itself.
We'd win memory by the difference
 sizeof(struct snd_shutdown_f_ops) - sizeof(struct snd_disconnected_file)
.
And play safe.
We would need to be sure, a file->f_op's
	int (*release) (struct inode *, struct file *);
id called exactly one time during a file's life though.

      Karsten

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
