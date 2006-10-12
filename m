From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/8] ASoC pxa2xx I2S support
Date: Thu, 12 Oct 2006 11:47:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610121144020.2435@xanadu.home>
References: <1160496714.24436.111.camel@localhost.localdomain>
	<s5hirism764.wl%tiwai@suse.de>
	<1160648042.13780.5.camel@localhost.localdomain>
	<s5h8xjlkdk3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <s5h8xjlkdk3.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Oct 2006, Takashi Iwai wrote:

> At Thu, 12 Oct 2006 11:14:02 +0100,
> Liam Girdwood wrote:
> > 
> > On Tue, 2006-10-10 at 19:06 +0200, Takashi Iwai wrote:
> > > At Tue, 10 Oct 2006 17:11:54 +0100,
> > > Liam Girdwood wrote:
> > > > 
> > > > +/* used to disable sysclk if external crystal is used */
> > > > +static int extclk = 0;
> > > 
> > > You can omit "= 0" for zero-initialization of a static variable.
> > 
> > Removed, although I do like it for clarity. 
> 
> IIRC, the code size is reduced by omitting '= 0'.  That is why kernel
> code prefers the style without '= 0'. 
> Maybe it doesn't matter any more with the recetn gcc, though.

The reason is that global variables with explicit initial values are 
allocated to the .data section which is always present in the kernel 
binary.  When no explicit initial value is provided then the variable is 
allocated to the .bss section which is _not_ included in the kernel 
binary but initialized to zero at runtime.


Nicolas

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
