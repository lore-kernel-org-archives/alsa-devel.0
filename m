From: olivier@trillion01.com
Subject: [PATCH - pcm_plug] Add details about what pcm_plug
	does in doc
Date: Thu, 16 May 2013 04:41:29 -0400
Message-ID: <1368693689-31084-1-git-send-email-olivier@trillion01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy13-pub.unifiedlayer.com (oproxy13-pub.unifiedlayer.com
 [69.89.16.30]) by alsa0.perex.cz (Postfix) with SMTP id 72DE8265517
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 15:42:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Olivier Langlois <olivier@trillion01.com>

Current doc only mention conversion to channels, rate and format. It alsa
takes care of access mode mismatch. This is what I was looking for and I
had to look the source code to figure out.

Signed-off-by: Olivier Langlois <olivier@trillion01.com>

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index fa84eaa..8a639af 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -1155,7 +1155,8 @@ int snd_pcm_plug_open(snd_pcm_t **pcmp,
 
 \section pcm_plugins_plug Automatic conversion plugin
 
-This plugin converts channels, rate and format on request.
+This plugin converts channels, rate and format on request. It will also
+implicitly adapt to the slave plugin access mode if different than our own.
 
 \code
 pcm.name {
-- 
1.8.2.3
