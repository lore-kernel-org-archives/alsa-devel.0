From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Intel HD: ALC662 noise-bug on FitPC2i
Date: Wed, 12 Dec 2012 14:05:00 +0100
Message-ID: <50C880FC.20409@ladisch.de>
References: <1355321775-2042-1-git-send-email-mengdong.lin@intel.com>
 <50C83190.7050001@aasimon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id EB1F82616A8
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 14:05:01 +0100 (CET)
In-Reply-To: <50C83190.7050001@aasimon.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bent Bisballe Nyeng <deva@aasimon.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bent Bisballe Nyeng wrote:
> When recording, audible clicking sounds are present in the resulting
> audio data.
>
> The corruption are composed of approximately 10 samples, and the
> nature of the corrupted values are such that they could come from an
> earlier buffer (the corrupted data resemble wav forms).

This looks like a problem with your HDA controller; either the memory
bus is overloaded so that some writes are dropped, or the hardware is
just buggy.


Regards,
Clemens
