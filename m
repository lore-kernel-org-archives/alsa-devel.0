From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Use valid condition for
 snd_soc_dai_digital_mute() in hw_free()
Date: Mon, 2 Dec 2013 23:25:18 +0800
Message-ID: <20131202152517.GC8609@MrMyself>
References: <1385976874-30755-1-git-send-email-b42378@freescale.com>
 <s5hli038t5g.wl%tiwai@suse.de>
 <20131202121916.GX27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 187EF261AA5
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 16:28:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131202121916.GX27568@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 02, 2013 at 12:19:16PM +0000, Mark Brown wrote:
> On Mon, Dec 02, 2013 at 11:05:31AM +0100, Takashi Iwai wrote:
> > Nicolin Chen wrote:
> 
> > > The snd_soc_dai_digital_mute() here will be never executed because we only
> > > decrease codec->active in snd_soc_close(). Thus correct it.
> 
> > A couple of minor problems by this approach:
> 
> > - snd_soc_dai_digital_mute() will be called twice in the normal PCM
> >   close path.
> 
> Right, it's called in close() so it's redundant to call it here most of
> the time.  On the other hand it will at least get called slightly sooner
> which is good and in the case of reconfiguration we'll mute while doing
> that - doing the mute earlier is better.
> 
> > - In full duplex mode where both playback/capture streams share the
> >   same codec, one of the directions won't be handled correctly because
> >   codec->active is incremented/decremented twice (once for each
> >   direction).
> 
> Indeed, the check needs to be on playback_active or capture_active
> rather than on the overall DAI.

Sir, thank you for the hint. I will reconsider about the modification.

And also thank Iwai-san for pointing out the flaws in my patch.

Best regards,
Nicolin Chen
