From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ERROR: USB Sound card with unsafe characters
Date: Mon, 29 Feb 2016 10:42:14 +0100
Message-ID: <56D41276.9080506@ladisch.de>
References: <CADKQKXYmcT8eOf9wH=Do_0RTk1RGBwMwTY0hvyNoXxVEwptWRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 72406260515
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 10:42:15 +0100 (CET)
In-Reply-To: <CADKQKXYmcT8eOf9wH=Do_0RTk1RGBwMwTY0hvyNoXxVEwptWRg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Jones <g0ukb@ivarc.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Brian Jones wrote:
> I don't know how to get this bug to the developers

Just send it to the alsa-devel list.  Once.

> My USB soundcard is an Asus Xonar U7 Echelon Edition
> <https://www.asus.com/Sound-Cards/Xonar_U7_Echelon_Edition/> which
> identifies itself to alsa as "Xonar U7 Echelon Ed." The card is supported
> by alsa and works well in analog mode but I cannot get digital output via
> alsa.
>
> Attempts to change the iec958 device in USB-Audio.conf fail because of the
> period char and apparently my level of OS (Mint 17.3 based on Ubuntu 14.04,
> kernel 3.19.0-32) does not have alsa supporting USB vendorid:productid
> naming

The vendor:product naming is used only for device that do not have a name.
The newer version of alsa-lib would replace unsafe characters (like '.')
with an underscore.


Try changing /usr/share/alsa/cards/USB-Audio.conf.  Dont add an entry to
the USB-Audio.pcm.iec958_device list near the top, but go to the bottom,
to the USB-Audio.pcm.iec958.0 definition, and change this:

USB-Audio.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD { type string }
	@args.AES0 { type integer }
	@args.AES1 { type integer }
	@args.AES2 { type integer }
	@args.AES3 { type integer }
	@func refer
	name {
		...(lots of stuff)...
	}
	default {
		...(lots of stuff)...
	}
}

to this:

USB-Audio.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD { type string }
	@args.AES0 { type integer }
	@args.AES1 { type integer }
	@args.AES2 { type integer }
	@args.AES3 { type integer }
	type hw                         # no @func
	card $CARD
	device 1
}

(This will break S/PDIF on all other USB devices, but who cares ...)


Regards,
Clemens
