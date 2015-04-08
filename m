From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC 0/3] ALSA: Add soc hda bus support
Date: Wed, 08 Apr 2015 08:28:57 +0200
Message-ID: <5524CAA9.8030209@canonical.com>
References: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 269FA260440
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 08:29:04 +0200 (CEST)
In-Reply-To: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, pathes.audio@intel.com
List-Id: alsa-devel@alsa-project.org



On 2015-04-02 11:57, Vinod Koul wrote:
> This series of 3 patches adds support for ASoC HDA
> bus. ASoC HDA bus is essentially a wrapper for
> HDA core bus and it manages ASoC hda drivers

Hi,

I'm seeing several patch sets - as well as the added hdac indirection 
layer earlier - related to HDA and ASoC. But I'm curious about the 
bigger picture here.

In addition, I notice the rt286/rt288 ASoC driver looks very much 
hda-like, i e, we're in practice sending HDA commands over an i2s (or 
i2c) bus.

Adding two and two together it could mean you're trying to move 
rt286/rt288 over to use the hda codec driver (which would be awesome!). 
And perhaps other, similar ASoC codecs as well, if there are any.

But I still feel I'm missing the bigger roadmap here. Anyone who wants 
to enlighten me? :-)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
