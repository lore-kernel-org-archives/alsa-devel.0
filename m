From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Support for realtek alc 655
Date: Fri, 10 Oct 2003 15:53:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F86C7FF.3020509@superbug.demon.co.uk>
References: <000901c37fda$93235430$0580a8c0@nova>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060206030605070906070605"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000901c37fda$93235430$0580a8c0@nova>
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
--------------060206030605070906070605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch to enable detection of ALC655 codec.

--------------060206030605070906070605
Content-Type: text/plain;
 name="ac97_codec.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_codec.c.diff"

--- ac97_codec.c.org	2003-09-09 14:48:16.835721144 +0100
+++ ac97_codec.c	2003-09-09 14:48:42.359840888 +0100
@@ -112,6 +112,7 @@
 { 0x414c4730, 0xffffffff, "ALC101",		NULL,		NULL },
 { 0x414c4740, 0xfffffff0, "ALC202",		NULL,		NULL },
 { 0x414c4750, 0xfffffff0, "ALC250",		NULL,		NULL },
+{ 0x414c4760, 0xfffffff0, "ALC655",             patch_alc650,   NULL },
 { 0x414c4770, 0xfffffff0, "ALC203",		NULL,		NULL },
 { 0x434d4941, 0xffffffff, "CMI9738",		patch_cm9738,	NULL },
 { 0x434d4961, 0xffffffff, "CMI9739",		patch_cm9739,	NULL },


--------------060206030605070906070605--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
