From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [FT C400, PATCH RFC,
	v3 7/9] usb-audio: Fast Track C400 mixer ranges
Date: Tue, 27 Nov 2012 17:12:00 +0100
Message-ID: <50B4E650.90609@ladisch.de>
References: <1354032058-668-1-git-send-email-eldad@fogrefinery.com>
 <1354032058-668-8-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 4CE8D2652BB
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 17:12:05 +0100 (CET)
In-Reply-To: <1354032058-668-8-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, George Willian Condomitti <georgecondomitti@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Eldad Zack wrote:
> Add ranges for various Fast Track C400 controls, as observed
> while using the vendor's mixer control software (res values
> are an estimation).
>
> +			snd_printk(KERN_INFO
> +				"usb-audio: set quirk for C400 Effect Duration\n");

> +			snd_printk(KERN_INFO
> +				"usb-audio: set quirks for C400 Effect Feedback/Volume\n");

> +			snd_printk(KERN_INFO
> +				"usb-audio: set quirks for C400 %s\n", kctl->id.name);

> +			snd_printk(KERN_INFO
> +				"usb-audio: set quirk for Fast Track C400 %s\n",
> +				kctl->id.name);

Are these messages really needed?


Regards,
Clemens
