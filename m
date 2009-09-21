From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: hda_intel: SPDIF not detected on Asus P7P55D PRO
Date: Mon, 21 Sep 2009 22:54:33 +0900
Message-ID: <20090921135433.GH3910@prithivi.gnumonks.org>
References: <4AB3009C.1090605@gmail.com> <s5hiqfg6aj5.wl%tiwai@suse.de>
	<51f3faa70909180738y6c8d1ecevb7ce90b3de6699b0@mail.gmail.com>
	<s5hzl8owh8k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id B4823103814
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Sep 2009 16:00:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzl8owh8k.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@alsa-project.org>, LydiaWang@viatech.com.cn, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Mon, Sep 21, 2009 at 03:38:03PM +0200, Takashi Iwai wrote:
> At Fri, 18 Sep 2009 08:38:26 -0600,
> Robert Hancock wrote:
> > 
> > On Fri, Sep 18, 2009 at 12:18 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Thu, 17 Sep 2009 21:38:04 -0600,
> > > Robert Hancock wrote:
> > >>
> > >> I just set up a new system running an Asus P7P55D PRO motherboard. It
> > >> looks like this uses the VIA VT1828S codec. The analog output seems to
> > >> work but the SPDIF output isn't recognized. Originally tried 2.6.30.5,
> > >> but Linus' current git doesn't seem any different. The device only gets
> > >> detected as HDA Generic, which, from my reading of the code, ignores
> > >> SPDIF outputs. I tried hacking patch_via.c to add the codec ID to match
> > >> existing types like VT1708S and VT1702, each of those got the SPDIF
> > >> output to show up, but no output showed up on the receiver, and also the
> > >> analog output then stopped being recognized (looks like some node IDs
> > >> don't match).
> > >
> > > Could you give alsa-info.sh output (run with --no-upload option)?
> > 
> > Here it is:
> 
> Thanks.  This looks really incompatible with the existing VIA codecs.
> So, no wonder that you didn't get it working by a simple hack.

Yes, I agree.

> Harald, do you know anyone who can help the development for this new
> codec chip?

VIA already has code for supporting this chip, and they were about to support
one big monster patch (15000 lines of code) containing what looks like several
months of code for several codecs.  I've asked them to split this up and create
and submit per-feature patches.

I don't know how long it will take them to do this.  Maybe Lydia can give
some comment on this.

Also, in case you want to see the big monster patch just for reference, I
can see if it can be posted to alsa-devel.  It should be no problem, IMHO.

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Free and Open Source Software Liaison
