From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Turtle Beach Tahiti (snd-msnd-classic)
Date: Mon, 30 Aug 2010 16:59:46 +0200
Message-ID: <F5D2EA2BCBDF9247A489B479BEB484B60B02A45912@sicily.nmmu.ac.za>
References: <F5D2EA2BCBDF9247A489B479BEB484B60B02A45910@sicily.nmmu.ac.za>,
	<s5h1v9gabn6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.nmmu.ac.za (ra.nmmu.ac.za [192.96.15.50])
	by alsa0.perex.cz (Postfix) with ESMTP id B173724142
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 16:59:16 +0200 (CEST)
In-Reply-To: <s5h1v9gabn6.wl%tiwai@suse.de>
Content-Language: en-ZA
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "krzysztof.h1@wp.pl" <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Thank you very much for responding.

>> Loading the ALSA driver for a Turtle Beach Tahiti fails quietly, with the following anomalies:
>> 1. dmesg says "Assuming PnP mode", despite isapnp=0 option
>The message is confusing.  The isapnp is assumed silently also when no
>cfg option is given.

>> 3. Type: sudo modprobe snd-msnd-classic isapnp=0 io=0x3e0 irq=10 mem=0xd0000
>Try to add cfg option value.  It's either 0x250, 0x260 or 0x270.

modprobe snd-msnd-classic isapnp=0 cfg=0x250 io=0x3e0 irq=10 mem=0xd0000

responds with:
FATAL: Error inserting snd_msnd_classic (/lib/modules/2.6.32-24-generic/kernel/sound/isa/msnd/snd-msnd-classic.ko): Unknown symbol in module, or unknown parameter (see dmesg)

dmesg says:
snd_msnd_classic: Unknown parameter 'cfg'

Thank you again for taking the time to advise me.
Kind regards,
Mark Brand.

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
