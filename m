From: Fredrik Lingvall <fl@ifi.uio.no>
Subject: Duplex syncronization in ALSA
Date: Tue, 20 Nov 2007 13:58:42 +0100
Message-ID: <4742DA02.9020108@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pat.uio.no (pat.uio.no [129.240.10.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 3273724A04
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 13:58:44 +0100 (CET)
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

I am an researcher in the field of acoustic (ultrasonic) signal 
processing. Normally we use dedicated hardware where the transmit and 
receive processes are synchronized. Now I want to use a multi-channel 
sound card (in my case a RME Multiface card) to perform, for example, 
simple beamforming. Typically, one transmit pulses on an array of 
transducers (speakers) where each pulse is delayed a certain amount to 
create focusing or beemsteering. By knowing the soundspeed in the 
propagation medium one can calculate the double path time-of-flight to 
various points and then, by beamforming the received signals, one can 
get an image of the objects that are in front of the acoustic array.

Now to my problem: in order to do the processing one need to know the 
delay in the system from transmit to receive. I have looked at the ALSA 
lib API docs and some code examples (pcm.c, aplay etc) and it looks like 
the playback and capture processes are independent in ALSA (i.e., there 
is no write-and-read-at-the-same-time function). The latency inherent in 
the soundcard isn't that much of a problem if it is know. It is, however 
a problem if the latency from transmit to receive is not constant from 
measurement to measurement. I have written some code (for Octave) that 
uses MMAP and poll:ing but I don't see how to synchronize the write and 
read processes (they use two different poll fd:s). What is the best way 
to do this? Is it possible at all?

Regards

/Fredrik
