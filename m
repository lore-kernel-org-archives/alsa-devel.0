From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: dB gain
Date: Wed, 31 May 2006 12:04:39 +0100
Message-ID: <447D7847.50406@superbug.co.uk>
References: <4478A290.80702@superbug.co.uk>	<s5hverp7zcr.wl%tiwai@suse.de>	<447B0A19.2050408@superbug.co.uk>	<s5hy7wkddyf.wl%tiwai@suse.de>	<447B308E.2050502@superbug.co.uk>	<s5hirnod7l2.wl%tiwai@suse.de>	<Pine.LNX.4.61.0605292017280.11164@tm8103-a.perex-int.cz>	<447C962E.3010103@superbug.co.uk>
	<s5hlksieajf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1519135
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 13:04:41 +0200 (MEST)
In-Reply-To: <s5hlksieajf.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> No, please not yet.  The code is still not good enough for commit.
>
> For example, some things to be fixed regarding the code (and coding
> style) are below:
>
> +static int uint32_to_message(struct snd_ctl_misc *misc, u32 value)
> +{
> +	unsigned int pointer = misc->length;
> +	u32 *store = (u32*) &misc->message[pointer];
>
> This cast isn't always allowed.
>
> +	*store = value;
> +	misc->length += sizeof(u32);
> +	return 0;
> +}
>
>   
What do I use instead?

+	misc->message[pointer++] = value & 0xff;
+	misc->message[pointer++] = (value >> 8) & 0xff;
+	misc->message[pointer++] = (value >> 16) & 0xff;
+	misc->message[pointer++] = (value >> 24) & 0xff;


> +static int add_message_tlv_to_container(
> +	struct snd_ctl_misc *misc, unsigned int length, unsigned char *message)
>
> Unconventional indentation.
>
> +	unsigned int pointer = misc->length;
> +	unsigned int n;
> +	for(n=0; n<length; n++) {
> +		misc->message[pointer++] = message[n];
> +	}
>
> What's wrong with memcpy()?
>   
Nothing wrong with memcpy().
> +static int snd_ctl_misc_user(struct snd_ctl_file *ctl,
> +				  struct snd_ctl_misc __user *_misc)
> +{
> +	struct snd_ctl_misc *misc;
> +	struct snd_card *card = ctl->card;
> +	struct snd_kcontrol *kctl;
> +	struct snd_ctl_elem_info2 info2;
> +	int result=0;
> +	int numid;
> +	unsigned int received_length;
> +	unsigned int tlv_type;
> +	unsigned int tlv_length;
> +	unsigned int tlv_value;
> +	unsigned int container_type;
> +	unsigned int container_length;
> +	
> +	misc = kmalloc(2048, GFP_KERNEL);
> +	if (misc == NULL)
> +		return -ENOMEM;
>
> Why always 2048?
>   
No particular reason, just seemed like a ball park value that I should 
not have to change any time soon. I could probably replace it with some 
getuser32 calls to get the required length from the userspace app. Is 
getuser32() the correct call to use instead of copy_from_user(), if all 
one needs is a 4 byte integer from a particular memory location?
> Also, cases should be aligned to switch().
>   
Ok.
> But, above all, such a large switch() is ugly.  Better to put the
> container-type specific handling out of this function.
>
> Although this whole block basically belongs only to DB_SCALE case, the
> current code looks as if this block is commonly handled regardless of
> the container type.
>   
That's true. I will look at putting the case action as a separate function.

> +struct snd_ctl_misc {
> +	u32 version;
> +	u32 length;
> +	unsigned char message[];
> +};
>
> The empty array isn't portable.
>   
Ok, how do I do this then?
The array is not actually empty, but it's size is dependent on the 
length field.

> +typedef int (snd_kcontrol_info2_t) (struct snd_kcontrol * kcontrol, int type, struct snd_ctl_elem_info2 * uinfo);
>
> The type should be non-numeric but constants (bitwise define or
> enum).
>   
I don't understand. This is almost an exact copy of:
typedef int (snd_kcontrol_info_t) (struct snd_kcontrol * kcontrol, 
struct snd_ctl_elem_info * uinfo);
That is already in the code.
