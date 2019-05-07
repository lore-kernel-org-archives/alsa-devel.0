From: Matt Flax <flatmax@flatmax.org>
Subject: cs4265 : alsactl store and "C data buffer" fails
Date: Tue, 7 May 2019 11:06:28 +1000
Message-ID: <bdc0a30f-c6f3-8ccb-f556-1d1a6a68f3b9@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE4F2F80C07
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 03:06:37 +0200 (CEST)
Content-Language: en-AU
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

Hi,

When alsactl store is run with a cs4265 chip, the following error occurs 
(from https://github.com/Audio-Injector/Ultra/issues/25) :

$ sudo alsactl store
alsactl: get_control:256: Cannot read control '2,0,0,C Data Buffer,0': 
Input/output error


Upon commenting out the C data buffer control it works :

https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs4265.c#L163


Can you suggest a suitable method for fixing this bug ?


thanks

Matt
