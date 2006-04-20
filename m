From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Re: How to access vendor specific AC97
	codec	register?
Date: Thu, 20 Apr 2006 17:37:04 +0100
Message-ID: <1145551024.25762.13.camel@localhost.localdomain>
References: <e28805$nlf$1@sea.gmane.org> <1145546855.3008.0.camel@mindpipe>
	 <e28ag6$1hb$1@sea.gmane.org>
	 <1145549628.25762.4.camel@localhost.localdomain>
	 <s5hirp4z0bo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirp4z0bo.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alasinski <alasinski@rogers.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-04-20 at 18:19 +0200, Takashi Iwai wrote:
> At Thu, 20 Apr 2006 17:13:47 +0100,
> Liam Girdwood wrote:
> > 
> > Alternatively, you could always export the vendor specific registers
> > using sysfs. That way your user space program could read and write to
> > the codec registers exported. I've done this with the codec GPIO status
> > register (0x54) for the WM97xx touch drivers.
> 
> Well, I don't think sysfs as an API is a good idea although you can
> use it as a simple workaround...
> 

Agreed, I really only use it for testing. Although, a standard AC97 gpio
API would be nice (if anyone has the time to add one).

Liam



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
