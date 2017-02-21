From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/5] ALSA: usb-audio: deallocate memory
 objects in error path
Date: Wed, 22 Feb 2017 07:45:47 +0900
Message-ID: <c4b1c062-2099-bd14-0bc2-5a2f9b1d30ab@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
 <20170220200921.824-5-o-takashi@sakamocchi.jp> <s5hwpckpoz4.wl-tiwai@suse.de>
 <d7632df1-6524-d01c-cbcf-136902976953@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id A9DA8266AA9
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 23:45:54 +0100 (CET)
In-Reply-To: <d7632df1-6524-d01c-cbcf-136902976953@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: onkel@paraair.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fe 21 2017 11:32, Takashi Sakamoto wrote:
> But it's wrong. The allocated memory objects are used for private data
> for each control element set. I didn't care of it...
>
> Here, what I should fix is just for error path. I'll post revised
> version of this patch this night.

I realize that this is not concern because the code includes assignment 
deallocate function to each control element set. Thus, in error path, 
the allocated private data is going to free in below callgrach.

(sound/usb/mixer_us16x08.c)
add_new_ctl(elem)
   kctl->private_free = freeer;
   (sound/usb/mixer.c)
   ->snd_usb_mixer_add_control(kctl)
     (sound/core/control.c)
     ->snd_ctl_add(kctl)
       ->snd_ctl_free_one(kctl)
         (in error path)
         ->kcontrol->private_free(kctl);
         (sound/usb/mixer_us16x08.c)
         = freeer()


Regards

Takashi Sakamoto
