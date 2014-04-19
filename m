From: Rob Janssen <pe1chl@amsat.org>
Subject: Control the exact moment of output
Date: Sat, 19 Apr 2014 20:21:20 +0200
Message-ID: <5352BEA0.3050807@amsat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pe1chl.nl.eu.org (pe1chl.nl.eu.org [89.18.172.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BCF52615C0
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 20:21:23 +0200 (CEST)
Received: from linux.pe1chl.ampr.org (linux.pe1chl.ampr.org [44.137.41.97])
 by sys2.pe1chl.ampr.org (8.14.4/8.14.4/Debian-4) with ESMTP id s3JILMq5000983
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 20:21:22 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by linux.pe1chl.ampr.org (8.14.7/8.14.7) with ESMTP id s3JILKU4024815
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 20:21:20 +0200
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

For a distributed system that requires synchronized output I would like to determine
the exact moment when output samples are sent, preferably within +/- 1 sample time.
For example, output is sent in blocks with a system time in usec or nsec as a parameter
or header, and the the first sample leaves the soundcard as closely as possible to the
specified system time.

Is this possible within the ALSA API?
Low latency is of course nice to have, but not the prime concern. What I need is
synchronous output between systems that are physically separated and need to send
audio that they receive from a central system over the network.
My intention is to send blocks of audio with an accurate time of transmission in the
header, and then have the systems output it exactly at that time, of course preferably
managed mostly by the driver, not the application.

Are some types of soundcard more suitable than others for this purpose?  And are
there soundcards available where the sample clock can somehow be locked to system
time or an external 10MHz/1PPS reference?

Rob
