From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [REGRESSION] no sound on T60 laptop (HDA Intel)
Date: Tue, 02 Nov 2010 15:16:23 +0100
Message-ID: <E1PDHex-0001Gd-3L@pomaz-ex.szeredi.hu>
References: <E1P33mT-0003qa-Fv@pomaz-ex.szeredi.hu>
	<s5hwrpxnf41.wl%tiwai@suse.de>
	<E1P3EES-0005SV-Sr@pomaz-ex.szeredi.hu>
	<s5h8w2b6f9c.wl%tiwai@suse.de>
	<E1P3PKg-0006RB-KV@pomaz-ex.szeredi.hu>
	<20101031120452.31836af2@schatten.dmk.lab>
	<E1PDDGc-0000pM-83@pomaz-ex.szeredi.hu> <s5h62wguj5q.wl%tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <s5h62wguj5q.wl%tiwai@suse.de> (message from Takashi Iwai on Tue,
	02 Nov 2010 11:14:25 +0100)
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: miklos@szeredi.hu, florian@mickler.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 02 Nov 2010, Takashi Iwai wrote:
> At Tue, 02 Nov 2010 10:34:58 +0100,
> Miklos Szeredi wrote:
> > 
> > On Sun, 31 Oct 2010, Florian Mickler wrote:
> > > > Hmm, now there's no sound even with the revert.  I guess reproducing
> > > > this is not completely reliable so the bisect gave a false result.  Oh
> > > > well.
> > > > 
> > 
> > > Did you get to the bottom of this?
> > 
> > No, the regression is still there in 2.6.36-final.
> 
> This should be fixed by the commit
> 0e7adbe263f89ea2ef15b5af5e80a812b2a85025.
> Give it a try.

Yes, it fixes it.  Cool.

Thanks,
Miklos
