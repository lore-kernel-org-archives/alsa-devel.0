From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 52/52] bebob: Add support for M-Audio
 special Firewire series
Date: Tue, 25 Feb 2014 21:04:21 +0100
Message-ID: <530CF745.40309@ladisch.de>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
 <1391006977-11572-3-git-send-email-o-takashi@sakamocchi.jp>
 <530CA27D.2000306@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 762E7265648
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 21:04:55 +0100 (CET)
In-Reply-To: <530CA27D.2000306@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Can I request your comment for this patch about a quirk of transaction?
>
> M-Audio Firewire 1814 and ProjectMix I/O often send no response against
> driver's request, even if the device handle the request.
>
> For CMP and Isochronous Resource Management, this quirk works badly.
> When a request from driver is handled by the device but the device
> don't respond, the drivers (firewire_core/snd-firewire-lib) retry the
> request. Then a response for the second request brings error because
> the operation for connection or isochronous resource management is
> already done in device side.

Maybe we should change how these functions handle timeouts.  Any other
error code indicates that the lock transaction failed definitely, but
after a timeout, we don't know if it was the request or the response
that got lost.

We could try to read the register, and, if we see that the change that we
tried to do actually happend, assume that our driver's transaction did
this change.

Are read transactions more reliable than locks?  If not, we might need
to increase the number of retries for these devices.

> Against this quirk, I want to merge this patch for upstream

This patch (no. 52) does not change the CMP code.


Regards,
Clemens
