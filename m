From: James C Georgas <jgeorgas@rogers.com>
Subject: Remove AC97 POP control for STAC9708/11
Date: Sat, 09 Dec 2006 02:47:18 -0500
Message-ID: <1165650438.29397.26.camel@Rainsong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Summary: Remove AC97 POP control for STAC9708/11

	The STAC9708/11 AC97 codecs implement the PCM Out Path & Mute bit in
the General Purpose register (0x20:F), even though they don't implement
the actual function in the mixer.

	Since the alsa tests for the function by toggling the bit and reading
it back to see if it changed, it mistakenly creates a useless control.

	This patch explicitly removes the control when the codec is an
STAC9708/11.

	I put the check in patch_sigmatel_stac9708_specific(), because I have
an SBLive with this chip on it. I don't know if the STAC9758 or other
codecs also behave this way. If they do, then this check could maybe go
in patch_sigmatel_stac97xx_specific(), or some other more general
function.

Signed-off-by: James C Georgas <jgeorgas@rogers.com>

--- a/pci/ac97/ac97_patch.c     Thu Dec  7 15:04:27 2006 +0100
+++ b/pci/ac97/ac97_patch.c     Sat Dec  9 02:43:56 2006 -0500
@@ -940,6 +940,9 @@ static int patch_sigmatel_stac9708_speci
 static int patch_sigmatel_stac9708_specific(struct snd_ac97 *ac97)
 {
        int err;
+
+       // the register bit is writable, but the function is not implemented:
+       snd_ac97_remove_ctl(ac97, "PCM Out Path & Mute", NULL);

        snd_ac97_rename_vol_ctl(ac97, "Headphone Playback", "Sigmatel Surround Playback");
        if ((err = patch_build_controls(ac97, &snd_ac97_stac9708_bias_control, 1)) < 0)



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
