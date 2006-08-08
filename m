From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux v2.6.18-rc4, snd-aoa link error
Date: Tue, 08 Aug 2006 16:03:49 -0400
Message-ID: <1155067429.26338.96.camel@mindpipe>
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>
	<20060808194651.GA29482@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0D9301A7
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Aug 2006 22:03:53 +0200 (MEST)
In-Reply-To: <20060808194651.GA29482@aepfle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Olaf Hering <olaf@aepfle.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-08-08 at 21:46 +0200, Olaf Hering wrote:
> Attached config fails to link. No idea if it makes sense for an ibook1.
> 

Looks like we need:

--- aoa/Kconfig~	2006-08-08 16:02:30.000000000 -0400
+++ aoa/Kconfig	2006-08-08 16:03:26.000000000 -0400
@@ -5,6 +5,7 @@
 	tristate "Apple Onboard Audio driver"
 	depends on SND
 	select SND_PCM
+	select I2C
 	---help---
 	This option enables the new driver for the various
 	Apple Onboard Audio components.

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
