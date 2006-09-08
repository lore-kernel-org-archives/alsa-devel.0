From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: oops in snd-powermac due to snd-aoa
Date: Fri, 08 Sep 2006 10:13:03 +1000
Message-ID: <1157674383.22705.347.camel@localhost.localdomain>
References: <20060907124256.GA22928@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0E2D177
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Sep 2006 02:13:13 +0200 (MEST)
In-Reply-To: <20060907124256.GA22928@aepfle.de>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-09-07 at 14:42 +0200, Olaf Hering wrote:
> I was playing with snd-aoa, maybe the driver would work on a G4/466.
> mv /lib/modules/*/kernel/sound/ppc/snd-powermac.ko .
> reboot
> $insmod /lib/modules/*/kernel/sound/aoa/*/*.ko
> alsamixer finds nothing.
> mv snd-powermac.ko /lib/modules/*/kernel/sound/ppc/
> $insmod snd-powermac.ko -> oops

I don't think it's due to snd-aoa ... looks like an old bogon of
snd-powermac related to the order in which snd-powermac and i2c-powermac
are loaded ....

Ben



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
