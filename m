From: Adam Rosenberg <adam@alcorn.com>
Subject: Problem with underrun on new CS42448 x2 driver
Date: Tue, 24 Aug 2010 15:47:13 -0400
Message-ID: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 39F9324494
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 21:47:13 +0200 (CEST)
Received: by vws20 with SMTP id 20so6546781vws.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 12:47:13 -0700 (PDT)
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

I am trying to write a driver for the Blackfin BF537 processor on a custom
board that has two CS42448 CODECs connected to SPORT0.  I am using TDM and
there are 8 channels per frame on each data line (primary and secondary).
My DMA buffer must interleave the data for the two data lines (for a total
of 16 channels of data per frame).  I have completed all of this and the
driver will sometimes work properly but I am having underrun problems.  I
would like to use snd_async_add_pcm_handler as it is used in the /test/pcm.c
example but it seems as though an underrun occurs at regular intervals
causing the PCM prepare function to be called again (this results in a tone
that sounds good but only for a short time before it stops and then starts
again).

There is plenty of time for the data to be transferred.  I feel as though
the driver is not calling snd_pcm_period_elapsed fast enough.  At the
moment, I call snd_pcm_period_elapsed from within a callback function that
occurs every time a DMA period elapse occurs.  I have been working on this
for quite a while now.  Is there someone who can look at the driver code for
me or provide detailed information on when ALSA expects to have
snd_pcm_period_elapsed get called to avoid an underrun?

The other thing that is strange is that I have to explicitly set the period
size for aplay to work.  For example:
aplay --period-size=1024 test.wav
which gives me a period time of 21333 but when I use this period time with
the /test/pcm.c sample that is provided the tone still does not sound right
(although it does seem to improve)

I am about ready to bypass ALSA entirely but I hate the idea of breaking
from standards (not to mention having to rewrite an entire audio
interface).  Any help would be greatly appreciated!

You can check out the driver here:
http://www.alcorn.com/ftp/swap/ami_cs42448.zip

Thank you,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
