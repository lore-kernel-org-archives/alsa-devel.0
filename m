From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Mon, 14 Jan 2019 15:40:15 +0000
Message-ID: <428430f50bc5bf51663736139541b1994cc37b6e.camel@linux.intel.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
         <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
         <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
         <5C39840A.7040005@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C39840A.7040005@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2019-01-12 at 11:37 +0530, Rohit kumar wrote:
> On 1/12/2019 3:19 AM, Pierre-Louis Bossart wrote:
> > > Thanks for the overnight fix. This update fixes the issue on my 
> > > Skylake XPS13 test device (blind testing since I don't understand 
> > > what the code does).
> > > 
> > > Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > I need to take this back, this set of changes (initial+fix) causes an 
> > error with our HDMI support
> > 
> > [   17.437684] sof-audio sof-audio: created machine bxt-pcm512x
> > [   17.585279] bxt-pcm512x bxt-pcm512x: ASoC: failed to init link iDisp1
> > [   17.585639] bxt-pcm512x bxt-pcm512x: snd_soc_register_card failed -517
> > 
> > Removing your changes restores the functionality
> > 
> Looks like we should revert generic implementation for defering probe 
> and move to call from machine driver as done in v1.
> https://lore.kernel.org/patchwork/patch/1027560/
> https://lore.kernel.org/patchwork/patch/1027561/
> 
> @Mark, Do you have suggestion to refine current patch?
> > Adding some traces I can see that the the platform name we use doesn't 
> > seem compatible with your logic. All the Intel boards used a constant 
> > platform name matching the PCI ID, see e.g. [1], which IIRC is used to 
> > bind components. Liam, do you recall in more details if this is really 
> > required?

Sorry, I cant quite remember why the PCI ID was used for the platform name, I
think it started with the SKL generation as previous generations used "baytrail-
pcm" and "haswell-pcm" as platform names IIRC. Perhaps Vinod will know.

The platform name is only used by SOF when over writing the "legacy" platform
name e.g. "baytrail-pcm" would become "sof-audio" and this is only used for
binding DAI links (so that all legacy machine drivers can be reused without
modification). 

Liam
