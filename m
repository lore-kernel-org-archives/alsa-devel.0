From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [REPOST] opti93x: conversion to use cs4231 library
Date: Tue, 29 Jan 2008 02:24:30 +0100
Message-ID: <479E804E.7070500@keyaccess.nl>
References: <20080126104411.50c2035f.krzysztof.h1@poczta.fm>
	<s5hd4rl6f4h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080003000900050704050408"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C6C1110382A
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 02:24:09 +0100 (CET)
In-Reply-To: <s5hd4rl6f4h.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080003000900050704050408
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 28-01-08 18:20, Takashi Iwai wrote:

> The fixed patch is below.  Please let me know this and previous
> patches work so that I can push them to the upstream.

Needs this additionally to compile (against 2.6.24 at least, but this is 
normally always required). Will test tomorrow.

Rene

--------------080003000900050704050408
Content-Type: text/plain;
 name="alsa-opti92x-ad1848.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-opti92x-ad1848.diff"

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 719b197..c01d2b2 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -22,7 +22,7 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
 
-
+#include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/isa.h>

--------------080003000900050704050408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080003000900050704050408--
