From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: alsa-driver-0.9.8, jack, cmipci
Date: Tue, 04 Nov 2003 12:10:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311041710.hA4HANCG003420@oud.linuxaudiosystems.com>
References: <s5hfzh4t8p8.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 04 Nov 2003 17:11:31 +0100."
             <s5hfzh4t8p8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Kraut <krautj@earthlink.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>At Mon, 03 Nov 2003 14:41:51 -0500,
>Jonathan Kraut wrote:
>> 
>> 
>> Hello again.  Further research:
>> 
>> I tried an earlier version of jack (0.71.0) with alsa-driver-0.9.8, accessin
>g hw:0,2 via my .asoundrc. I get the same result as before, but in addition th
>is particular version of jackd tells me:
>> 
>> ...
>> Sorry. The PCM device "cmipci"doesn't support the same sample format for cap
>ture and playback.We cannot use this PCM device.
>> ...
>> 
>> and jackd quits.
>
>this is likely because the newer version of cmipci driver supports
>24bit SPDIF output, but no input yet...

a reminder that for some time now, JACK supports the -P option which
limits it to playback only. useful if that's all you want and/or all
your hardware can do.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
