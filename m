From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: snd-ioctl32 is failing on x86_64 (no crashes, just errors)
Date: Wed, 12 Jan 2005 11:24:02 +0900
Message-ID: <20050112022402.GB9290@lion.gg3.net>
References: <20050106130649.GA253131@lion.gg3.net> <s5h1xcxy0tj.wl@alsa2.suse.de> <20050108074026.GA8595@lion.gg3.net> <s5h7jmlv82j.wl@alsa2.suse.de> <20050110123342.GA243173@lion.gg3.net> <s5hwtultnc8.wl@alsa2.suse.de> <20050110161559.GA248292@lion.gg3.net> <s5h7jmkt8j9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tiger.gg3.net (142.13.111.219.st.bbexcite.jp [219.111.13.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1F83428F
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 03:24:05 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5h7jmkt8j9.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

maillog: 11/01/2005-14:11:38(+0100): Takashi Iwai types
> 
> IIRC, the packed attribute was removed because it had a problem on
> SPARC.
> 
> Anyway, the patch below simplifies the compat struct definition so
> that it will have no alignment problem.  Could you give a try?
> 
> If this one works, I'll prefer to commit it than the previous hack.

It almost worked. There were two compilation errors on lines 308 and 342
claiming that "union has no member `data'". I reversed your changes to
the non-32-bit struct references (see below for details) and it worked.

> Index: alsa-kernel/core/ioctl32/ioctl32.c
> ===================================================================
> RCS file: /home/tiwai/cvs/alsa/alsa-kernel/core/ioctl32/ioctl32.c,v
> retrieving revision 1.30
> diff -u -r1.30 ioctl32.c
> --- alsa-kernel/core/ioctl32/ioctl32.c	15 Dec 2004 15:26:24 -0000	1.30
> +++ alsa-kernel/core/ioctl32/ioctl32.c	10 Jan 2005 16:59:33 -0000
> @@ -219,25 +219,10 @@
>  	struct sndrv_ctl_elem_id id;
>  	unsigned int indirect;	/* bit-field causes misalignment */
>          union {
> -		union {
> -			s32 value[128];
> -			u32 value_ptr;
> -		} integer;
> -		union {
> -			s64 value[64];
> -			u32 value_ptr;
> -		} integer64;
> -		union {
> -			u32 item[128];
> -			u32 item_ptr;
> -		} enumerated;
> -		union {
> -			unsigned char data[512];
> -			u32 data_ptr;
> -		} bytes;
> -		struct sndrv_aes_iec958 iec958;
> +		s32 integer[128];	/* integer and boolean need conversion */
> +		unsigned char data[512];	/* others should be compatible */
>          } value;
> -        unsigned char reserved[128];
> +        unsigned char reserved[128];	/* not used */
>  };
>  
>  
> @@ -269,7 +254,7 @@
>  	struct sndrv_ctl_elem_value *data;
>  	struct sndrv_ctl_elem_value32 __user *data32;
>  	snd_ctl_file_t *ctl;
> -	int err, i;
> +	int err, i, indirect;
>  	int type;
>  
>  	/* sanity check */
> @@ -281,7 +266,7 @@
>  		return -ENOTTY;
>  
>  	data32 = compat_ptr(arg);
> -	data = kmalloc(sizeof(*data), GFP_KERNEL);
> +	data = kcalloc(1, sizeof(*data), GFP_KERNEL);
>  	if (data == NULL)
>  		return -ENOMEM;
>  
> @@ -289,12 +274,12 @@
>  		err = -EFAULT;
>  		goto __end;
>  	}
> -	if (__get_user(data->indirect, &data32->indirect)) {
> +	if (__get_user(indirect, &data32->indirect)) {
>  		err = -EFAULT;
>  		goto __end;
>  	}
>  	/* FIXME: indirect access is not supported */
> -	if (data->indirect) {
> +	if (indirect) {
>  		err = -EINVAL;
>  		goto __end;
>  	}
> @@ -309,7 +294,7 @@
>  	case SNDRV_CTL_ELEM_TYPE_INTEGER:
>  		for (i = 0; i < 128; i++) {
>  			int val;
> -			if (__get_user(val, &data32->value.integer.value[i])) {
> +			if (__get_user(val, &data32->value.integer[i])) {
>  				err = -EFAULT;
>  				goto __end;
>  			}
> @@ -317,33 +302,12 @@
>  		}
>  		break;
>  	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
> -		if (__copy_from_user(data->value.integer64.value,
> -				     data32->value.integer64.value,
> -				     sizeof(data->value.integer64.value))) {
> -			err = -EFAULT;
> -			goto __end;
> -		}
> -		break;
>  	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
> -		if (__copy_from_user(data->value.enumerated.item,
> -				     data32->value.enumerated.item,
> -				     sizeof(data32->value.enumerated.item))) {
> -			err = -EFAULT;
> -			goto __end;
> -		}
> -		break;
>  	case SNDRV_CTL_ELEM_TYPE_BYTES:
> -		if (__copy_from_user(data->value.bytes.data,
> -				     data32->value.bytes.data,
> -				     sizeof(data32->value.bytes.data))) {
> -			err = -EFAULT;
> -			goto __end;
> -		}
> -		break;
>  	case SNDRV_CTL_ELEM_TYPE_IEC958:
> -		if (__copy_from_user(&data->value.iec958,
> -				     &data32->value.iec958,
> -				     sizeof(data32->value.iec958))) {
> +		if (__copy_from_user(data->value.data,
                                     ^^^^^^^^^^^^^^^^^
   reversing this to &data->value.iec958
> +				     data32->value.data,
> +				     sizeof(data32->value.data))) {
>  			err = -EFAULT;
>  			goto __end;
>  		}
> @@ -367,43 +331,20 @@
>  		for (i = 0; i < 128; i++) {
>  			int val;
>  			val = data->value.integer.value[i];
> -			if (__put_user(val, &data32->value.integer.value[i])) {
> +			if (__put_user(val, &data32->value.integer[i])) {
>  				err = -EFAULT;
>  				goto __end;
>  			}
>  		}
>  		break;
> -	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
> -		if (__copy_to_user(data32->value.integer64.value,
> -				   data->value.integer64.value,
> -				   sizeof(data32->value.integer64.value))) {
> -			err = -EFAULT;
> -			goto __end;
> -		}
> -		break;
> -	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
> -		if (__copy_to_user(data32->value.enumerated.item,
> -				   data->value.enumerated.item,
> -				   sizeof(data32->value.enumerated.item))) {
> -			err = -EFAULT;
> -			goto __end;
> -		}
> -		break;
> -	case SNDRV_CTL_ELEM_TYPE_BYTES:
> -		if (__copy_to_user(data32->value.bytes.data,
> -				   data->value.bytes.data,
> -				   sizeof(data32->value.bytes.data))) {
> +	default:
> +		if (__copy_to_user(data32->value.data,
> +				   data->value.data,
 and this to data->value.bytes.data^^^^^^^^^^^^^^^^
> +				   sizeof(data32->value.data))) {
>  			err = -EFAULT;
>  			goto __end;
>  		}
>  		break;
> -	case SNDRV_CTL_ELEM_TYPE_IEC958:
> -		if (__copy_to_user(&data32->value.iec958,
> -				   &data->value.iec958,
> -				   sizeof(data32->value.iec958))) {
> -			err = -EFAULT;
> -			goto __end;
> -		}
>  		break;
>  	}
>  	err = 0;

made the patch compile fine. I checked with realplayer and 32-bit
alsamixer, and they both appeared to work without any problems.

-- 
*)   Georgi Georgiev   *) You can drive a horse to water, but a        *)
(*    chutz@gg3.net    (* pencil must be lead.                         (*
*)  +81(90)6266-1163   *)                                              *)


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
