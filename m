From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reset file->f_op in
	snd_card_file_remove(). Take 2
Date: Wed, 4 Oct 2006 12:47:19 +0200
Message-ID: <200610041247.19624.annabellesgarden@yahoo.de>
References: <200609282228.02611.annabellesgarden@yahoo.de>
	<200610012029.36694.annabellesgarden@yahoo.de>
	<s5hirj0l9k5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirj0l9k5.wl%tiwai@suse.de>
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

Am Mittwoch, 4. Oktober 2006 11:22 schrieb Takashi Iwai:
> =

> It should call snd_card_free_when_closed() instead.
> =

IMHO, that would just make sure that the bug happens.
Please see my annotations, starting with // in:

void fastcall __fput(struct file *file)
{
	struct dentry *dentry =3D file->f_dentry;
	struct vfsmount *mnt =3D file->f_vfsmnt;
	struct inode *inode =3D dentry->d_inode;

	might_sleep();

	fsnotify_close(file);
	/*
	 * The function eventpoll_release() should be the first called
	 * in the file cleanup chain.
	 */
	eventpoll_release(file);
	locks_remove_flock(file);

	if (file->f_op && file->f_op->release)
		file->f_op->release(inode, file);
// Here snd_hwdep_release() is called.
// snd_hwdep_release() calls snd_card_file_remove().
// snd_card_file_remove() sees card->free_on_last_close ist set,
// calls snd_card_do_free().
// snd_card_do_free frees file->f_op but doesn't set it NULL.
//
	security_file_free(file);
	if (unlikely(inode->i_cdev !=3D NULL))
		cdev_put(inode->i_cdev);
	fops_put(file->f_op);
// file->f_op has already been freeed!
// fops_put(file->f_op) is likely to oops.
//
	if (file->f_mode & FMODE_WRITE)
		put_write_access(inode);
	file_kill(file);
	file->f_dentry =3D NULL;
	file->f_vfsmnt =3D NULL;
	file_free(file);
	dput(dentry);
	mntput(mnt);
}

Right or wrong?

      Karsten

	=


	=

		=

___________________________________________________________ =

Der fr=FChe Vogel f=E4ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail=
: http://mail.yahoo.de


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
