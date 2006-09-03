From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda:
	small cleanups)
Date: Sat, 2 Sep 2006 21:30:46 -0700
Message-ID: <20060902213046.dd9bf569.rdunlap@xenotime.net>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de>
	<20060831110436.995bdf93.rdunlap@xenotime.net>
	<20060902231509.GC13031@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 621992CF
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Sep 2006 06:27:20 +0200 (MEST)
Received: from midway.site ([71.117.233.155]) by xenotime.net for
	<alsa-devel@alsa-project.org>; Sat, 2 Sep 2006 21:27:16 -0700
In-Reply-To: <20060902231509.GC13031@elf.ucw.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel list <linux-kernel@vger.kernel.org>, pshou@realtek.com.tw, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Sun, 3 Sep 2006 01:15:10 +0200 Pavel Machek wrote:

> Hi!
> 
> > > Hm, it looks rather like a personal preference.
> > > IMHO, it's harder to read without space...
> > 
> > We have been tending toward not using space in cases like this
> > (in my unscientific memory-based survey).
> > 
> > So, just this morning I have seen questions and opinions about
> > the following that could (or could not) use more documentation
> > or codification and I'm sure that we could easily find more,
> > but do we want to codify Everything??
> > 
> > 
> > 1.  Kconfig help text should be indented (it's not indented in the
> > 	GFS2 patches)
> > 
> > 2.  if (!condition1)	/* no space between ! and condition1 */
> > 
> > 3.  don't use C99-style // comments
> > 
> > 4.  unsigned int bitfield :<nr_bits>;
> 
> Looks reasonable to me. Will you do the patch or should I ?

Please (you) go ahead with it.

Thanks,
---
~Randy

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
