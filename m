From: "paul blakeley" <pblakeley@gmail.com>
Subject: latency issues
Date: Wed, 21 Nov 2007 11:44:32 +0000
Message-ID: <27342b300711210344x78bc6ab2v7f7315b755c2c6bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 349C124BF0
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 12:44:41 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so1036675ele
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 03:44:39 -0800 (PST)
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

I am currently trying to measure the latency through my alsa
application.  I will briefly explain my application and set-up.  The
application has a test harness which sends audio data to my
application.  To measure the latency the test harness reads in a .wav
file(one which I have generated.  This contains a short pulse of a
sine wave.  The rest being zero data.) and also drives the serial port
at the point were it detects the sine pulse.  As previously explained
the audio data is passed through my application and the alsa driver.
The difference then between the start of the sine pulse and the output
from the sound card is the latency through the system.  I measure this
with an oscilloscope.  Also just to note the test harness is driven
from the same sound card as the application, so there should be no
difference clocks.

Now that I have explained the test scenario, I will explain the
behaviour that I am experiencing.  To start off, starting the test
harness at different instances revealed that the latency measurement
is different by maybe 20ms or so, although the alsa buffer levels
indicate all is correct.  Once started the behaviour is such that the
difference drifts ever so slightly.  After around 10 minutes the
output flips to the beginning and the process starts again.  This
happens continuously.

Without establishing the cause of this problem will ultimately mean
the measurement is useless.  Could this issue be related to the serial
port, alsa buffering, kernel scheduling etc.  Can somebody with the
relevant experience help.  Please.
