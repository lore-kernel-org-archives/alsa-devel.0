From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the sagacontinues (cardbus driver=culprit?) MORE UPDATE
Date: Sun, 04 Apr 2004 10:53:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404041453.i34ErSJX004745@dhin.linuxaudiosystems.com>
References: <20040404114902.2c1664cc@laptop>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 04 Apr 2004 11:49:02 +0200."
             <20040404114902.2c1664cc@laptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Blechmann <TimBlechmann@gmx.net>
Cc: linux-pcmcia@lists.infradead.org, ritsch@iem.at, Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>mainly the alsa guys who wrote the driver and know, how they access the
>bus system and the hardware, have to tell the pcmcia guys, who know,
>what's going on in the bus ... i CC'd this mail to the thomas
>charbonnel, paul davis and winfried ritsch, who wrote or maintain this
>driver and the alsa-devel list ...
>i doubt that i'm able to understand either the cardbus or the alsa side
>of the driver in a reasonable time ... 

there is no "cardbus side" of the driver.

a cardbus device appears to an ALSA driver (and i suspect to the
kernel as well) as a completely regular PCI device. unless you go
"fishing" for evidence, there is no way to tell that the device is not
a regular PCI device.

there is nothing in the ALSA driver for the HDSP that is conditional
on the h/w being a cardbus device or not, because we don't (and likely
can't) know that it is.

sorry. FWIW, i have an ENE 1411 and it works OK with my hdsp at period
sizes below a certain threshold. i don't know if its the same problem
or not.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
