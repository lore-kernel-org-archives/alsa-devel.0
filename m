From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Re: How to access vendor specific AC97 codec
	register?
Date: Thu, 20 Apr 2006 17:13:47 +0100
Message-ID: <1145549628.25762.4.camel@localhost.localdomain>
References: <e28805$nlf$1@sea.gmane.org> <1145546855.3008.0.camel@mindpipe>
	 <e28ag6$1hb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <e28ag6$1hb$1@sea.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alasinski <alasinski@rogers.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-04-20 at 11:48 -0400, alasinski wrote:
> Thx Lee,
> 
> I have looked at pxa2xx-ac97.c driver. It provides generic functions to 
> read/write any ac97 register: pxa2xx_ac97_read/write that are made available 
> to generic ac97_codec with snd_ac97_bus() call. My problem is I don't know 
> how to invoke those functions with proper arguments from application level. 

You will only be able to access these functions from an ad-hoc AC97
driver. Please see the UCB14xx touch driver for implementation details. 

Alternatively, you could always export the vendor specific registers
using sysfs. That way your user space program could read and write to
the codec registers exported. I've done this with the codec GPIO status
register (0x54) for the WM97xx touch drivers.

HTH

Liam





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
