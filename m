From: Andy Shevchenko <andy@smile.org.ua>
Subject: Fix typo in the ALC883 initial code
Date: Mon, 3 Dec 2007 17:43:37 +0200
Message-ID: <20071203154337.GB22118@serv.smile.org.ua>
References: <20071203153010.GF32513@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8379724364
	for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2007 16:46:49 +0100 (CET)
Resent-Message-ID: <20071203154648.GC22118@serv.smile.org.ua>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <20071203153010.GF32513@serv.smile.org.ua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy@smile.org.ua>
List-Id: alsa-devel@alsa-project.org

Hi!

The attached patch should fix typo in auto initialization verbs for ALC883
codec.

--- alsa-kernel/pci/hda/patch_realtek.c.orig        2007-11-16 03:00:00.000000000 +0300
+++ alsa-kernel/pci/hda/patch_realtek.c     2007-12-03 21:35:50.000000000 +0300
@@ -7098,7 +7098,7 @@
        {0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
        {0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
        /* {0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)}, */
-       {0x23, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(4)},
+       {0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(4)},

        { }
 };

Signed-off-by: Andy Shevchenko <andy@smile.org.ua>

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
