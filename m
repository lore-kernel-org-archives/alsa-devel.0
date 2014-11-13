From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Stale data at start of audio recording on Freescale
 i.MX28 EVK with SGTL5000
Date: Fri, 14 Nov 2014 09:41:56 +1100
Message-ID: <546533B4.90303@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0091.outbound.protection.outlook.com [134.170.140.91])
 by alsa0.perex.cz (Postfix) with ESMTP id 8267F2661AE
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 23:42:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I was testing the 3.14.19 kernel on Freescale i.MX28 EVK. Since then, 
I've retested and confirmed this also on 3.18-rc4 kernel.

I am doing audio recordings through the SGTL5000 driver as such:

     arecord -D hw:0,1 -f s16 -c 2 -r 16000 -d 5 test.wav

I'm finding that the first 400-500 ms of the saved data is actually 
stale data from the end of the previous recording. To see this, do the 
following:

    1. Provide some test audio input in the LINE INPUT jack. E.g. a 100 
Hz sine wave, or some music.
    2. Record audio with e.g. arecord -D hw:0,1 -f s16 -c 2 -r 16000 -d 
5 test1.wav
    3. Change the test audio input, e.g. a 150 Hz sine wave, or some 
different music.
    4. Record a new audio file with e.g. arecord -D hw:0,1 -f s16 -c 2 
-r 16000 -d 5 test2.wav

Observe that the first 400-500 ms of test2.wav contains stale data from 
the end of the previous recording.

-- 
Craig McQueen
