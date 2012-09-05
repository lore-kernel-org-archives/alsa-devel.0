From: David Henningsson <david.henningsson@canonical.com>
Subject: Multiple speaker jacks (on an IDT codec)
Date: Thu, 06 Sep 2012 00:59:15 +0200
Message-ID: <5047D943.5060900@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 91DA226086E
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 00:59:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having a problem with a machine where the parser creates indexed 
speaker controls. For reference, codecs/idt92hd206-ecs-gf7100pvt shows 
the same problem.

I could use some input on how to fix it in the best way.

My first thought was that "[Jack] Speaker" is stupid in itself, and 
could be fixed like this:

diff --git a/sound/pci/hda/hda_auto_parser.c 
b/sound/pci/hda/hda_auto_parser.c
index 4f7d2df..8e32ee5 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -171,6 +171,10 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
                         if (conn == AC_JACK_PORT_FIXED)
                                 dev = AC_JACK_SPEAKER;
                 }
+               else if (dev == AC_JACK_SPEAKER) {
+                       if (conn == AC_JACK_PORT_COMPLEX)
+                               dev = AC_JACK_LINE_OUT;
+               }

                 switch (dev) {
                 case AC_JACK_LINE_OUT:

...but changing generic code is always a bit scary and regression prone 
(even though I could not think of a good counterexample where that would 
happen), so not sure if that's the best idea.

Next attempt is to modify the control creating function for IDT:

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 9db3056..c16d0f8 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3226,9 +3226,12 @@ static int create_multi_out_ctls(struct hda_codec 
*codec, int num_outs,
                                 idx = i;
                                 break;
                         case AUTO_PIN_SPEAKER_OUT:
-                               name = "Speaker";
-                               idx = i;
-                               break;
+                               if (num_outs <= 1) {
+                                       name = "Speaker";
+                                       idx = i;
+                                       break;
+                               }
+                               /* Fall through in case of multi speaker 
outs */
                         default:
                                 name = chname[i];
                                 idx = 0;


...since the current behaviour is inconsistent anyway - you get indices 
for 1 and 3, but "Center"/"LFE" for what should otherwise have been index 2.

Another way would to just write a pin fix to turn these speakers into 
line outs, which is what they really are anyway.

What do you think?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
