From: Jason Holmes <jason@exonerated.net>
Subject: DELL SP2309W Monitor with Integrated microphone
Date: Tue, 17 Mar 2009 02:24:29 -0700
Message-ID: <ea9198010903170224k1493b353r2a683766b955f7de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 77933103883
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 10:24:30 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so1174876ywa.2
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 02:24:29 -0700 (PDT)
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

Hi all,
I have a Dell SP2309W monitor which contains an integrated webcam and
microphones.  I have been unable to get the integrated microphones to record
any sound.  I ran utils_alsa-info.sh and the link with the results in posted
below:
http://www.alsa-project.org/db/?f=590e122a466ce09cd1f911ba7146a87df2b5cbeb
The integrated microphone seems to be made by OmniVision Technologies.
The results of running arecord -l are:
**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: CONEXANT Analog [CONEXANT Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Webcam [Monitor Webcam], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: default [USB Sound Device        ], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
and the results of arecord --device=default:CARD=Webcam test  are:
ALSA lib pcm_direct.c:866:(snd1_pcm_direct_initialize_slave)
snd_pcm_hw_params_any failed
ALSA lib pcm_dsnoop.c:604:(snd_pcm_dsnoop_open) unable to initialize slave
arecord: main:590: audio open error: Invalid argument


Thanks for your help.
-- 
Jason Holmes
