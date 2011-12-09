From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: It looks like snd-soc-rx51 only works as built-in, not as a module
Date: Sat, 10 Dec 2011 01:04:49 +0200
Message-ID: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Pretty much $subject. Any ideas about why?

# cat /proc/asound/cards
--- no soundcards ---

There's no error message or anything, and rx51_soc_init() exists properly.

Cheers.

-- 
Felipe Contreras
