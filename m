From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout,
 switching to single_cmd mode...
Date: Tue, 26 Sep 2006 08:56:11 -0700
Message-ID: <20060926085611.c32e7cb2.rdunlap@xenotime.net>
References: <451834D0.40304@goop.org> <s5hlko7szjy.wl%tiwai@suse.de>
	<20060926083720.da9dca8e.rdunlap@xenotime.net>
	<s5hy7s6r5m6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7EC7521D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Sep 2006 17:55:01 +0200 (MEST)
Received: from midway.site ([71.117.233.155]) by xenotime.net for
	<alsa-devel@alsa-project.org>; Tue, 26 Sep 2006 08:54:56 -0700
In-Reply-To: <s5hy7s6r5m6.wl%tiwai@suse.de>
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
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Pavel Machek <pavel@suse.cz>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Sep 2006 17:48:33 +0200 Takashi Iwai wrote:

> At Tue, 26 Sep 2006 08:37:20 -0700,
> Randy Dunlap wrote:
> > 
> > On Tue, 26 Sep 2006 12:16:33 +0200 Takashi Iwai wrote:
> > 
> > > At Mon, 25 Sep 2006 12:58:08 -0700,
> > > Jeremy Fitzhardinge wrote:
> > > > 
> > > > I have a ThinkPad X60 which uses the Intel 82801G HDA audio chip.  This 
> > > > used to work for me, but lately (sometime during 2.6.18-rcX series) it 
> > > > stopped working - programs trying to use it tend to just block forever 
> > > > waiting for /dev/dsp.
> > > > 
> > > > The only obvious symptom is:
> > > > 
> > > >     hda_intel: azx_get_response timeout, switching to single_cmd mode...
> > > > 
> > > > appearing in the kernel log when booting.
> > > > 
> > > 
> > > There is no big change relevant to TP X60 during 2.6.18rc, so I don't
> > > think it's a regression in the hd-audio driver code.
> > > 
> > > > Details attached.  The dmesg output is for the FC6 distro kernel 
> > > > 2.6.18-1.2689.fc6PAE, but I see the same symptoms with 2.6.18-mm1.
> > > 
> > > You must see difference with mm1 (suppose that mm1 already includes
> > > the latest ALSA patches).  When the CORB/RIRB interrupt gets broken,
> > > the driver first switches to poling mode, then single_cmd mode as
> > > fallback.
> > > 
> > > Also, try disable_msi=1 option for mm1.  MSI seems broken on some
> > > systems.
> > 
> > is that "pci=nomsi" ?
> 
> No, snd-hda-intel driver has a new module option "disable_msi" to
> disable MSI support on that driver.  As default, it's off, i.e. MSI is
> enabled if available.  (Well, I feel it's better to rename it
> enable_msi and set on as default...)
> 
> Sorry for unclear text.

ugh.  We shouldn't have drivers with such options IMO.
I have seen/used MSI for ethernet, SATA, and audio.
It either works for all of them or none of them AFAIK.

Why do you think that it should not just be a global system option/flag?

---
~Randy

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
