From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA ymfpci - Add "Playback" to FM Legacy
 Volume control
Date: Mon, 12 Sep 2011 16:02:05 +0200
Message-ID: <4E6E10DD.2060508@ladisch.de>
References: <CAN8cciZ=vOBPK-EFKpX8f7tsUYqPZ5bZk1F_4nYYoDf_yGia-w@mail.gmail.com>	<4E6CD899.2090000@ladisch.de>
	<CAN8cciaqt_eBLGeSA0XYaLt0B5R1M0ituHt-DDFrZHRazcR_gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id AF881103874
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 16:01:46 +0200 (CEST)
In-Reply-To: <CAN8cciaqt_eBLGeSA0XYaLt0B5R1M0ituHt-DDFrZHRazcR_gA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> How accurate is the ymfpci timer ?

The period interrupts are not accurate at all.  The ymfpci hardware
internally uses fixed periods of 256 frames at 48 kHz; the driver
reports a period interrupt when the next hardware interrupt at or after
a period boundary occurs.  The current position reported by the hardware
is the position at the time of the last hardware interrupt.

> my ymf724f seem play quite well with alsa "hw" device but with bad
> noise with alsa-pulse plugin (e.g. aplay when not using default period
> times )  and it also occurrs on   benshee on ubuntu 11.4 live cd

It should be possible to increase accuracy by using the hardware period
parameters (48 kHz _and_ 256 frames/period).

TODO: implement support for the NORESAMPLE flag.


Regards,
Clemens
