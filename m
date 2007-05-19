From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: Firmware to add - Dreamcast AICA
Date: Sat, 19 May 2007 20:52:50 +0100
Message-ID: <92a12cdb0705191252i2621585cw8d2f942eb0fa453e@mail.gmail.com>
References: <92a12cdb0705181541l3af0ad7cm6c236968ff229dd0@mail.gmail.com>
	<s5habw0eue6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id C2C1F24523
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 21:52:52 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so1569626nzf
	for <alsa-devel@alsa-project.org>; Sat, 19 May 2007 12:52:51 -0700 (PDT)
In-Reply-To: <s5habw0eue6.wl%tiwai@suse.de>
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

The code it is built with is BSD licenced - it comes (originally) from
Kallistios (a game devel system - here:
http://gamedev.allusion.net/svn/snapshots/

A copy of the source is also here:
http://linuxdc.cvs.sourceforge.net/linuxdc/linux-sh-dc/sound/oss/aica/firmware/

The firmware module should be in the standard directory (/lib/firmware/)

For a document:

The Dreamcast comes with an ARM7 processor that handles sound
processing and has its own 2MB of RAM. The firmware is a short piece
of code that starts/resets the ARM7 and establishes buffers for a left
and a right hand channel and proceeds to 'play' the data in them. Most
of the main (SH4) driver code is concerned with managing the transfer
of data into those two buffers.

The C code for the firmware is taken from the Kallistios game
development system and is licenced under BSD terms. It is copyright
2000 to Dan Potter and can be reviewed at
http://linuxdc.cvs.sourceforge.net/linuxdc/linux-sh-dc/sound/oss/aica/firmware/

To ensure this works with your Dreamcast please ensure the file
aica_firmware.bin is placed in the /lib/firmware/ directory.


On 19/05/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 18 May 2007 23:41:08 +0100,
> Adrian McMenamin wrote:
> >
> > Please add this to the firmware repo
>
> Any notes on copyright and license?  Where to be installed?
> A brief document would be appreciated, too.
>
>
> thanks,
>
> Takashi
>
