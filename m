From: Daniel Drake <dsd@laptop.org>
Subject: Crackly sound with dmix rate 48000
Date: Mon, 09 Nov 2009 13:34:34 +0000
Message-ID: <1257773674.2180.27.camel@polyethylene>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C421103863
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 14:34:37 +0100 (CET)
Received: by fxm1 with SMTP id 1so3541868fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2009 05:34:37 -0800 (PST)
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

In our musical activities, the OLPC/Sugar platform uses csound which in
turn uses ALSA for playing sounds.

On our latest XO hardware model, where we now use HDA instead of cs5536,
we are experiencing some crackly sounds from our csound-based
applications. Other apps are fine.

We discovered that changing the dmix rate from 48000 to 44100 solves the
cracklyness.

What does this indicate?

Might csound be producing sounds at rate 44100, which dmix previously
had to convert to 48000, which was too taxing to the system?

Any suggestions for how to diagnose this further? (or would changing the
rate be seen as a reasonable thing to do in this situation?)

Thanks,
Daniel
