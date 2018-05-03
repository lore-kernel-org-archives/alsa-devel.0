From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: compress: Clarify the intent of
 current compressed ops handling
Date: Thu, 3 May 2018 21:57:14 +0530
Message-ID: <20180503162714.GX6014@localhost>
References: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
 <20180426163007.5632-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C77267035
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 18:22:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180426163007.5632-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 05:30:05PM +0100, Charles Keepax wrote:
> It is proposed that the model adopted for compressed component
> support currently should be that multiple components are supported
> on a compressed DAI but that they must provide a unified set of
> capabilities. So for example having multiple components involved in
> the decode is fine but the core will not presently attempt to make
> smart decisions like offloading MP3 to this component and AAC another.

Well this is supposed to be entirely a userspace call, we just present
devices with capabilities and the usespace decides... Btw capabilities are
supposed to be dynamic.

Looking at the code again now, I realized that we are treating compress like
PCM. It makes little sense to me to have multiple components for a
compressed device, does that model on your systems..?

> To implement this it is suggested that callbacks configuring the state
> of the components (trigger, set_params, ack and set_metadata) should be
> called on all components and required to succeed on all components
> before being considered to have succeeded. However for callbacks that
> return information from the driver (copy, get_metadata, pointer,
> get_codec_caps, get_caps and get_params) it is expected that either
> there is only a single provider on the link or that all components
> will return identical results.
> 
> Essentially this matches the current implementation of the code and
> only small clean ups are undertaken here.

> For callbacks configuring the state of the components simplify the
> code a little and make intention clearer by aborting as soon as an
> error is encountered. The operation has already failed and there is
> nothing to be gained from processing the additional callbacks.
> 
> For callbacks returning information from the driver only look for the
> first callback provided, currently the code will call every callback
> only returning the information provided by the last. Again this makes
> the currently supported feature set a little more clear.

Btw code changes look fine but I think we need broader cleanup here...

-- 
~Vinod
