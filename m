From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: intel ICH sample rate
Date: Sat, 27 Dec 2003 12:11:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312271711.hBRHBANb017469@dhin.linuxaudiosystems.com>
References: <200312271609.hBRG9TTC015443@dhin.linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 27 Dec 2003 11:09:29 EST."
             <200312271609.hBRG9TTC015443@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>i've been getting my laptop with an ICH soundchip up to speed, and i
>just noticed for the first time yesterday that ALSA fails to get the
>speed to the rate that JACK requests. a quick google reveals that the
>OSS drivers only support 1 h/w rate, but there are suggestions that
>the ALSA driver works better. however, neither JACK nor alsaplayer can
>set the rate on my card to 44.1kHz - its stuck at 48kHz.
>
>this is alsa 1.0.0rc2 from Planet CCRMA. any clues?

this is using the snd-intel8x0 module. the wiki page has alerted me to
the ac97_clock option, but it seems ludicrous to have to rmmod &&
modprobe the module just to switch rates ...


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
