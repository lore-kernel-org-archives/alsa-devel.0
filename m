From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: CodingStyle (was: Re: sound/pci/hda/intel_hda: small
	cleanups)
Date: Thu, 31 Aug 2006 11:04:36 -0700
Message-ID: <20060831110436.995bdf93.rdunlap__37140.1274730035$1157047331$gmane$org@xenotime.net>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 188AE18F
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Aug 2006 20:01:20 +0200 (MEST)
Received: from midway.site ([71.117.233.155]) by xenotime.net for
	<alsa-devel@alsa-project.org>; Thu, 31 Aug 2006 11:01:10 -0700
In-Reply-To: <s5h8xl52h52.wl%tiwai@suse.de>
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
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pshou@realtek.com.tw, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Aug 2006 15:01:45 +0200 Takashi Iwai wrote:

> At Thu, 31 Aug 2006 14:37:06 +0200,
> Pavel Machek wrote:
> > 
> > @@ -271,8 +272,8 @@ struct azx_dev {
> >  	/* for sanity check of position buffer */
> >  	unsigned int period_intr;
> >  
> > -	unsigned int opened: 1;
> > -	unsigned int running: 1;
> > +	unsigned int opened :1;
> > +	unsigned int running :1;
> >  };
> >  
> >  /* CORB/RIRB */
> > @@ -330,8 +331,8 @@ struct azx {
> >  
> >  	/* flags */
> >  	int position_fix;
> > -	unsigned int initialized: 1;
> > -	unsigned int single_cmd: 1;
> > +	unsigned int initialized :1;
> > +	unsigned int single_cmd :1;
> >  };
> 
> Any official standard reference for bit-field expressions?

Pavel knows how to submit patches to CodingStyle too.  :)

> >  /* driver types */
> > @@ -642,14 +643,14 @@ static int azx_reset(struct azx *chip)
> >  	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
> >  
> >  	count = 50;
> > -	while (! azx_readb(chip, GCTL) && --count)
> > +	while (!azx_readb(chip, GCTL) && --count)
> >  		msleep(1);
> 
> Hm, it looks rather like a personal preference.
> IMHO, it's harder to read without space...

We have been tending toward not using space in cases like this
(in my unscientific memory-based survey).

So, just this morning I have seen questions and opinions about
the following that could (or could not) use more documentation
or codification and I'm sure that we could easily find more,
but do we want to codify Everything??


1.  Kconfig help text should be indented (it's not indented in the
	GFS2 patches)

2.  if (!condition1)	/* no space between ! and condition1 */

3.  don't use C99-style // comments

4.  unsigned int bitfield :<nr_bits>;


---
~Randy

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
