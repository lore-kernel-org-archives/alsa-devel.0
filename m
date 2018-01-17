From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v5 00/17] ASoC: fsl_ssi: Clean up - program
	flow level
Date: Wed, 17 Jan 2018 12:02:11 -0800
Message-ID: <20180117200210.GA9523@Asurada-Nvidia>
References: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
 <a6621849-2621-79ee-c8a4-09e23beea2c5@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 42264266FBD
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 21:01:48 +0100 (CET)
Received: by mail-pf0-f176.google.com with SMTP id k19so12266792pfj.5
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 12:01:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a6621849-2621-79ee-c8a4-09e23beea2c5@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 17, 2018 at 08:38:48PM +0100, Maciej S. Szmigiero wrote:

> However, I have a small nitpick regarding a comment newly added in
> this version of patch 16:
> +		/*
> +		 * Do not set SSI dev as the parent of AC97 CODEC device since
> +		 * it does not have a DT node. Otherwise ASoC core will assume
> +		 * CODEC has the same DT node as the SSI, so it may return a
> +		 * NULL pointer of CODEC when asked for SSI via the DT node
> 
> The second part of the last sentence isn't really true, the ASoC core
> will return a (valid, non-NULL) CODEC object pointer when asked for
> the SSI one if we set the SSI as the parent device of a AC'97 CODEC
> platform device.
> 
> The NULL pointer dereference when starting a playback that I wrote
> about in my previous message happens because in this situation the SSI
> DAI probe callback won't ever get called and so won't setup DMA data
> pointers (they will remain NULL).

Well, somehow the DMA data pointer of CODEC could be described
as "a NULL pointer of CODEC" reluctantly...it confuses people
though.

> And this in turn will cause the ASoC DMA code to dereference these
> NULL pointers when starting a playback (the same will probably happen
> also when starting a capture).
> 
> Sorry if I wasn't 100% clear about these details in my previous
> message describing this issue.

I would prefer to send an incremental patch later to update it,
if there are no new comments against this version; Otherwise, I
will update it in a next version once there is a need to send a
v6 anyway.

Thanks
