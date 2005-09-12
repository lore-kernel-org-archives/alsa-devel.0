From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: Front channels via fxbus 8 and 9
Date: Mon, 12 Sep 2005 10:09:59 -0400
Message-ID: <1126534200.5619.22.camel@mindpipe>
References: <20050908220155.GA28152@skinner.hem.za.org>
	 <s5hy862h8my.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy862h8my.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-09-12 at 12:40 +0200, Takashi Iwai wrote:
> At Fri, 9 Sep 2005 00:01:56 +0200,
> Mikael Magnusson wrote:
> > 
> > Hello,
> > 
> > I'm resending my patches that add front channels that can be used independently
> > of the "default" pcm device. I think the patches are really useful. When
> > you use the current SB Live driver it will automatically mute "Wave Surround",
> > "Wave Center" and "Wave LFE" when playing 5.1, since otherwise the front signal
> > would be played on all channels. With these patches this isn't necessary
> > since the "front" device is routed to the front outputs only.
> > 
> > One potential problem is that you won't get any front output during
> > 5.1 playback if you use an old EMU10K1.conf with a patched driver.
> 
> I think it's OK to merge.
> Any objections?

I agree, merge it.

Does this also solve the "master only controls front output" bug?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
