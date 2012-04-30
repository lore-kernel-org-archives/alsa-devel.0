From: jamesm <jamesm@filmlight.ltd.uk>
Subject: Issue with RME HDSPe AIO latency
Date: Mon, 30 Apr 2012 17:03:19 +0100
Message-ID: <966796f1b91b7bc3fee7ce5b7779be75@filmlight.ltd.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b.mx.filmlight.ltd.uk (b.mx.filmlight.ltd.uk [77.107.81.251])
	by alsa0.perex.cz (Postfix) with SMTP id E391D24411
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 18:03:20 +0200 (CEST)
Received: from zeta.filmlight.ltd.uk (localhost.localdomain [127.0.0.1])
	by zeta.filmlight.ltd.uk (8.13.8/8.13.8) with ESMTP id q3UG3JBu026104
	for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2012 17:03:19 +0100
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

Hello all,

I'm using the RME hdspm kernel module with a Hammerfall HDSPe AIO card. 
I'm on RHEL 5.5, with alsa 1.0.17, kernel 2.6.18-194.11.4.

I have backported the latest alsa hdspm code to this kernel, as there 
were a number of bugs in the one that ships with the 2.6.18-194 kernel. 
I've also implemented support for copy() and silence() functions so that 
the hdspm driver can be used with applications via the RDWR interface 
instead of just MMAP (ie it just works with aplay without using plughw 
first.)

The latest hdspm driver code from alsa and kernel.org indicates that 
the HDSPe AIO card has a fixed buffer size of 16384. I've chosen a 
period size of 1024, which gives me 16 periods.

The issue I have is that whenever I play audio through the hdspm 
driver, the delay between the hw pointer and sw pointer is always close 
to the maximum buffer size (approx 16000). This leaves me with a large 
delay between writing data into the PCM and it coming out of the card. 
I'd like this to be between 1024 and 2048, I could probably crank the 
period down further to 512.

My application sets the start_threshold to 0 and avail_min to one 
period (1024). It then runs a thread, constantly writing data to the PCM 
(silence or real data).

Does anyone have any suggestions as to why the hdspm driver hw pointer 
is not following the application pointer more closely?

Is it due to the number of periods? Unfortunately I can't change that 
as the AIO buffer size is fixed.

Here are my pcm hwparams, swparams and status from /proc/asound when my 
app is running:

$ cat /proc/asound/card0/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: RME AIO
name: RME AIO
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

$ cat /proc/asound/card0/pcm0p/sub0/hw_params
access: RW_NONINTERLEAVED
format: S32_LE
subformat: STD
channels: 16
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 16384
tick_time: 1000

$ cat /proc/asound/card0/pcm0p/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1024
xfer_align: 1
start_threshold: 0
stop_threshold: 18446744073709551615
silence_threshold: 0
silence_size: 0
boundary: 4611686018427387904

$ cat /proc/asound/card0/pcm0p/sub0/status
state: RUNNING
trigger_time: 1335799965.972782000
tstamp      : 1335801526.687332000
delay       : 15664
avail       : 720
avail_max   : 1056
-----
hw_ptr      : 74911440
appl_ptr    : 74927104

Regards
James Milne
FilmLight Ltd.
