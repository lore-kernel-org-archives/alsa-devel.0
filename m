From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: ALSA 1.0.25 broke AC3 passthrough?
Date: Mon, 6 Feb 2012 23:38:42 +1100
Message-ID: <CANpj82+DPJGg1vUvm-otVEWEeXwK8zOy4ZAGjFH81oc5n51CTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E520103AB5
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 13:38:43 +0100 (CET)
Received: by yhr47 with SMTP id 47so2394724yhr.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 04:38:42 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

Today, I installed 1.0.25 drivers and libraries...
AC3 passthrough is completely broken.

My hardware: NVidia GT430, hdmi output
Device used:
hdmi:CARD=NVidia,DEV=0,AES0=6,AES1=0x82,AES2=0x00,AES3=0x01
on Ubuntu 10.04 LTS (but using manually built alsa)

It makes the application hangs or behaves incorrectly. All the time
broken, no matter which app.
Reverting back to 1.0.24 fixes the problem

I haven't delved much into it yet,
MythTV (I am the audio developer) after opening the audio device in
passthrough mode, trying to write audio on the pcm just hangs and
result in an I/O error after a little while
snd_pcm_writei returns an error (not immediately)
snd_pcm_state(pcm_handle) returns 3, snd_strerror(err) returns
"Input/output error"

mplayer just hangs...

nothing obvious in the logs, audio device opens okay, i can't say I
notice much difference in opening the device, allocating fragment and
the lot.

Anyone else has seen this?

Jean-Yves
