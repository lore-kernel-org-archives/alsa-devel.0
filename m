From: niraj kulkarni <kulkarniniraj14@gmail.com>
Subject: Re: Fw:  [Bug 1155202] [Intel DZ77SL-50K,
 Intel PantherPoint HDMI, Digital Out, HDMI] No sound at all
Date: Mon, 10 Feb 2014 11:35:41 +0530
Message-ID: <CACWODjSKJ7yy6dvH3iCiHLvFgYokgmeSy06mYyGnX4N5JKtkEg@mail.gmail.com>
References: <52ef1e8f.a4c3440a.53f1.fffff564SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B2642610B7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 07:05:42 +0100 (CET)
Received: by mail-vc0-f175.google.com with SMTP id ij19so4384149vcb.20
 for <alsa-devel@alsa-project.org>; Sun, 09 Feb 2014 22:05:42 -0800 (PST)
In-Reply-To: <52ef1e8f.a4c3440a.53f1.fffff564SMTPIN_ADDED_BROKEN@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, david.henningsson@canonical.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Removing these 3 usleep ranges is working now. Although I have a doubt for
applying this patch on all chips. There have been a number of boards
released after this particular board, but nobody else is facing this
problem. Since spec does not specify a max on deasserting RST, some boards
might actually take more than 100uS to reset. Will this patch work for
those boards?

@@ -1149,7 +1149,7 @@
        timeout = jiffies + msecs_to_jiffies(100);
        while ((azx_readb(chip, GCTL) & ICH6_GCTL_RESET) &&
                        time_before(jiffies, timeout))
-               usleep_range(500, 1000);
+               cpu_relax();
 }

 /* exit link reset */
@@ -1162,7 +1162,7 @@
        timeout = jiffies + msecs_to_jiffies(100);
        while (!azx_readb(chip, GCTL) &&
                        time_before(jiffies, timeout))
-               usleep_range(500, 1000);
+               cpu_relax();
 }

 /* reset codec link */
@@ -1180,7 +1180,7 @@
        /* delay for >= 100us for codec PLL to settle per spec
         * Rev 0.9 section 5.5.1
         */
-       usleep_range(500, 1000);
+       //usleep_range(500, 1000);

        /* Bring controller out of reset */
        azx_exit_link_reset(chip);
