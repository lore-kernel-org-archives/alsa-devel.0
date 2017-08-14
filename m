From: =?UTF-8?Q?Oleksandr_M=c3=bcller?= <sanj3k@gmail.com>
Subject: Detailed information about asoc framework
Date: Mon, 14 Aug 2017 20:24:06 +0200
Message-ID: <748f911e-26f4-6f49-3343-468ccd879f0f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C56C266CB8
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 20:24:06 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id y206so15319924wmd.5
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 11:24:06 -0700 (PDT)
Received: from ?IPv6:2a02:8108:4b40:11c0:901c:6622:ee43:5772?
 ([2a02:8108:4b40:11c0:901c:6622:ee43:5772])
 by smtp.gmail.com with ESMTPSA id v9sm5304623wmg.41.2017.08.14.11.24.04
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Aug 2017 11:24:04 -0700 (PDT)
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

Hello Alsa developers!

I am developing an asoc driver for a hat sound card for a raspberry pi 
3. It has a pcm5142 dac (which has already a codec driver in the linux 
kernel code) and a pcm1863 adc which isnt supported by the codec repo. 
Can I find detailed information about the asoc layer, the components and 
accesses from the os, in which order what builds up etc.

Right now I have a device tree overlay with 2 sound links and a minimal 
piece of code as the codec driver which even maps and shows (with aplay 
and arecord command) the soundcard as a capture and playback device. The 
overlay connects the codec driver through i2c.

Do you need more information? Hope you can help me with some sort of 
guides or explanations to better understand.

Oleksandr
