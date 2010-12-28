From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Channel conversion automatic or not?
Date: Tue, 28 Dec 2010 13:35:29 -0800
Message-ID: <AANLkTikQGCXj9KELWk_HaJN+dBS4phSQW93W0AQ2w7Rd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7788624608
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 22:35:31 +0100 (CET)
Received: by wyi11 with SMTP id 11so9402033wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 13:35:29 -0800 (PST)
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
In my driver I have specified that the hardware supports only two channels.
However, if I try playing mono input files on this system I get:
Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono
aplay: set_params:1041: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 22050
PERIOD_TIME: (371519 371520)
PERIOD_SIZE: 8192
PERIOD_BYTES: 8192
PERIODS: 4
BUFFER_TIME: (1486077 1486078)
BUFFER_SIZE: 32768
BUFFER_BYTES: 32768
TICK_TIME: 0

If I try playing the same file through the virtual device that I specified
in asoundrc file like this:

pcm.mydev {
    type plug
    slave {
        pcm default
        channels 2
    }
}

and I do aplay -Dmydev test.wav
File plays no problem.
I guess the question is shouldn't ALSA convert this data automatically or
the only way to get this to work is through plugin as I did?
Cheers
Ogi
