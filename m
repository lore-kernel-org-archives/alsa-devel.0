From: public-hk <public-hk@ind.rwth-aachen.de>
Subject: Some questions related to ALSA based duplex audio
	processing
Date: Sun, 29 Jan 2012 20:19:45 +0100
Message-ID: <4F259BD1.4030001@ind.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-2.ms.rz.rwth-aachen.de (mta-2.ms.rz.RWTH-Aachen.DE
	[134.130.7.73]) by alsa0.perex.cz (Postfix) with ESMTP id 5F146246D8
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 20:19:46 +0100 (CET)
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.186])
	by mta-2.ms.rz.RWTH-Aachen.de
	(Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
	with ESMTP id <0LYK000BTR0XQWE0@mta-2.ms.rz.RWTH-Aachen.de> for
	alsa-devel@alsa-project.org; Sun, 29 Jan 2012 20:19:45 +0100 (CET)
Received: from mail.ind.rwth-aachen.de
	(mail.ind.RWTH-Aachen.DE [137.226.238.9])	by smarthost.rwth-aachen.de
	(8.14.4+Sun/8.13.8/1) with ESMTP id q0TJJjXI024612	for
	<alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 20:19:45 +0100 (CET)
Received: from [137.226.198.65] (pontos.ind.RWTH-Aachen.DE [137.226.198.65])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail.ind.rwth-aachen.de (Postfix)
	with ESMTP id AED521674132	for <alsa-devel@alsa-project.org>; Sun,
	29 Jan 2012 20:19:45 +0100 (CET)
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

Hi,

I have just started to develop a duplex audio processing application 
based on ALSA.
My development goals are - of course - maximum stability as well as 
lowest possible delay (latency).

So, here is what I did on my Ubuntu laptop:

1) Setup of device/soundcard "hw:0,0" for processing at a samplerate of 
44.1 kHz, buffersize 128 samples.
2) I created one input PCM device and one output PCM device handle
3) I use the function "snd_async_add_pcm_handler" to install a callback 
function (ASYNC mode), one for input,
one for output.
4) I use "snd_pcm_link" to synchronize both pcm handles.
5) I use the mmap'ed area access

My motivation to work the way I do is to maximize the control of 
processing behavior and to
minimize the latency. E.g., I have understood from the docs that the 
snd_pcm_read/snd_pcm_write
functions do nothing else than addressing the memory mapped areas. As a 
conclusion, I realize
this access myself to have more control about it.
And by using the async callbacks, I do not have to deal with blocking or 
non-blocking read functions or polling related issues.

So far, I have realized the playback part and noticed some aspects which 
are not clear to me from the ALSA documentation:

a) What is the most efficient way to realize duplex audio processing, 
the async way with mmap'ed read/write that I follow?
b) At first, I created the pcm handles as follows: "snd_pcm_open (.., 
SND_PCM_ASYNC);" When starting to process audio (call of 
"snd_pcm_start"), I realized that the registered callback functions do 
not get called. I had to change this to "snd_pcm_open (.., 0);". Is that 
really intended, it seems contradictory?
c) The function "snd_pcm_info_get_sync" is supposed to return a 
description of the synchronization
behavior of a soundcard. In my case, I called this function for two 
soundcards (one USB and the laptop integrated soundcard).
In both cases, the returned content is all zeros. Should not this be 
different for both devices?
d) By default, it seems that the callbacks for audio frames come within 
a thread with normal priority.
On Windows OS, I am used to increase the thread priority whenever 
starting my threads, but it is commonly not a good idea to increase the 
process priority.
In the ALSA latency-example, the PROCESS priority is increased (which 
can be done only with superuser priv.).
What is the recommended way in Linux to achieve lower latencies?


In the future I will have to deal with synchronization of input and 
output since the samples arrive/leave my application in two independent 
callback functions. So what will I do: Once input samples are available 
I will store these in one buffer, and these samples will be output
the next time when there is space in the output ring buffer. In order to 
minimize the latency, I
would need to know more about the intended exact behavior of the ALSA 
lib which I did not find in the
documentation:

I) If linking input and output with "snd_pcm_link", I have understood 
that the changes of state for input and
output PCM handle will occur synchronously. That is, when doing the 
operation such as "snd_pcm_prepare" on one
of the handles, both handles will be affected. However, what does this 
means for audio processing on the frame
level: If I use two callbacks for signal processing for input and output 
respectively installed based on the
function "snd_async_add_pcm_handler", will these callbacks occur 
simultaneously? On Windows OS (speaking of ASIO sound) there is
one callback in which input and output is handled simultaneously. Can I 
somehow setup ALSA to have a similar behavor?

Thank you for any assistance and best regards

HK
