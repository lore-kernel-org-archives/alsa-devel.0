From: Daniel Jacobowitz <drow@false.org>
Subject: Re: [PATCH 2/8] ASoC pxa2xx I2S support
Date: Thu, 12 Oct 2006 13:18:44 -0400
Message-ID: <20061012171844.GA10020@nevyn.them.org>
References: <1160496714.24436.111.camel@localhost.localdomain>
	<s5hirism764.wl%tiwai@suse.de>
	<1160648042.13780.5.camel@localhost.localdomain>
	<s5h8xjlkdk3.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0610121144020.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610121144020.2435@xanadu.home>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 12, 2006 at 11:47:16AM -0400, Nicolas Pitre wrote:
> > IIRC, the code size is reduced by omitting '= 0'.  That is why kernel
> > code prefers the style without '= 0'. 
> > Maybe it doesn't matter any more with the recetn gcc, though.
> 
> The reason is that global variables with explicit initial values are 
> allocated to the .data section which is always present in the kernel 
> binary.  When no explicit initial value is provided then the variable is 
> allocated to the .bss section which is _not_ included in the kernel 
> binary but initialized to zero at runtime.

GCC has included explicitly zero initialized variables in the .bss
section for a while now; this is controlled by
-fno-zero-initialized-in-bss.

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
