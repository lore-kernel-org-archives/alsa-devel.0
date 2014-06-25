From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/19]: add mrfld DSP support
Date: Wed, 25 Jun 2014 06:27:44 +0200
Message-ID: <53AA4FC0.5010202@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <53A3EB23.4050302@metafoo.de> <20140620082041.GG22053@intel.com>
 <53A3F775.80303@metafoo.de> <20140623100957.GX24291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id CC4572610B7
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 06:28:08 +0200 (CEST)
In-Reply-To: <20140623100957.GX24291@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/23/2014 12:09 PM, Mark Brown wrote:
> On Fri, Jun 20, 2014 at 10:57:25AM +0200, Lars-Peter Clausen wrote:
>
>> The idea is to get rid of the IO abstraction layer inside ASoC and only rely
>> on regmap for this. This is a process this has been going on ever since the
>> regmap framework was added to the kernel and we are almost there now. The
>> best is to implement a regmap bus or a bus-less regmap instance that
>> implements the IPC for the DSP. If the IPC does not map nicely onto a
>> register map, we need to come up with something better. It's basically the
>> same problem that that HDA CODEC by RT has.
>
> Well, it depends.  If the device looks like it has a register map that's
> sensible but if it looks nothing like that then we should be
> implementing the widgets differently.  It may be that we need to be
> constructing and destructing objects on the DSP for example.

What do you mean by 'constructing/destructing on the DSP'?

- Lars
