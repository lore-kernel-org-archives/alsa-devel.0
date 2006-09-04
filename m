From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC: 2.6 patch] build sound/sound_firmware.c only
	for OSS
Date: Mon, 04 Sep 2006 13:11:04 +0100
Message-ID: <1157371864.30801.38.camel@localhost.localdomain>
References: <20060904114135.GO4416@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B987529A
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Sep 2006 13:48:28 +0200 (MEST)
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	EF50D69524 for <alsa-devel@alsa-project.org>;
	Mon,  4 Sep 2006 13:48:27 +0200 (MEST)
In-Reply-To: <20060904114135.GO4416@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ar Llu, 2006-09-04 am 13:41 +0200, ysgrifennodd Adrian Bunk:
> All sound/sound_firmware.c contains is mod_firmware_load() that is a 
> legacy API only used by some OSS drivers.
> 
> This patch builds it into an own sound_firmware module that is only 
> built depending on CONFIG_SOUND_PRIME making the kernel slightly smaller 
> for ALSA users.

Reminds me - might as well fix this too

Signed-off-by: Alan Cox <alan@redhat.com>

--- sound/sound_firmware.c~	2006-09-04 12:33:08.805282488 +0100
+++ sound/sound_firmware.c	2006-09-04 12:33:08.817280664 +0100
@@ -59,8 +59,7 @@
  *	value zero on a failure.
  *
  *	Caution: This API is not recommended. Firmware should be loaded via
- *	an ioctl call and a setup application. This function may disappear
- *	in future.
+ *	request_firmware.
  */
  
 int mod_firmware_load(const char *fn, char **fp)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
