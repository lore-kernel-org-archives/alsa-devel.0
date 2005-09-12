From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: [PATCH] emu10k1: Front channels via fxbus 8 and 9
Date: Tue, 13 Sep 2005 00:16:15 +0200
Message-ID: <20050912221615.GA11779@skinner.hem.za.org>
References: <20050908220155.GA28152@skinner.hem.za.org> <s5hy862h8my.wl%tiwai@suse.de> <1126534200.5619.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1126534200.5619.22.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2005 at 10:09:59AM -0400, Lee Revell wrote:
> On Mon, 2005-09-12 at 12:40 +0200, Takashi Iwai wrote:
> > At Fri, 9 Sep 2005 00:01:56 +0200,
> > Mikael Magnusson wrote:
> > > 
> > > Hello,
> > > 
> > > I'm resending my patches that add front channels that can be used independently
> > > of the "default" pcm device. I think the patches are really useful. When
> > > you use the current SB Live driver it will automatically mute "Wave Surround",
> > > "Wave Center" and "Wave LFE" when playing 5.1, since otherwise the front signal
> > > would be played on all channels. With these patches this isn't necessary
> > > since the "front" device is routed to the front outputs only.
> > > 
> > > One potential problem is that you won't get any front output during
> > > 5.1 playback if you use an old EMU10K1.conf with a patched driver.
> > 
> > I think it's OK to merge.
> > Any objections?
> 
> I agree, merge it.
> 
> Does this also solve the "master only controls front output" bug?
> 
> Lee
> 

Not this patch but I have another that creates an additional master
volume controller in DSP code for 5.1 PCM output.

/Mikael



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
