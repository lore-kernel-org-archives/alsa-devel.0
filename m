From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Trying to understand alsa
Date: Thu, 12 Jan 2012 21:44:11 +0000
Message-ID: <1326404651.22083.28.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id BAC8E24352
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 22:40:34 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q0CLi9i6020010
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 21:44:16 GMT
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

Hi people, i'm trying to understand alsa....

I have an application that works using 512 sample packets of 22050Hz 16
bit mono audio.  The 'receiver' takes many audio streams from a network
via UDP, at the moment it pipes them into pulse.

Can alsa buffer audio. At the moment every time I and set an audio
buffer size I get a negative response from
snd_pcm_hw_params_set_buffer_size .  I'm somewhat confused about the
units alsa uses ...

What I want to do is tell ALSA to hold a buffer of 3 of my packets (3 x
1024Bytes, thats 512 x 16 bit samples) while I feed extra packets (1K
Byte, 512 samples per buffer) in for playback.  The packets are arriving
at roughly the correct rate, I just need a buffer to  iron out any
jitter in network transmit, do I have to do this myself ?

Can somebody help by telling me which numbers I push into which places
to make it work ?

At the moment I get i keep getting a broken pipe, if I underrun how can
I make it just wait for me ?

I only code in plain old C at the moment.

Many thanks for any help/advice anyone can offer.

Jon
