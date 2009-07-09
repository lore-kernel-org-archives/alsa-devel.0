From: Louis Lee <lwhlee@hotmail.com>
Subject: While recording from mono codec twice as much data is
	received
Date: Thu, 9 Jul 2009 15:27:17 -0600
Message-ID: <COL102-W427E3B6FA3A27688387EAED0260@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s7.col0.hotmail.com (col0-omc3-s7.col0.hotmail.com
	[65.55.34.145]) by alsa0.perex.cz (Postfix) with ESMTP id F1B6824487
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jul 2009 23:27:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi everyone,
  I am able to do playback from 8 kHz samples to 48 kHz samples properly.
  However, when recording using the exact same setup for the data interface I am not getting favorable results.  For instance, if I record for 5 seconds I get output in a file for 10 seconds of audio (arecord or sox).  This results in my recording being stretched.  I change the DAI to stereo capture and record two channels and the recorded output comes back correctly (5 seconds recorded is 5 seconds).
  I'm using a wolfsom WM8974.  I'm developing using ASoC framework (can I call it that?) reusing the WM8974 codec from the Linux GIT repository.  The development is using a i.MX27.  Data interface is a SSI bus in DSP mode.  I believe my PCM code is correct since it works for playback.
  I'm stuck now.  From my understanding the clocks are setup the same way for both playback and capture.  Has anyone ran into this problem before?  The WM8974 is a mono codec so I should not have to set the DAI to stereo in order to capture data properly.
  Any help is appreciated.
Best regards,Louis
_________________________________________________________________
Attention all humans. We are your photos. Free us.
http://go.microsoft.com/?linkid=9666046
