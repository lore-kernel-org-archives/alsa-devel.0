From: VDR User <user.vdr@gmail.com>
Subject: Bug in setting channels,
	related to recent ELD/EDID changes?
Date: Wed, 22 Dec 2010 18:22:53 -0800
Message-ID: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EDF2224747
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 03:22:53 +0100 (CET)
Received: by iwn42 with SMTP id 42so6405536iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 18:22:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.  After updating my stable kernel from 2.6.35.7 to 2.6.36.2, I get
a problem when tuning HDTV channels that use surround sound.  The
error I get is as follows:

audio_alsa_out: Cannot set number of channels to 6 (err=-22:Invalid argument)
audio_out: open failed!

With the following xine error:
---------------------- (ERROR) ----------------------
The audio device is unavailable. Please verify if another program
already uses it.

['Audio device unavailable' '']
------------------ (END OF ERROR) -------------------

This problem did not exist in 2.6.35.7 alsa drivers (using
snd-hda-intel).  I have noticed that there has been recent changes
associated with ELD/EDID that sets limitations on channels.  First of
all I think this is a horrible idea since many devices don't even
contain correct EDID.  It's simply too unreliable to use.  Secondly,
could the above problem be related to those changes?

If anyone knows a fix for this or can point me in the right direction
(aside of going back to 2.6.35.7), PLEASE fill me in.

Here are some system specs:
debian testing
kernel snd-hda-intel driver used for hdmi audio on nvidia gt240 video card
hdmi going to 7.1 surround sound receiver & setup

Any help is greatly appreciated!

Best regards,
Derek
