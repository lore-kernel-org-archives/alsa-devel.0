From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Fixes ac3 passthru non-audio bit setting for AC97 codecs.
Date: Thu, 14 Aug 2003 16:16:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F3BA7B3.3010901@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010304000302050208050401"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010304000302050208050401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have :-
Card: Intel ICH5
Chip: Avance Logic ALC650 rev 0

The problem I was having was that the spdif "non-audio" bit was not 
being set.
This patch fixes that problem.

Cheers
James

--------------010304000302050208050401
Content-Type: text/plain;
 name="ac3_passthru_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac3_passthru_fix.diff"

--- ac97_codec.c.org	2003-08-14 14:19:29.834681728 +0100
+++ ac97_codec.c	2003-08-14 16:11:39.736581128 +0100
@@ -823,7 +825,13 @@
 					       AC97_CXR_SPDIF_MASK | AC97_CXR_COPYRGT,
 					       v);
 	} else {
+		unsigned short extst = ac97->regs[AC97_EXTENDED_STATUS];
+		snd_ac97_update_bits(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, 0); /* turn off */
+
 		change |= snd_ac97_update_bits(ac97, AC97_SPDIF, 0x3fff, val);
+		if (extst & AC97_EA_SPDIF) {
+			snd_ac97_update_bits(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, AC97_EA_SPDIF); /* turn on again */
+                }
 	}
 
 	return change;

--------------010304000302050208050401--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
