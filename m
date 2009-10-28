From: Adrian Bridgett <adrian@smop.co.uk>
Subject: update documentation to match MAX_PCM_SUBSYSTEMS
Date: Wed, 28 Oct 2009 13:41:16 +0000
Message-ID: <20091028134116.GA2096@vasquez.smop.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.smop.co.uk (smop.co.uk [81.5.177.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A3861037EE
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 14:41:21 +0100 (CET)
Content-Disposition: inline
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In this patch, MAX_PCM_SUBSTREAMS was increased:
http://gitorious.org/linux-omap/mainline/commit/b888d1ce82ebd2bafecf64c765754968e78b4228

However the MODULE_PARAM_DESC was not updated to match.  Patch attached.

Adrian
-- 
bitcube.co.uk - Linux infrastructure consultancy
Puppet, Debian, Red Hat, Ubuntu, CentOS, ...

--y0ulUmNC+osPPQO6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="dummy.c.patch"

--- sound/drivers/dummy.c.orig	2009-10-28 13:39:59.000000000 +0000
+++ sound/drivers/dummy.c.new	2009-10-28 13:40:27.000000000 +0000
@@ -165,7 +165,7 @@
 module_param_array(pcm_devs, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_devs, "PCM devices # (0-4) for dummy driver.");
 module_param_array(pcm_substreams, int, NULL, 0444);
-MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-16) for dummy driver.");
+MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-128) for dummy driver.");
 //module_param_array(midi_devs, int, NULL, 0444);
 //MODULE_PARM_DESC(midi_devs, "MIDI devices # (0-2) for dummy driver.");
 module_param(fake_buffer, bool, 0444);

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--y0ulUmNC+osPPQO6--
