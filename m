From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.11-mm1: sound <-> GAMEPORT problems
Date: Mon, 7 Mar 2005 17:12:57 -0500
Message-ID: <d120d50005030714126e345fe2@mail.gmail.com>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
	 <200503070941.59365.petkov@uni-muenster.de>
	 <20050307215206.GH3170@stusta.de>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.204])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7C0E81C5
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2005 23:12:58 +0100 (MET)
Received: by rproxy.gmail.com with SMTP id r35so1221505rna
        for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2005 14:12:57 -0800 (PST)
In-Reply-To: <20050307215206.GH3170@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, vojtech@suse.cz, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Mar 2005 22:52:06 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Mar 07, 2005 at 09:41:59AM +0100, Borislav Petkov wrote:
> > On Friday 04 March 2005 12:32, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> > >-mm1/
> > >
> > <snip>
> >
> > Hi,
> >
> > the ymfpci sound driver wouldn't compile without gameport support selected
> > since the sound card has a gameport on it:
> >
> > Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> >
> > --- sound/pci/ymfpci/ymfpci.c.orig 2005-03-07 09:07:10.000000000 +0100
> > +++ sound/pci/ymfpci/ymfpci.c 2005-03-07 09:08:02.000000000 +0100
> > @@ -332,7 +332,9 @@ static int __devinit snd_card_ymfpci_pro
> >    }
> >   }
> >
> > +#ifdef SUPPORT_JOYSTICK
> >   snd_ymfpci_create_gameport(chip, dev, legacy_ctrl, legacy_ctrl2);
> > +#endif /* SUPPORT_JOYSTICK */
> >
> >   if ((err = snd_card_register(card)) < 0) {
> >    snd_card_free(card);
> 
> Nice catch (but I had to apply the patch manually due to some
> whitespace damage).
> 
> After a quick look, it seems there are a dozen other sound drivers (most
> OSS but also ALSA) with similar problems.

Note that in input tree (and in -mm) I tried to clean up these #ifdefs
by providing dummy functions when CONFIG_GAMEPORT is not selected. The
original report caused by the typo in dummy function name
(snc_ymfpci_create_gameport).

-- 
Dmitry


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
