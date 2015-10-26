From: Erik de Castro Lopo <mle+la@mega-nerd.com>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Mon, 26 Oct 2015 20:54:31 +1100
Message-ID: <20151026205431.e306afd9e96991ebe7fa7889@mega-nerd.com>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
 <562D376E.7000308@ladisch.de>
 <20151026194701.7258eceaea5cb7a7a41bcf94@mega-nerd.com>
 <562DEF9C.8090706@ladisch.de>
 <20151026202321.cc3f5496a60a9369542d6be6@mega-nerd.com>
 <562DF600.8020809@ladisch.de>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hendrix.mega-nerd.net (hendrix.mega-nerd.net [203.206.230.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 952B926060E
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 10:54:33 +0100 (CET)
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
 by hendrix.mega-nerd.net (Postfix) with SMTP id CDAA9C06BF
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 20:54:31 +1100 (AEDT)
In-Reply-To: <562DF600.8020809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> To get the current parameters of the device, use snd_pcm_hw_params_current().

Ah, that makes sense. Now I get:

    ACCESS:  RW_INTERLEAVED
    FORMAT:  S32_LE
    SUBFORMAT:  STD
    SAMPLE_BITS: [0 0]
    FRAME_BITS: [64 64]
    CHANNELS: [2 2]
    RATE: [48000 48000]
    PERIOD_TIME: [6250 6250]
    PERIOD_SIZE: [300 300]
    PERIOD_BYTES: [0 0]
    PERIODS: [0 0]
    BUFFER_TIME: [0 0]
    BUFFER_SIZE: [1200 1200]
    BUFFER_BYTES: [9600 9600]
    TICK_TIME: [0 0]

Why is SAMPLE_BITS == [0 0], even though the format is S32_LE?

Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
