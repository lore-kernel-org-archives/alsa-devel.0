From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Re: Re: How to access vendor specific AC97
	codecregister?
Date: Thu, 20 Apr 2006 17:57:52 +0100
Message-ID: <1145552273.25762.22.camel@localhost.localdomain>
References: <e28805$nlf$1@sea.gmane.org> <1145546855.3008.0.camel@mindpipe>
	 <e28ag6$1hb$1@sea.gmane.org>
	 <1145549628.25762.4.camel@localhost.localdomain>
	 <e28dd5$chl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <e28dd5$chl$1@sea.gmane.org>
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

On Thu, 2006-04-20 at 12:37 -0400, alasinski wrote:
> Thx Liam,
> 
> > You will only be able to access these functions from an ad-hoc AC97
> > driver. Please see the UCB14xx touch driver for implementation details.
> - where I can find it ?

Please use Google.

> 
> > Alternatively, you could always export the vendor specific registers
> > using sysfs. That way your user space program could read and write to
> > the codec registers exported. I've done this with the codec GPIO status
> > register (0x54) for the WM97xx touch drivers.

As Takashi said this is really not a standard way to do this. Your
probably better of writing your own driver to handle your codec GPIO
needs.

> How to go about using sysfs() to access to registers ? It provides info on 
> file system equivalent to /proc/filesystems content I'm told. I know of one 
> way to do it: I can map registers into user space with open("/dev/mem",...) 
> followed by mmap (...). Then I'm a king and can read/write to any of them. 

This wont work for AC97 codec registers as they are not part of the host
memory map and are accessed via the hosts AC97 controller.

> > I've done this with the codec GPIO status register (0x54) for the WM97xx 
> > touch drivers.
> Did you handled AC97 initialization yourself, or you relied on other driver 
> (exp: ALSA) ?
> 

I used the standard Alsa AC97 codec driver and every thing works fine
for me.

Liam



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
