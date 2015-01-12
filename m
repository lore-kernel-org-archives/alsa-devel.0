From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] alsactl/init: Add "Line Out" to list of
	outputs to initialize
Date: Mon, 12 Jan 2015 16:48:38 +0100
Message-ID: <1421077718-4147-2-git-send-email-david.henningsson@canonical.com>
References: <1421077718-4147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B3932260537
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 16:48:46 +0100 (CET)
In-Reply-To: <1421077718-4147-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsactl/init/default | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/alsactl/init/default b/alsactl/init/default
index 64f933f..1c84f3e 100644
--- a/alsactl/init/default
+++ b/alsactl/init/default
@@ -43,6 +43,16 @@ CTL{name}="Master Digital Playback Switch",CTL{do_search}=="1", \
   CTL{values}="on"
 
 CTL{reset}="mixer"
+CTL{name}="Line Out Playback Volume",PROGRAM!="__ctl_search",GOTO=""
+# if master volume control is present, turn line out volume to max
+ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
+ENV{has_pmaster_vol}=="true",CTL{write}=="100%",GOTO=""
+CTL{write}!="$env{pvolume}",CTL{values}="$env{ppercent}"
+LABEL=""
+CTL{name}="Line Out Playback Switch",CTL{do_search}=="1", \
+  CTL{values}="on"
+
+CTL{reset}="mixer"
 CTL{name}="Front Playback Volume",PROGRAM!="__ctl_search",GOTO=""
 # if master volume control is present, turn front volume to max
 ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
-- 
1.9.1
