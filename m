From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: strange code in pcm_route.c for 3 byte formats
Date: Sun, 19 Nov 2017 23:42:13 +0100
Message-ID: <b5b7e7f2-ff97-11d0-1e72-c119842dd266@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 68ADC266E76
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 23:42:15 +0100 (CET)
Received: by vps-vb.mhejs.net with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.87)
 (envelope-from <mail@maciej.szmigiero.name>) id 1eGYI2-0003Tu-BZ
 for alsa-devel@alsa-project.org; Sun, 19 Nov 2017 23:42:14 +0100
Content-Language: en-US
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

While reading alsa-lib sources I've spotted some strange code in
src/pcm/pcm_route.c:
       /* 3 bytes formats? */
       route->params.use_getput =
               (snd_pcm_format_physical_width(src_format) + 7) / 3 == 3 ||
               (snd_pcm_format_physical_width(dst_format) + 7) / 3 == 3;

Since snd_pcm_format_physical_width() returns a width in bits it seems to me
that this would mean formats that are between 2 and 4 bits (inclusive) wide.

Before commit de63b942acf520 ("pcm: route: Use get/put labels for all 3 byte formats")
this read as:
       route->params.use_getput = snd_pcm_format_physical_width(src_format) == 24 ||
               snd_pcm_format_physical_width(dst_format) == 24;

The commit message of that commit says that this change was supposed to set
this flag also for 18 and 20-bit physical width formats.

Is there a mistake in this code or am I wrong somewhere in my thinking?

Best regards,
Maciej
