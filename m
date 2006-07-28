From: Denis Vlasenko <vda.linux@googlemail.com>
Subject: Re: Sound problems with snd_hda on x86_64
Date: Fri, 28 Jul 2006 12:47:11 +0200
Message-ID: <200607281247.11986.vda.linux@googlemail.com>
References: <200607281216.25214.vda.linux@googlemail.com>
	<s5hr706nhtr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54B4415C
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 12:47:18 +0200 (MEST)
Received: by nf-out-0910.google.com with SMTP id c29so128990nfb
	for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2006 03:47:18 -0700 (PDT)
In-Reply-To: <s5hr706nhtr.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: PeiSen Hou <pshou@realtek.com.tw>, alsa-devel@alsa-project.org, Andi Kleen <ak@suse.de>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Friday 28 July 2006 12:29, Takashi Iwai wrote:
> > Which is, in turn, is caused by this code:
> > 
> > --- linux-2.6.17.6.org/sound/core/pcm_compat.c	2006-07-15 21:00:43.000000000 +0200
> > +++ linux-2.6.17.6.src/sound/core/pcm_compat.c	2006-07-28 00:35:10.000000000 +0200
> > @@ -478,6 +478,8 @@ static long snd_pcm_ioctl_compat(struct 
> >  	 * mmap of PCM status/control records because of the size
> >  	 * incompatibility.
> >  	 */
> > +printk("substream->no_mmap_ctrl = 1 in %s:%s line %d\n", __FILE__, __FUNCTION__, __LINE__);
> > +dump_stack();
> >  	substream->no_mmap_ctrl = 1;
> >  
> >  	switch (cmd) {
> > 
> > It's puzzling. Even a 486 processor, can do 64-bit operations (using cmpxchg8)
> > on memory-mapped areas, why does code disallows mmap for 64-bit CPUs but allows
> > for 32-bit ones?
> 
> On the contrary, the driver disallows mmap for 32bit task on 64bit
> architecture.  This is because the size of the mapped record is
> different between 32bit and 64bit architectures, so it cannot be
> shared.

Why artsd attempts mmap at all then? Why it thinks that
/dev/snd/pcmC0D0p is mmap-able when it is not?

> BTW, with the recent version of alsa-lib, you no longer need artsd
> unless you want a network transparent.  Disable it on kde control
> center.

This is good.
--
vda

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
