From: "vasudha rao" <vasudha.jrao@gmail.com>
Subject: Unable to play aplay
Date: Wed, 10 Sep 2008 18:16:56 +0530
Message-ID: <eeb9eca50809100546w5475ebffqafd3d1e8224206c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 254A5243D1
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 14:46:58 +0200 (CEST)
Received: by ag-out-0708.google.com with SMTP id 22so6282893agd.8
	for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2008 05:46:57 -0700 (PDT)
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

Hi ,

I want to play and record audio file in my custom atmel 9263 board running
with linux(2.6.20).
when I tried to play aplay for a wave file, I got

$aplay /home/alarm.wav
ALSA lib pcm.c:1707:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:446: audio open error: No such file or directory

$aplay -l
aplay: device_list:187: no soundcards found...

$cat /proc/asound/devices
  2:        : timer
  3:        : sequencer
  4: [ 0- 0]: digital audio playback
  5: [ 0]   : control

Can you tel me where I am doing wrong..??

Thanks in advance..
