From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Bug in rme9652 or snd_pcm_hw_params_set_rate_near()? (slave clock stuff)
Date: Tue, 25 Nov 2003 08:01:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311251301.hAPD1GuG001032@oud.linuxaudiosystems.com>
References: <200311242142.48114.torger@ludd.luth.se>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 24 Nov 2003 21:42:48 +0100."
             <200311242142.48114.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>If my hammerfall (rme9652) sound card is locked slave to 48 kHz, and I put 
>44.1 kHz into snd_pcm_hw_params_set_rate_near for playback it accepts it, 
>should it really be that way? I expected that it would set the rate to 48kHz, 
>since the card does not change the sample rate to 44.1 kHz (looking in 
>/proc), when I start playing the rate is indeed 48kHz.

the 9652 driver needs revamping to match the behaviour of the
hdsp. thomas did great work on this, and the model for how it works is
much better than the 9652 driver. put simply, the 9652 driver really
doesn't this "properly".

the hdsp driver works, IIRC, pretty much as you suggest. if its in
master mode, you can set the rate, if its slaved, you cannot.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
