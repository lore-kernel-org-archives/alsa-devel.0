From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Alsa-utils: Fix typo causing some volumes not
	to be initialized
Date: Wed, 11 Jan 2012 17:45:14 +0100
Message-ID: <1326300314-3421-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id A28C1246EC
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2012 17:45:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When I was reading the source code, I stumbled over this typo causing
Center, LFE, and Surround speakers not to be initialized.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsactl/init/default |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/alsactl/init/default b/alsactl/init/default
index af64cb1..5fb0113 100644
--- a/alsactl/init/default
+++ b/alsactl/init/default
@@ -124,7 +124,7 @@ CTL{name}="Front Speaker Playback Switch",CTL{do_search}=="1", \
   CTL{values}="on"
 
 CTL{reset}="mixer"
-CTL{name}="Front Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
+CTL{name}="Surround Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
 # if master volume control is present, turn speaker volume to max
 ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
 ENV{has_pmaster_vol}=="true",CTL{write}=="100%",GOTO=""
@@ -134,7 +134,7 @@ CTL{name}="Surround Speaker Playback Switch",CTL{do_search}=="1", \
   CTL{values}="on"
 
 CTL{reset}="mixer"
-CTL{name}="Front Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
+CTL{name}="Center Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
 # if master volume control is present, turn speaker volume to max
 ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
 ENV{has_pmaster_vol}=="true",CTL{write}=="100%",GOTO=""
@@ -144,7 +144,7 @@ CTL{name}="Center Speaker Playback Switch",CTL{do_search}=="1", \
   CTL{values}="on"
 
 CTL{reset}="mixer"
-CTL{name}="Front Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
+CTL{name}="LFE Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
 # if master volume control is present, turn speaker volume to max
 ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
 ENV{has_pmaster_vol}=="true",CTL{write}=="100%",GOTO=""
-- 
1.7.5.4
