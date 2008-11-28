From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HDA Analyzer
Date: Fri, 28 Nov 2008 17:32:05 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811281728550.8005@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0811281117480.8005@tm8103.perex-int.cz>
	<s5hfxlb3lhv.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0811281651140.8005@tm8103.perex-int.cz>
	<s5hd4gf3kiw.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0811281704520.8005@tm8103.perex-int.cz>
	<s5h8wr33jgf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 125421037E3
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 17:32:06 +0100 (CET)
In-Reply-To: <s5h8wr33jgf.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 28 Nov 2008, Takashi Iwai wrote:

> At Fri, 28 Nov 2008 17:08:16 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Fri, 28 Nov 2008, Takashi Iwai wrote:
> > 
> > > > >   Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> > > > >     Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > > > >     Amp-In vals: [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> > > > >     Amp-Out caps: N/A
> > > > >     Amp-Out vals: [0x00 0x00]
> > > > 		    ^^^^^^^^^^^
> > > > 
> > > > It looks wrong, but I'm not a big expert for HDA codecs. Are amp values 
> > > > available/writable when caps are N/A?
> > > 
> > > There is a global amp-cap definition.
> > 
> > OK, so it would be better to show the global amp-cap definition in the 
> > GUI with a "copy" identification. Thanks.
> 
> Not really.  The amp-caps in each node show the capability overrides.
> If you copy the output, you don't know whether it's an override
> (although the same value) or a local one.

I put ' (Global)' suffix to the frame label when global caps are used in 
my local source tree. So it should be clear for users.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
