From: wm4 <nfxjfg@googlemail.com>
Subject: [BUG] dmix reports channel layouts that are not
	supported
Date: Thu, 11 Dec 2014 15:48:33 +0100
Message-ID: <20141211154833.66054938@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F1A926500C
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 15:48:40 +0100 (CET)
Received: by mail-wi0-f176.google.com with SMTP id ex7so14802243wid.15
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 06:48:40 -0800 (PST)
Received: from debian (p4FF01420.dip0.t-ipconnect.de. [79.240.20.32])
 by mx.google.com with ESMTPSA id iz19sm3232912wic.8.2014.12.11.06.48.38
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Dec 2014 06:48:39 -0800 (PST)
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

Opening a dmix device (i.e. "default" on most distros), and calling
snd_pcm_query_chmaps() on it, returns some surround audio channel maps,
for example 5.1. Trying to set it with snd_pcm_set_chmap() will fail
with ENXIO. Only setting the stereo channel map succeeds, and I suppose
dmix supports stereo only.

I think this should be considered a bug. dmix probably merely passes
through the channel layout of the underlying device, even though it
supports stereo only - this behavior makes no sense at all. Any device
should strictly report supported channel maps only.

To make matters worse, if you intend to play 5.1, and dmix fails in
the manner described above, then it will report "FL FR NA NA NA NA" as
channel map. This would require the application to pad stereo with 4
channels of silence, which requires extra code and is generally just
stupid.
