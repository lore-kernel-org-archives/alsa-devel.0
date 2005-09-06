From: Vincent Pelletier <subdino2004@yahoo.fr>
Subject: [PATCH] Correct detection of iBook G4 1420Mhz soundcard
Date: Tue, 06 Sep 2005 17:09:22 +0200
Message-ID: <dfkbfd$q42$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050605070404060407050808"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

This is a multi-part message in MIME format.
--------------050605070404060407050808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi.
Here is a patch to correct detection of the soundcard on my iBook model
(bought really recently).
Without that fix, there were only andui in the headphone, and the mixer
was totaly non functional.

I made this diff against linux kernel 2.6.13-mm1, the file is in dir
/audio/ppc .

Vincent Pelletier

--------------050605070404060407050808
Content-Type: text/plain;
 name="pmac.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pmac.c.diff"

--- pmac.c	2005-08-29 01:41:01.000000000 +0200
+++ pmac.c.new	2005-09-06 16:52:59.000000000 +0200
@@ -988,6 +988,7 @@ static int __init snd_pmac_detect(pmac_t
 		case 0x33:
 		case 0x29:
 		case 0x24:
+		case 0x5C:
 			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
 			chip->model = PMAC_SNAPPER;
 			chip->can_byte_swap = 0; /* FIXME: check this */

--------------050605070404060407050808--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
