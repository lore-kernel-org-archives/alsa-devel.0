From: Martin Pietryka <martin.pietryka@streamunlimited.com>
Subject: DSD: Playing silence before and after actual audio data
Date: Thu, 15 Oct 2015 15:01:56 +0200
Message-ID: <561FA3C4.8040205@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp4.bon.at (bsmtp4.bon.at [195.3.86.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A231260453
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 15:01:57 +0200 (CEST)
Received: from [10.1.14.177] (vpn.streamunlimited.com [91.114.0.140])
 by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nc9jx23gzz5tlW
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 15:01:57 +0200 (CEST)
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

Hi guys,

I'm trying to figure out the best way to insert ~40ms worth of silence 
pattern before and after playing back DSD data.

There seems to be support inside ALSA for a DSD silence pattern, but as 
far as I have seen it's only used when an underrun might occur 
(silence_threshold, silence_size).

Is there some possibility inside ALSA to basically insert silence before 
and after playback, or how hard would it be to implement something like 
this? I have looked a bit for myself and for me it seems that the 
modifications needed inside ALSA to achieve this feature are 
substantial, but of course I also might have missed something.

Martin
