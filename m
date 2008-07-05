From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASOC: codec_reg_show and variable length registers
Date: Sat, 5 Jul 2008 09:37:45 -0400
Message-ID: <9e4733910807050637p6583ae25m592aca4c5728a4d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 2228A24474
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jul 2008 15:37:57 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so697012ywk.2
	for <alsa-devel@alsa-project.org>; Sat, 05 Jul 2008 06:37:45 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

codec_reg_show() can't handle my TAS5504 codec. The codec has 104
(sparse out of 256) registers with variable lengths from 1 to 32
bytes.

Should the register cache really be part of the core? The core could
still make the sysfs entries and use a callback to print them.
reg_cache_size/reg_cache_step would then become private.

It's the sprintf that is the problem. I need to push that into my
driver so that I can print out variable lengths. Or we need to make
the core use an indirect table that encodes the lengths.

-- 
Jon Smirl
jonsmirl@gmail.com
