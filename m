From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 0/3] ALSA: Add soc hda bus support
Date: Tue, 14 Apr 2015 09:52:37 +0530
Message-ID: <20150414042237.GC2963@intel.com>
References: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
 <5524CAA9.8030209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CDED2606B5
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:27:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5524CAA9.8030209@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2015 at 08:28:57AM +0200, David Henningsson wrote:
> 
> 
> On 2015-04-02 11:57, Vinod Koul wrote:
> >This series of 3 patches adds support for ASoC HDA
> >bus. ASoC HDA bus is essentially a wrapper for
> >HDA core bus and it manages ASoC hda drivers
> 
> Hi,
> 
> I'm seeing several patch sets - as well as the added hdac
> indirection layer earlier - related to HDA and ASoC. But I'm curious
> about the bigger picture here.
Sure, as we discussed in last meeting, the SKL audio controller is HDA audio
controller which also supports a DSP and I2S ports. Although if you get a
SKL board with a HDA codec you can bypass DSP and it will work as previuos
gen Intel HDA controller so current hda code works well for "legacy" HDA
mode

Now we are moving bits and pieces out of current hda code into hdac layer
(hda-core) which will be used by SKL ASoC driver as well as current
implementations.
So first remaining parts of hdac will be merged follow by asoc wrappers,
then SKL controller driver and fllowed up by DSP and I2S support.

> In addition, I notice the rt286/rt288 ASoC driver looks very much
> hda-like, i e, we're in practice sending HDA commands over an i2s
> (or i2c) bus.
> 
> Adding two and two together it could mean you're trying to move
> rt286/rt288 over to use the hda codec driver (which would be
> awesome!). And perhaps other, similar ASoC codecs as well, if there
> are any.
some of the RT codecs support both HDA and I2S, but right now merging them
is not in my radar but yes it is doable and I will look into this once base
driver and merged
> 
> But I still feel I'm missing the bigger roadmap here. Anyone who
> wants to enlighten me? :-)
Hope this would have helped, do let me know if you have more questions :)

-- 
~Vinod
