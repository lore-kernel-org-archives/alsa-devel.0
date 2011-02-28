From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/2] hdspmixer: Don't use hardcoded number of
	cards.
Date: Mon, 28 Feb 2011 14:56:08 +0100
Message-ID: <1298901368-10632-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <s5h39n8qxdb.wl%tiwai@suse.de>
	<1298901368-10632-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298901368-10632-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have introduced MAX_CARDS before to make the code more safe and
extendable, so it's just sane to use it all over the place.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerIOMixer.h b/hdspmixer/src/HDSPMixerIOMixer.h
index b440007..2ec7f05 100644
--- a/hdspmixer/src/HDSPMixerIOMixer.h
+++ b/hdspmixer/src/HDSPMixerIOMixer.h
@@ -56,7 +56,7 @@ private:
 	std::stringstream channel_name;
     void update_child(Fl_Widget &widget);
 public:
-    HDSPMixerStripData *data[3][3][8]; /* data[card][mode(ss/ds/qs)][preset number] */
+    HDSPMixerStripData *data[MAX_CARDS][3][8]; /* data[card][mode(ss/ds/qs)][preset number] */
     HDSPMixerPan *pan;
     HDSPMixerFader *fader;
     HDSPMixerPeak *peak;
-- 
1.7.4.1
