From: Francesco Sportolari <francesco@unipg.it>
Subject: [bug 1080] [PATCH] 2.6.0-t3: alsa driver snd-powermac doesn't work with tumbler chip on ibook2
Date: Sun, 17 Aug 2003 23:54:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200308172354.06944.francesco@unipg.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: DiegoCG@teleline.es, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

During the insmod of the snd-powermac module this msg is printed to the 
console:

tumbler: cannot initialize the MCS

After that, even if the module is loaded correctly, the sound doesn't work at 
all.

I've noticed that removing and inserting again the 'i2c-keywest' module solves 
the problem. The following patch fixes this issue related to early 
initialization of the i2c client in the driver.

Bye,
-- Francesco

--- orig/sound/ppc/tumbler.c    2003-08-16 17:18:35.000000000 +0200
+++ linux-2.6.0-test3/sound/ppc/tumbler.c       2003-08-16 17:18:55.000000000 
+0200
@@ -996,9 +996,6 @@
                chipname = "Snapper";
        }

-       if ((err = snd_pmac_keywest_init(&mix->i2c)) < 0)
-               return err;
-
        /*
         * build mixers
         */
@@ -1025,6 +1022,9 @@
        if ((err = tumbler_init(chip)) < 0)
                return err;

+       if ((err = snd_pmac_keywest_init(&mix->i2c)) < 0)
+               return err;
+
 #ifdef CONFIG_PMAC_PBOOK
        chip->resume = tumbler_resume;
 #endif
