From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: no front speaker sound with ALC262
Date: Fri, 21 Mar 2008 13:14:01 -0700
Message-ID: <1206130441.4863.133.camel@razman.gruemaster.com>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>
	<47BF84BF.702@versatile.com> <47BF8500.1050802@versatile.com>
	<7D68F908-875D-4EDE-B25D-CCBDD4E4A339@gmail.com>
	<s5h1w6zvrz4.wl%tiwai@suse.de> <47DEA53B.4030207@versatile.com>
	<1205778900.27317.160.camel@razman.gruemaster.com>
	<47DEC0BD.5090403@versatile.com>
	<1205781169.27317.165.camel@razman.gruemaster.com>
	<47DECB8E.7060007@versatile.com>
	<1205792180.27317.188.camel@razman.gruemaster.com>
	<47DFBF93.6060308@versatile.com>  <s5hd4psw4fj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D5C12443E
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2008 21:14:04 +0100 (CET)
In-Reply-To: <s5hd4psw4fj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew R Hurne <matt.hurne@versatile.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Everything is set in motion for me to get an eval unit.  I should see it
in about a week.  As soon as it comes in, I'll hit the ground running,
and see what I can figure out.

Tobin

On Tue, 2008-03-18 at 14:24 +0100, Takashi Iwai wrote:

> At Tue, 18 Mar 2008 09:11:47 -0400,
> Matthew R Hurne wrote:
> > 
> > Tobin Davis wrote:
> > > Ok, it looks like it may be a couple of weeks out, but they are more
> > > than happy to get me a unit.  Their sales staff has been bugging for
> > > Linux support for 6 months apparently.
> > > 
> > > In the mean time, if you can get me that output, I can at least start
> > > making a dent on this.  From the photo, it looks like you have a speaker
> > > jack (green) , line-in (blue), and mic (pink), plus speakers and mic
> > > built in?  I'll review the online documents again to be sure.
> > > 
> > > Tobin
> > 
> > We put some pressure on Tangent to get Linux audio working, and the tech. support guys I spoke with were clearly clueless.  :-(
> > 
> > I have attached the relevant output from dmesg, and a new alsa-info.sh output.
> 
> In your case, the driver cannot work as is because the hardware tells
> that you have no speaker output.  It's a bug of BIOS.
> 
> As mentioned in the earlier mail, then you'll have to figure out which
> pin corresponds to the speaker output actually manually by trial and
> error.  This requires some least knowledge of HD-audio codec.  See
> HD-audio documentation available on intel or other web sites.
> 
> Regarding the words you listed: the HD-audio codec contains small
> components (called widgets) that are connected with each other.  Each
> widget has a unique number id (NID) and has a different role, such as
> DAC/ADC, mixer, selector, pin (the actual I/O), etc.  Each widget can
> get/set certain commands, called verbs.  You can see the widgets on
> your codec in the codec#* proc file output in alsa-info.sh output.
> 
> 
> Takashi

-- 
Tobin Davis 


BOFH excuse #64:

CPU needs recalibration
