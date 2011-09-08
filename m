From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: (no subject)
Date: Thu, 08 Sep 2011 13:03:55 +0200
Message-ID: <4E68A11B.6020901@ladisch.de>
References: <SNT119-W1384D4FE439227CEE049BBA41E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 0054924A0A
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 13:03:29 +0200 (CEST)
In-Reply-To: <SNT119-W1384D4FE439227CEE049BBA41E0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: A S <kokoshmusun@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A S wrote:
> There is some outdated messages around that imply that there was work
> being done to have the ESI Maya 44 PCI card work with ALSA.  However,
> it seems to have been stalled.  Can anyone confirm the status of this
> card with regard to ALSA? 

README.maya44 says:
| The following functions work, as tested by Rainer Zimmermann and Piotr
| Makowski:
| 
| - playback and capture at all sampling rates
| - input/output level
| - crossmixing
| - line/mic switch
| - phantom power switch
| - analogue monitor a.k.a bypass
| 
| The following functions *should* work, but are not fully tested:
| 
| - Channel 3+4 analogue - S/PDIF input switching
| - S/PDIF output
| - all inputs/outputs on the M/IO/DIO extension card
| - internal/external clock selection


Regards,
Clemens
