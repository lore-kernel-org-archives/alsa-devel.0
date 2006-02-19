From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [patch] Fix snd-usb-audio in 32-bit compat environemt
Date: Sun, 19 Feb 2006 20:56:46 +0300
Message-ID: <20060219175646.GB7797@mipter.zuzino.mipt.ru>
References: <878xs85wn6.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <878xs85wn6.fsf@blackdown.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juergen Kreileder <jk@blackdown.de>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 18, 2006 at 07:50:37PM +0100, Juergen Kreileder wrote:
> I'm getting oopses with snd-usb-audio in 32-bit compat environments:
> control_compat.c:get_ctl_type() doesn't initialize 'info', so
> 'itemlist[uinfo->value.enumerated.item]' in
> usbmixer.c:mixer_ctl_selector_info() might access random memory
> (The 'if ((int)uinfo->value.enumerated.item >= cval->max)' doesn't fix
> all problems because of the unsigned -> signed conversion.)

IMO, what you did is an overkill. Does this patch fixes your problem?

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -176,6 +176,7 @@ static int get_ctl_type(struct snd_card
 		up_read(&card->controls_rwsem);
 		return -ENXIO;
 	}
+	memset(info, 0, sizeof(struct snd_ctl_elem_info));
 	info.id = *id;
 	err = kctl->info(kctl, &info);
 	up_read(&card->controls_rwsem);

> --- linux-mm-vanilla/sound/core/control_compat.c
> +++ linux-mm/sound/core/control_compat.c
> @@ -167,7 +167,7 @@ static int get_ctl_type(struct snd_card
>  			int *countp)
>  {
>  	struct snd_kcontrol *kctl;
> -	struct snd_ctl_elem_info info;
> +	struct snd_ctl_elem_info *info;
>  	int err;
>
>  	down_read(&card->controls_rwsem);
> @@ -176,13 +176,19 @@ static int get_ctl_type(struct snd_card
>  		up_read(&card->controls_rwsem);
>  		return -ENXIO;
>  	}
> -	info.id = *id;
> -	err = kctl->info(kctl, &info);
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (info == NULL) {
> +		up_read(&card->controls_rwsem);
> +		return -ENOMEM;
> +	}
> +	info->id = *id;
> +	err = kctl->info(kctl, info);
>  	up_read(&card->controls_rwsem);
>  	if (err >= 0) {
> -		err = info.type;
> -		*countp = info.count;
> +		err = info->type;
> +		*countp = info->count;
>  	}
> +	kfree(info);
>  	return err;
>  }



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
