From: Dan Swain <sp4md4n@gmail.com>
Subject: emu10k1 (Audigy) FXBus routing query
Date: Thu, 24 May 2012 19:12:05 -0600
Message-ID: <20120524191205.46ee44bb6a05223b249cadfc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D0673243A6
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2012 03:12:33 +0200 (CEST)
Received: by ggnk3 with SMTP id k3so513916ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2012 18:12:33 -0700 (PDT)
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

Dear all,

I am writing to ask how to route certain DSP 'outputs' from my Audigy 2 ZS
back into the equivalent 'ASIO inputs' for recording purposes.

Specifically, I'd like to route outputs from the Wavetable Synths on my
card to inputs that would go straight into a DAW (such as Ardour), so that
I can apply effects, record and mix-down as if they were external synth
signals.

I know that with the kX project drivers in Windows this is possible, by
routing the Synth outputs to FXBus outputs 16-63, leaving the ASIO inputs
as 0-15 for the audio input, and then patching which channels I require
from the Synth to those inputs (e.g. Synth Channel 1 -> FXBus out 16&17 ->
FXBus in 0&1).

After reading a thread that contained responses from Jaroslav, I believe
the answer is in emufx.c, but I'm unsure as to where to start as I need to
assign the outputs from the Synths correctly first.

Thanks in advance! Any help would be greatly appreciated!

Kind Regards,

Dan
-- 
Dan Swain <sp4md4n@gmail.com>
