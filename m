From: "conn intel" <connintel@gmail.com>
Subject: Problem using arecord and aplay
Date: Tue, 8 Jan 2008 20:18:09 +0530
Message-ID: <e842129b0801080648n5068a377na707b6b5b2a56054@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 825D124B16
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 15:48:10 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so5166184rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 08 Jan 2008 06:48:09 -0800 (PST)
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

Dear Friends,

I am using kernel 2.6.22.2, and  following alsa library and utilities :
alsa-lib-1.0.14a & alsa-utils-1.0.14. I am having problem executing arecord
and aplay alsa utilities. After executing below command it returns
immeaditely to command prompt with following messages. The command and
output::

# arecord -c 2 -d 10 -f S16_LE -r 44100 -t wav /home/test.wav
Recording WAVE '/home/test.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, St
ereo
ALSA sound/arm/as352x-audio.c:1153: len:15888
arecord: set_params:1012: unable to install sw params:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 10
silence_threshold: 0
silence_size: 0
boundary: 1445068800
#

waiting for any comments or suggestions.

Thank you,

Ankur.
