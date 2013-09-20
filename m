From: Bruce <abruceperson@gmail.com>
Subject: Alsa mmap and asynchronous callbacks
Date: Fri, 20 Sep 2013 13:03:40 +1000
Message-ID: <523BBB0C.4020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B74261B01
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 05:03:48 +0200 (CEST)
Received: by mail-pd0-f182.google.com with SMTP id r10so9190068pdi.13
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 20:03:47 -0700 (PDT)
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

Hi,

I tried posting a query related to async callbacks on the alsa-user 
list, and the Hammerfall forum, but noone appeared to know what I was 
talking about. I'm hoping someone here can at least give me some clues.

*Working:*
I wrote an application, based around the alsa example code 
alsa-lib/test/pcm.c using mmap and asynchronous callback notifications. 
This application runs fine with 32 channels in and 2 out on a Hammerfall 
MADI system and under alsa 1.0.15. It now works on 2 different machines 
setup with SUSE 10, then with alsa (and card driver) upgraded to 1.0.15.
alsamixer is used to setup the soundcard in 96kHz mode (double speed).
/Note:/ For some reason (I can't recall) I never managed to get the  
playback async callback to work at the same time as capture callback, so 
I simply called the playback "top-up" routine from the capture async 
routine. That works fine.
The application was used for some years !

*Problem:*
SUSE 11 with alsa 1.0.18, same machine, same sound card, application 
hangs after a few callbacks. No more asynchronous callbacks occur after 
approx 1s of playback/record. However, the callbacks are working for a 
short time.
alsamixer looks quite different for the Hammerfall with this newer alsa, 
and it does appear to be the change of alsa driver that causes the problem.

SUSE 11/Ubuntu with alsa 1.0.27. I tried this configuration in order to 
try a different Xonar sound card. The application was modified for only 
2 channels, and interleaved instead of non-interleaved sample format (as 
required by the hardware if not using plughw). Both Xonar and Hammerfall 
hang in the same way.

aplay and alsamixer both work with both soundcards.

The alsa calls I'm using do not appear to be in the deprecated list 
(except  "snd_pcm_sw_params_set_xfer_align" in 1.0.27).

Would you like me to post code fragments ?

/Note: /As a workaround, I attempted to install the working 1.0.15 under 
the later kernal in Suse 11. Unfortunately ./configure fails in 
alsa-driver due to differing kernel hooks. It is not realistic to stay 
with the very old SUSE 10; much of the machine hardware is not recognised.

-- 
Cheers,
Bruce
