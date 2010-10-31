From: Florian Mickler <florian@mickler.org>
Subject: Re: [REGRESSION] no sound on T60 laptop (HDA Intel)
Date: Sun, 31 Oct 2010 12:04:52 +0100
Message-ID: <20101031120452.31836af2@schatten.dmk.lab>
References: <E1P33mT-0003qa-Fv@pomaz-ex.szeredi.hu>
	<s5hwrpxnf41.wl%tiwai@suse.de>
	<E1P3EES-0005SV-Sr@pomaz-ex.szeredi.hu>
	<s5h8w2b6f9c.wl%tiwai@suse.de>
	<E1P3PKg-0006RB-KV@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1P3PKg-0006RB-KV@pomaz-ex.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 06 Oct 2010 10:26:38 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Wed, 06 Oct 2010, Takashi Iwai wrote:
> > At Tue, 05 Oct 2010 22:35:28 +0200,
> > Miklos Szeredi wrote:
> > > 
> > > On Tue, 05 Oct 2010, Takashi Iwai wrote:
> > > > In anyway, if this is reproducible, get alsa-info.sh output before and
> > > > after suspend.  It'll give more information of HD-audio and sound
> > > > driver status.
> > > 
> > > No significant difference before and after the suspend
> > 
> > The important thing is to get the alsa-info output at the moment
> > you don't get sound and you get sound.  Just after the suspend is
> > still in the power-saving mode, thus all the setup might be inactive.
> > 
> > Anyway, could you attach alsa-info.sh output so that I can analyze?
> 
> Attaching the files.
> 
> > > ...
> > > 
> > > Bisected it to commit 3f50ac6a0e "ALSA: hda - Fix stream and
> > > channel-ids codec-bus wide"
> > > 
> > > Reverting this on latest git fixes the sound.
> > 
> > Could you get alsa-info.sh output before and after reverting this, too?
> > (i.e. non-working and working states)
> 
> Hmm, now there's no sound even with the revert.  I guess reproducing
> this is not completely reliable so the bisect gave a false result.  Oh
> well.
> 
> Thanks,
> Miklos
> 
Did you get to the bottom of this?
