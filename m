From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: [PATCH] Fix a few debug messages in alsa-lib pcm_ladspa
Date: Wed, 28 Apr 2004 23:55:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56-Maildir.0404282353040.21234@yme.midgardsormen.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Index: src/pcm/pcm_ladspa.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_ladspa.c,v
retrieving revision 1.16
diff -u -r1.16 pcm_ladspa.c
--- src/pcm/pcm_ladspa.c	25 Feb 2004 11:24:30 -0000	1.16
+++ src/pcm/pcm_ladspa.c	28 Apr 2004 21:40:48 -0000
@@ -492,7 +492,7 @@
 			list_for_each(pos1, &plugin->instances) {
 				instance = list_entry(pos1, snd_pcm_ladspa_instance_t, list);
 				if (instance->channel == NO_ASSIGN) {
-					SNDERR("channel %u is not assigned for plugin '%s' depth %u", plugin->desc->Name, instance->channel, instance->depth);
+					SNDERR("channel %u is not assigned for plugin '%s' depth %u", instance->channel, plugin->desc->Name, instance->depth);
 					return -EINVAL;
 				}
 				if (instance->channel != channel) {
@@ -902,7 +902,7 @@
 				if (err >= 0) {
 					err = snd_pcm_ladspa_find_port(&array[channel], lplug, io->pdesc | LADSPA_PORT_AUDIO, port);
 					if (err < 0) {
-						SNDERR("Unable to find an audio port (%li) for channel %s", port);
+						SNDERR("Unable to find an audio port (%li) for channel %s", port, id);
 						return err;
 					}
 					continue;

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
