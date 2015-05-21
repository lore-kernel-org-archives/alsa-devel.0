From: Michele Curti <michele.curti@gmail.com>
Subject: writing an alsa driver
Date: Thu, 21 May 2015 16:52:32 +0200
Message-ID: <20150521145232.GA12157@dellaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id AF9472614DD
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 16:52:37 +0200 (CEST)
Received: by wizk4 with SMTP id k4so17764919wiz.1
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 07:52:37 -0700 (PDT)
Received: from dellaz (host79-90-static.72-81-b.business.telecomitalia.it.
 [81.72.90.79])
 by mx.google.com with ESMTPSA id v20sm32500536wjr.49.2015.05.21.07.52.35
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Thu, 21 May 2015 07:52:36 -0700 (PDT)
Content-Disposition: inline
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

Hi all,
I'm going to *try* to "write" a driver for the sound card on my new laptop,
an asus x205ta.

To be fair I have almost no experience but I'm hoping that all the code is
already present and it only needs some adaptations.

The cpu is a intel bay trail z3735f, the sound card is a realtek rt5648 that
has the same product Id of the rt5645 (0x6308).

I see in kernel sources:
 - the codec driver
	sound/soc/codecs/rt5645.c
 - a baytrail board that uses the rt5640
	sound/soc/intel/boards/byt-rt5640.c
 - a braswell board that uses the rt5645
	sound/soc/intel/boards/cht_bsw_rt5645.c

What do you think?  Is it feasible, given a good amount of free-time? :p

Thanks,
Michele
