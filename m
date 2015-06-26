From: Christian Gruber <christian.gruber@voiceinterconnect.de>
Subject: Using plughw device and samplerate conversion with an
 ALSA driver not supporting memory mapped access
Date: Fri, 26 Jun 2015 15:19:15 +0200
Message-ID: <558D5153.9060000@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd27002.kasserver.com (dd27002.kasserver.com [85.13.145.216])
 by alsa0.perex.cz (Postfix) with ESMTP id C56F6264F40
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 14:57:26 +0200 (CEST)
Received: from Mail-Gateway (ip923447ca.dynamic.kabel-deutschland.de
 [146.52.71.202])
 by dd27002.kasserver.com (Postfix) with ESMTPSA id 8DCD31120093
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 14:57:30 +0200 (CEST)
Received: from kepler.vic.site ([192.168.13.149])
 by Mail-Gateway with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <christian.gruber@voiceinterconnect.de>)
 id 1Z8TCB-0002TI-OB
 for alsa-devel@alsa-project.org; Fri, 26 Jun 2015 14:57:30 +0200
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

Hello,

I have problems using the plughw device with samplerate conversion on an embedded board 
having an ALSA driver, which does not support memory mapped access. The audio codec only 
supports 48 kHz sampling rate. The problem occurs, when I want to playback for instance a 
16 kHz file via plughw device, which is the default device. Interestingly the behaviour of 
the ALSA system is as follows:

    1. aplay -D default audio_16kHz.wav        does not work
    2. aplay -D default -M audio_16_kHz.wav    works correctly

This is quite strange, since although the ALSA driver does not support memory mapped 
access, using the option -M works, but the default read write access method without option 
-M does not, although the driver supports read write access. In this case the function 
snd_pcm_hw_params() returns with an error (EINVAL).

I started debugging this and could see, that in the second case, when using option -M, the 
plughw device establishes the following signal processing chain:

     plughw -> rate -> mmap_emul -> hw

This is what I expected from the plughw device. It first introduces a samplerate converter 
for conversion from 16 kHz to 48 kHz, since the codec only supports 48 kHz. And second it 
introduces a memory mapped access emulator to be able to use memory mapped access method 
on the application side and read write access method on the driver side (hw device).

In the first case without using option -M the plughw device establishes the following 
processing chain:

     plughw -> rate -> hw

This means, it does not introduce a memory mapped access emulator, which is comprehensible 
as well, since the application already uses read write access method, the same as the ALSA 
driver does. But nevertheless an error occurs.

Further debugging showed, that the error occurs in the function hw_refine_call() 
(pcm_hw.c) during the call to _snd_pcm_hw_params_internal() within the function 
snd_pcm_plug_hw_params() (pcm_plug.c). For some reason the rate plugin wants to use memory 
mapped access only on the hw device.

So I ask myself, if this is the expected behaviour of the rate plugin. Does the rate 
plugin only support memory mapped access? If yes, why is no mmap_emul plugin introduced 
into the signal processing chain in this case? If not, why does the rate plugin choose 
memory mapped access method? Is the ALSA driver maybe buggy giving wrong information about 
its hw capabilities?

Can anybody help me?

Regards,
Christian
