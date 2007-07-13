From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: M-Audio Audiophile USB - Remaining issues
Date: Fri, 13 Jul 2007 20:01:27 +0200
Message-ID: <20070713200127.lhwk0qy5wckoc4c4@webmail.supelec.fr>
References: <s5hzm20zkuz.wl%tiwai@suse.de>
	<000001c7c55d$50a50190$161ce4a0@supelec.fr>
	<s5h3azsz6lm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpn.supelec.fr (smtpn.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C2CE24365
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 20:01:28 +0200 (CEST)
In-Reply-To: <s5h3azsz6lm.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> It would be great if the one pcm device+subdevice was always linked to the
>> same interface (Analog or Digital)
>> Can anyone could point me to the piece of code that chooses the mapping
>> between the device physiscal interface and Alsa's pcm interface? I'll try to
>> see if I can fix this.
>
> In the case of usb-audio, it's a bit complicated.  The streams are
> assigned automatically per USB descriptions.  I think the easiest
> would be to mangle the PCM device number in alsa-lib USB-Audio.conf
> file.  Maybe Clemens can give a better hint.

Thanks for the tip... let me see have a look at this file....

Humm... at least there is something to change now :
----------------
USB-Audio.pcm.use_dmix {
	"AudioPhile" no    # uses big-endian 24-bit samples
}
----------------

==> This is not true anymore since if the device is used with  
device_setup=0x01 or 0x11, it supports S16_LE and thus dmix can be  
applied !


For the rest of the file, I definitely need Clemens' enlightenment ;-)


> The problem with multi plugin and JACK was fixed on 1.0.14.

Thanks.

>> 3- Have a user interface to switch device_setup modes
>> This may be the hardest to do and I don't think I've got the required skills
>> to do this. Anyway, I would realy appreciate any information (or existing
>> piece of code) about the following:
>> * how to write a user interface which interacts with the kernel module
>> * forcing a reinitialization of the snd-usb-audio module without
>> unprobing/reprobing the kernel module
>
> Well, the best would be to allow the driver to change the running mode
> on the fly without device_setup option.  But this seems requring
> fairly big change because of the current framework of the usb-audio
> driver.

I'm afraid this is beyond my skills :-(

Let's let this for the moment... Fixing point 1 seems more important.

Thibault
