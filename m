From: Johan Bilien <bilien@imit.kth.se>
Subject: Recording problem on cs46xx on recent linux kernels
Date: Fri, 10 Dec 2004 14:59:55 +0100
Message-ID: <1102687196.10057.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.ssvl.kth.se (mail.ssvl.kth.se [192.16.125.102])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E4263260
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 14:57:16 +0100 (MET)
Received: from coruscant.bilien.org (lauga.ssvl.kth.se [192.16.125.77])
	by mail.ssvl.kth.se (8.12.10/8.12.8) with ESMTP id iBADgppj019229
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 14:42:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by coruscant.bilien.org (Postfix) with ESMTP id 52F2592951
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 15:01:31 +0100 (CET)
Received: from coruscant.bilien.org ([127.0.0.1])
	by localhost (coruscant [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30525-05 for <alsa-devel@alsa-project.org>;
	Fri, 10 Dec 2004 15:01:31 +0100 (CET)
Received: from client-197.ssvl.kth.se (client-197.ssvl.kth.se [192.16.127.197])
	by coruscant.bilien.org (Postfix) with ESMTP id D8D08928E6
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 15:01:30 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

since moving from kernel 2.6.9 to 2.6.10-rc2 and -rc2-bk4, I was happy
to see that hardware mixing is now supported on my hardware
(CrystalClear SoundFusion Audio Accelerator on a IBM T22). However I
have also been experiencing a new problem when recording from the
soundcard: a readi returns -5 after about 5 seconds, with parameters
that used to work. I'm using libalsa v1.0.7 (Debian unstable) and Linux
2.6.10-rc2-bk4 with cs46xx and "New DSP support".

The /proc says that the capture PCM is running, but the available field
remains to 0. 

10/12 14:56 /proc/asound/card0/pcm0c/sub0% cat status
state: RUNNING
trigger_time: 1102686881.461093000
tstamp      : 1102687019.388211000
delay       : 0
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 0

10/12 14:57 /proc/asound/card0/pcm0c/sub0% cat hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 8000 (8000/1)
period_size: 8
buffer_size: 320
tick_time: 1000

10/12 14:57 /proc/asound/card0/pcm0c/sub0% cat sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 8
xfer_align: 8
start_threshold: 1
stop_threshold: 2147483647
silence_threshold: 0
silence_size: 0
boundary: 1342177280

Thanks,
Johan.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
