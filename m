From: Jonathan Kraut <jak76@columbia.edu>
Subject: Re: alsa-driver-0.9.8, jack, cmipci
Date: Sun, 16 Nov 2003 12:18:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1ALQXV-0001IX-00@pintail.mail.pas.earthlink.net>
References: <200311041710.hA4HANCG003420@oud.linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311041710.hA4HANCG003420@oud.linuxaudiosystems.com> 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Tue, 04 Nov 2003 12:10:23 -0500, Paul Davis wrote:
>>At Mon, 03 Nov 2003 14:41:51 -0500,
>>Jonathan Kraut wrote:
>>> 
>>> 
>>> Hello again.  Further research:
>>> 
>>> I tried an earlier version of jack (0.71.0) with alsa-driver-0.9.8, accessi
>n
>>g hw:0,2 via my .asoundrc. I get the same result as before, but in addition t
>h
>>is particular version of jackd tells me:
>>> 
>>> ...
>>> Sorry. The PCM device "cmipci"doesn't support the same sample format for ca
>p
>>ture and playback.We cannot use this PCM device.
>>> ...
>>> 
>>> and jackd quits.
>>
>>this is likely because the newer version of cmipci driver supports
>>24bit SPDIF output, but no input yet...
>
>a reminder that for some time now, JACK supports the -P option which
>limits it to playback only. useful if that's all you want and/or all
>your hardware can do.
>
>--p

well, using jack-0.90.0/alsa-driver-0.9.8 now seems to work just fine again for full duplex using jacks default (in other words i can capture off of spdif using hw:0, which didn't work with jack-0.80). so great! (btw playback using hw:0,2 still throws my system into the same weird state, but i can ignore that now). thanks for listening!  i guess jack capturing off of hw:0 was a jack issue, and jack playing back to hw:0,2 is an alsa-issue? (but i don't know very much, so i could be very wrong).

btw sorry about the multiple posts before...got too cute with multiple email addresses.

thanks again.

-j

--------
Jonathan Kraut
NYC
jak76@columbia.edu


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
