From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 15:34:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311172034.hAHKYD7v013915@oud.linuxaudiosystems.com>
References: <200311172049.14303.pwk.linuxfan@gmx.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 17 Nov 2003 20:48:50 +0100."
             <200311172049.14303.pwk.linuxfan@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> the RME hardware has 16-26+ channels, but only one stream.
>
>Ok,
>
>here we come to my ignorance on sound drivers/hardware/terminology. If I ta=
>lk=20
>about a stream I mean one application --> soundcard link. What would a=20
>channel be ? And what a stream if not what I defined a line up?=20
>Maybe this is off topic though, and propably I should google it.

a stream is an independently controllable data path. on the RME cards,
you can't stop and start channel 19 etc. - the whole thing runs as one
engine. as a result, the ALSA hw driver doesn't create multiple
streams for the device - even if one app is only using 2 of the many
available channels. this is intentional.

--p


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
