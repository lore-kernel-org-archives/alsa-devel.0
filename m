From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH - snd-powermac 0/1] Driver tree
Date: Tue, 20 Jan 2009 22:02:40 +0200
Message-ID: <46e1c7760901201202i68e8799ew230fee63e2c16f5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f16.google.com (mail-bw0-f16.google.com
	[209.85.218.16])
	by alsa0.perex.cz (Postfix) with ESMTP id E537410384A
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:12:47 +0100 (CET)
Received: by bwz9 with SMTP id 9so182254bwz.8
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 12:12:47 -0800 (PST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I still wonder, what about these:

--- a/acinclude.m4.org	2008-11-12 12:04:39.000000000 +0200
+++ b/acinclude.m4	2009-01-13 15:04:03.000000000 +0200
@@ -1828,6 +1828,7 @@
       CONFIG_SND_TIMER="m"
       CONFIG_SND_PCM="m"
       CONFIG_SND_POWERMAC="m"
+      CONFIG_SND_VMASTER="y"
     fi
   fi
   if alsa_check_kconfig_option "powermac-auto-drc"; then
--- a/configure.org	2008-11-12 12:04:44.000000000 +0200
+++ b/configure	2009-01-13 15:04:31.000000000 +0200
@@ -16071,6 +16071,7 @@
       CONFIG_SND_TIMER="m"
       CONFIG_SND_PCM="m"
       CONFIG_SND_POWERMAC="m"
+      CONFIG_SND_VMASTER="y"
     fi
   fi
   if alsa_check_kconfig_option "powermac-auto-drc"; then

They were needed in making alsa-driver-1.0.18a for the new vmaster
controls, but I couldn't see the files in your driver-tree.

Risto
