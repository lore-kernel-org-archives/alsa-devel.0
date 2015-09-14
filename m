From: Pavel Machek <pavel@ucw.cz>
Subject: System with multiple arizona (wm5102) codecs
Date: Mon, 14 Sep 2015 13:54:39 +0200
Message-ID: <20150914115439.GA29646@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

I've got an embedded system with two arizona / wm5102 codecs.

Unfortunately, kernel does not seem to be ready for that
configuration.

In particular, drivers/regulator/arizona-ldo1.c and
drivers/regulator/arizona-micsupp.c register system-wide "MICVDD" and
"LDO1" regulators, but with two codecs in the system, we really have
wm5102-codec.1.MICVDD, wm5102-codec.2.MICVDD, wm5102-codec.1.LDO1 and
wm5102-codec.2.LDO1.

That got me second codec working in two-codec configuration, but first
one still stops working as soon as two codecs are enabled.

If you have idea what else needs fixing, let me know.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
