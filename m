From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-tools][PATCH] echomixer: obsolete usage of
	dimension information
Date: Sat,  4 Nov 2017 11:28:35 +0900
Message-ID: <20171104022835.16519-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 13A20266F52
 for <alsa-devel@alsa-project.org>; Sat,  4 Nov 2017 03:28:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: s.chriscollins@gmail.com, alsa-devel@alsa-project.org, mark@xwax.org
List-Id: alsa-devel@alsa-project.org

In current implementation for a series of echoaudio drivers, some control
element set delivers information to use element values for
multi-dimensional array. Essentially, ALSA control interface of asound.h
has no common way to parse the information. As a result, the drivers
forces 'echomixer' application to parse the information by several ways.

This issue was reported by a commit 51db452df07b ('Revert "ALSA: echoaudio:
purge contradictions between dimension matrix members and total number of
members"') to Linux kernel. As a result of discussion at Linux
miniconference 2017, usage of 'dimen' member of 'struct snd_ctl_elem_info'
is going to be deprecated for future removal.

According to the above decision, this commit obsoletes usage of 'dimen'
information in 'echomixer' application. In a series of echoaudio drivers,
a control element set named as 'Channels info' includes duplicated
information of the dimension information on value array. Additionally,
some of dimension information have fixed values. This commit utilizes them
to obsolete usage of dimension information.

This patch is tested with Echo Gina 3G.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 echomixer/echomixer.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/echomixer/echomixer.c b/echomixer/echomixer.c
index 54d1520..ac9b51a 100644
--- a/echomixer/echomixer.c
+++ b/echomixer/echomixer.c
@@ -525,6 +525,25 @@ void GetChannels(void) {
     nLOut=snd_ctl_elem_value_get_integer(control, 2);	// Number of output channels
     fdOut=snd_ctl_elem_value_get_integer(control, 3);	// First digital out
     nPOut=snd_ctl_elem_value_get_integer(control, 4);	// Number of virtual output channels (==nLOut on non-vmixer cards)
+
+    mixerControl.outputs = nLOut;
+    mixerControl.inputs = nIn;
+
+    if (vmixerId) {
+      vmixerControl.outputs = nLOut;
+      vmixerControl.inputs = nPOut;
+
+      /* For outputs and inputs. */
+      metersStreams = 2;
+    } else {
+      /* For outputs, inputs and system outputs. */
+      metersStreams = 3;
+    }
+
+    /* For the number of channels. */
+    metersNumber = 16;
+    /* For each of levels and peaks. */
+    metersTypes = 2;
   }
   ClockMask=snd_ctl_elem_value_get_integer(control, 5);	// Bitmask of available input clocks
 }
@@ -1712,15 +1731,11 @@ int OpenControls(const char *card, const char *cardname) {
       if (!mixerId) {
         mixerId=numid;
         CTLID_DEBUG(("First Mixer id=%d\n", mixerId));
-        mixerControl.outputs=snd_ctl_elem_info_get_dimension(info, 0);
-        mixerControl.inputs=snd_ctl_elem_info_get_dimension(info, 1);
       }
     } else if (!strcmp("VMixer Volume", snd_ctl_elem_id_get_name(id))) {
       if (!vmixerId) {
         vmixerId=vmixerControl.id=numid;
         CTLID_DEBUG(("First Vmixer id=%d\n", vmixerId));
-        vmixerControl.outputs=snd_ctl_elem_info_get_dimension(info, 0);
-        vmixerControl.inputs=snd_ctl_elem_info_get_dimension(info, 1);
       }
     } else if (!strcmp("PCM Playback Volume", snd_ctl_elem_id_get_name(id))) {
       pcmoutId=pcmoutControl.id=numid;
@@ -1789,9 +1804,6 @@ int OpenControls(const char *card, const char *cardname) {
       CTLID_DEBUG(("VU-meter switch id=%d\n", numid));
     } else if (!strcmp("VU-meters", snd_ctl_elem_id_get_name(id))) {
       vumetersId=numid;
-      metersStreams=snd_ctl_elem_info_get_dimension(info, 0);	// 2 or 3: output, input and (vmixer cards only) pcm
-      metersNumber=snd_ctl_elem_info_get_dimension(info, 1);	// Number of channels
-      metersTypes=snd_ctl_elem_info_get_dimension(info, 2);	// 2: level and peak
       CTLID_DEBUG(("VU-meters id=%d\n", numid));
     } else if (!strcmp("Channels info", snd_ctl_elem_id_get_name(id))) {
       channelsId=numid;
-- 
2.11.0
