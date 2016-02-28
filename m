From: Scott Doty <scott@ponzo.net>
Subject: Creative ca0132 on Gigabyte Z170X Gaming 7
	motherboard: no sound
Date: Sat, 27 Feb 2016 18:47:23 -0800
Message-ID: <56D25FBB.2020201@ponzo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c.ponzo.net (c.ponzo.net [69.12.221.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 691ED2604FC
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2016 03:47:26 +0100 (CET)
Received: from eva.ponzo.net (gwh.ponzo.net [64.142.21.173])
 by c.ponzo.net (8.14.9/8.14.5) with ESMTP id u1S2lOb7002947
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2016 18:47:26 -0800
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Didn't see a response on alsa-user, so thought I'd better roll up my
sleeves and get to work. :)

The ca0132 codec seems to do everything on my Gigabyte Z170X Gaming 7
motherboard but make sound.  I can see the mixer settings, change them,
even see the DSP settings -- but no sound out, either with HP or SPDIF.

  
http://www.alsa-project.org/db/?f=6373811de293125e4e8c345c0c2d4a736c1fc2b8

I do see this in the startup messages:

[    9.314893] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio
client
[    9.321116] snd_hda_intel 0000:00:1f.3: failed to add i915 component
master (-19)

I've tried all the fixes I could find reference to, as well as using
iecset, but no joy.  I also tried editing the driver to disable the
"vga_switcheroo" flag, but that didn't work either.  (Which is too bad,
I thought that would be a quick fix that I could report. :/ )

If someone could point me in the right direction, I think I can
investigate this and get it working.

Any assistance greatly appreciated.

Thanks,

 -Scott
