From: korgman <korgie@gmail.com>
Subject: arecord - bug with big file?
Date: Sun, 04 May 2014 23:30:23 +0300
Message-ID: <5366A35F.4040308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B1CEB261A66
 for <alsa-devel@alsa-project.org>; Sun,  4 May 2014 22:30:09 +0200 (CEST)
Received: by mail-ee0-f41.google.com with SMTP id t10so1117667eei.14
 for <alsa-devel@alsa-project.org>; Sun, 04 May 2014 13:30:09 -0700 (PDT)
Received: from [192.168.10.40] ([176.92.197.24])
 by mx.google.com with ESMTPSA id cb5sm23591511eeb.18.2014.05.04.13.30.07
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 04 May 2014 13:30:08 -0700 (PDT)
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

Bugtracker is down ->
https://bugtrack.alsa-project.org/alsa-bug
from main page ->
http://alsa-project.org

So, excuse my reporting here.

I can't record with arecord for long periods.

time arecord -f dat -D hw:0,0 | aplay
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

real	186m25.375s
user	1m26.204s
sys	0m20.772s

It seems that this bug was also reported there.
https://bugzilla.redhat.com/show_bug.cgi?id=213783

cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version k3.12.9x40-122l. (custom kernel)

arecord --version
arecord: version 1.0.27.1 by Jaroslav Kysela <perex@perex.cz>

I now trying with sox (rec test.wav) to check if sox is ok.

Thank you for reading this!
