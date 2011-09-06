From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: alsa/asoundlib.h file not found
Date: Tue, 6 Sep 2011 15:47:31 +0530
Message-ID: <CAODvfaHhEHp5aYQ2CkeLTZvOVLP+8Ncq8VCpDtOeTPE4N0Fg8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id EE1F02464B
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 12:17:32 +0200 (CEST)
Received: by ywt32 with SMTP id 32so3756053ywt.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Sep 2011 03:17:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have integrated the codec driver and the kernel log shows the sound
card is detected.
now i want to test the codec. i tried the sample test code for capture
and playback.

i am getting a compilation errors due to the asoundlib.h.
please find the error log for my application.

main.c:2:23: error: asoundlib.h: No such file or directory
main.c: In function 'main':
main.c:7: error: 'snd_pcm_t' undeclared (first use in this function)
main.c:7: error: (Each undeclared identifier is reported only once
main.c:7: error: for each function it appears in.)
main.c:7: error: 'pcm_handle' undeclared (first use in this function)
main.c:10: error: 'snd_pcm_stream_t' undeclared (first use in this function)
main.c:10: error: expected ';' before 'stream'
main.c:15: error: 'snd_pcm_hw_params_t' undeclared (first use in this function)
main.c:15: error: 'hwparams' undeclared (first use in this function)
main.c:22: warning: 'return' with a value, in function returning void
main.c:34: error: 'snd_pcm_uframes_t' undeclared (first use in this function)
main.c:34: error: expected ';' before 'periodsize'
main.c:46: error: 'SND_PCM_ACCESS_RW_INTERLEAVED' undeclared (first
use in this function)
main.c:48: warning: 'return' with a value, in function returning void
main.c:52: error: 'SND_PCM_FORMAT_S16_LE' undeclared (first use in
this function)
main.c:54: warning: 'return' with a value, in function returning void
main.c:62: warning: 'return' with a value, in function returning void
main.c:65:19: warning: missing terminating " character
main.c:65: error: missing terminating " character
main.c:66: error: expected expression before '==' token
main.c:66: error: stray '\' in program
main.c:66:31: warning: missing terminating " character
main.c:66: error: missing terminating " character
main.c:67: error: expected ';' before '}' token
main.c:72: warning: 'return' with a value, in function returning void
main.c:78: warning: 'return' with a value, in function returning void
main.c:86: error: 'periodsize' undeclared (first use in this function)
main.c:88: warning: 'return' with a value, in function returning void
main.c:99: warning: 'return' with a value, in function returning void
main.c:112: warning: incompatible implicit declaration of built-in
function 'malloc'
main.c:115: error: 'num_frames' undeclared (first use in this function)
main.c:5: warning: return type of 'main' is not 'int'

please suggest what needs to be done to resolve this issue asap.

Thank you,
Sreedhar.
