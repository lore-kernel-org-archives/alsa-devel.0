From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-fireworks requires larger period sizes than
	FFADO
Date: Tue, 1 Dec 2015 18:15:46 +0100
Message-ID: <565DD5C2.5040804@ladisch.de>
References: <56510A5F.4080004@gmx.de> <5652ED38.6080409@ladisch.de>
 <20151201153111.4f7a0e1f@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E65CE261AFF
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 18:15:55 +0100 (CET)
In-Reply-To: <20151201153111.4f7a0e1f@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Stefan Richter wrote:
> is there a strict requirement that the ALSA period is more than double of
> the FireWire interrupt period?

No.  But the ALSA API promises that interrupts arrive at the end of
a period (which always has a constant size), and with the FireWire packet
sizes varying, this is the easiest way of ensuring that interrupts are
delayed by less than half the period size.

The driver should dynamically reduce the interrupt interval for smaller
periods.

> Also, I believe to remember that you once said that instead of relying on
> periodical interrupts from the OHCI, it might be better to switch to a
> kind of polling scheme (i.e. process the IEEE 1394 packet buffer on an
> own period = ALSA period?).

This is already implemented by calling fw_iso_context_flush_completions().

It helps with PulseAudio (which predicts the correct time to poll), but is
useless when the application relies on the interrupt to wake it up (e.g.,
Jack).


Regards,
Clemens
