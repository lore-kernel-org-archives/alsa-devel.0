From: Christoph Lameter <christoph@lameter.com>
Subject: Re: cmipci driver locking up linux hard
Date: Mon, 7 Aug 2006 09:29:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608070927480.3308@graphe.net>
References: <Pine.LNX.4.64.0608041616590.9917@graphe.net>
	<s5hy7u0raux.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7u0raux.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Aug 2006, Takashi Iwai wrote:

> At Fri, 4 Aug 2006 16:22:56 -0700 (PDT),
> Christoph Lameter wrote:
> > 
> > I recently bought a cmpci pci card with support for 6 channel surround 
> > sound. Vendor was PPA Int'l.
> > 
> > I can play music for shorter or longer time period but then it invariably 
> > locks up. If one tries the surround sound then it locks up very fast. 
> > Guess some concurrency issue? Run on a P4M800PROC Motherbord with
> > a Pentium940 (verified that lockup also occurs with single processor).
> 
> Does it happen with 2.6.18rc kernel, too?

Yes. This was reported against 2.6.18-rc3.

 > There is no big change in the driver and it didn't get much troubles.
> One significant fix after 2.6.17 is to disable the support of the
> integrated MPU401 interface as default, which may cause lock up at
> module loading time.

What else could it be? Is there any additional way to get more information 
about the failure?


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
