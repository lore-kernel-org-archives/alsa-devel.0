From: Rene Herman <rene.herman@gmail.com>
Subject: gusextreme: set codec_flag
Date: Sun, 18 Feb 2007 21:07:21 +0100
Message-ID: <45D8B1F9.3070501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070209010401000102050902"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070209010401000102050902
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

===
The gusextreme driver neglects to set the gus->codec_flag meaning 
snd_gf1_pcm_new() allocates a second "PCM Playback Volume" control, 
which makes the driver fail to load.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
===

On top of isa_bus patch...

With this the driver works "fine" -- the es1688 bit is fine and the gf1 
bit has the same problems as gusclassic; I assume it's going to be the 
same solution as well.

Rene.

--------------070209010401000102050902
Content-Type: text/plain;
 name="gusextreme-codec_flag.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gusextreme-codec_flag.diff"

diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 74e34e6..0aeaa6c 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -283,6 +283,7 @@ static int __devinit snd_gusextreme_prob
 			"detected at 0x%lx\n", dev->bus_id, gus->gf1.port);
 		goto out;
 	}
+	gus->codec_flag = 1;
 
 	error = snd_es1688_pcm(es1688, 0, NULL);
 	if (error < 0)

--------------070209010401000102050902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------070209010401000102050902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070209010401000102050902--
