From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: Patch:  Add support for Medion laptops.
Date: Fri, 13 Oct 2006 16:51:59 +0200
Message-ID: <20061013145159.GA29937@trinnov.com>
References: <1160681269.5520.7.camel@razman> <s5hr6xdgw80.wl%tiwai@suse.de>
	<1160683498.5520.14.camel@razman> <s5h7iz44i41.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7iz44i41.wl%tiwai@suse.de>
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

Hi,

Sorry, I've been quite busy these days.
I'm sorry to say that the last HG tree doesn't work for my Medion laptop. This
is strange because I seem to have the same laptop as albox and Andrew, and it
works for them! But I tried last Tobin's patch which didn't work, and the last
HG tree does the same. The effect is as usual: it seems to work, but no sound.
I tried again my hack to be sure, and this one's still working. With the HG
tree, I'm still having these xruns that I don't have with the hacked tree.  I
tried to use the last alsa-lib, but with no more success.

Andrew & albox: are you doing something special?

Remy

On Friday 13 October at 12:37, Takashi Iwai wrote:
> At Thu, 12 Oct 2006 13:04:58 -0700,
> Tobin Davis wrote:
> > 
> > [1  <text/plain (7bit)>]
> > On Thu, 2006-10-12 at 21:39 +0200, Takashi Iwai wrote:
> > > At Thu, 12 Oct 2006 12:27:49 -0700,
> > > Tobin Davis wrote:
> > > > 
> > > > Summary:  Add support for Medion laptops
> > > > 
> > > > Description:
> > > >         This patch adds audio support for Medion's line of laptops,
> > > >         based on code shipped with the laptops.  Microphone support is
> > > >         still being explored.
> > > 
> > > Don't forget to add the model entry in ALSA-Configuration.txt, too.
> > > Otherwise it looks fine.
> > Done.  I added it to the original patch.
> 
> Thanks.  Applied to HG tree now.
> 
> 
> Takashi
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
