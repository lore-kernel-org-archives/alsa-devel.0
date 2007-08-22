From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Audio quality issue - regular clicks are observed
Date: Wed, 22 Aug 2007 22:13:39 +0530
Message-ID: <61445c750708220943k1c410147pa0dddf4d950eb08c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EA3D24430
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 18:43:43 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so248598wag
	for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2007 09:43:40 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi
While testing the audio driver using aplay in blocking mode, a periodic
murmur is observed, this increases with
the audio volume and occurs even when there are no issues like xrun etc.
Aplay was used in normal read/write mode
i.e. no mmap. The song can be heard properly i.e. with no noticable gaps aur
hisses but the clicks are audible.

I have tried various combinations of period size and buffer size but the
quality doesn't seem to improve. I checked
the latency between to consecutive calls of snd_pcm_write in aplay and log
is as follows.

I am having 16 periods of 1K size and from log it is seen that the latency
is too much at the buffer boundary, i.e. higlighted and starred line in the
logs. I think the clicks are caused due these huge delays since the clicks
are also quite periodic. Any thoughts?


#aplay -Dhw:0,0 --rate=44100 --format=S16 --channels=2
 --period-size=1024 --buffer-size=16384 Learning.wav

   1
   2 Latency = 0.000000
   3 Latency = 0.001805
   4 Latency = 0.000741
   5 Latency = 0.000674
   6 Latency = 0.000643
   7 Latency = 0.000668
   8 Latency = 0.000625
   9 Latency = 0.000611
  10 Latency = 0.000647
  11 Latency = 0.000627
  12 Latency = 0.000626
  13 Latency = 0.000635
  14 Latency = 0.000631
  15 Latency = 0.000616
  16 Latency = 0.000645
  17 Latency = 0.000634
  18 Latency = 0.000958
  19     Avg Latency is => 0.000737
  20
  21 Latency = 0.371909              /********Too much latency***********/
  22 Latency = 0.000767
  23 Latency = 0.000701
  24 Latency = 0.000696
  25 Latency = 0.000657
  26 Latency = 0.000677
  27 Latency = 0.000667
  28 Latency = 0.000673
  29 Latency = 0.000674
  30 Latency = 0.000627
  31 Latency = 0.000675
  32 Latency = 0.000880
  33 Latency = 0.000726
  34 Latency = 0.000682
  35 Latency = 0.000705
Latency = 0.000648
  37     Avg Latency is => 0.023898
  38
  39 Latency = 0.361167        /********Too much latency***********/
  40 Latency = 0.000744
  41 Latency = 0.000692
  42 Latency = 0.000678
  43 Latency = 0.000672
  44 Latency = 0.000637
  45 Latency = 0.000696
  46 Latency = 0.000668
  47 Latency = 0.000674
  48 Latency = 0.000885
  49 Latency = 0.000710
  50 Latency = 0.000670
  51 Latency = 0.000663
  52 Latency = 0.000654
  53 Latency = 0.000667
  54 Latency = 0.000676
  55     Avg Latency is => 0.023222
  56
  57 Latency = 0.361260      /********Too much latency***********/
  58 Latency = 0.000710
  59 Latency = 0.000703
  60 Latency = 0.000685
  61 Latency = 0.000671
  62 Latency = 0.000665
  63 Latency = 0.000796
  64 Latency = 0.000714
  65 Latency = 0.000692
  66 Latency = 0.000704
  67 Latency = 0.000695

-Pharaoh
