From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 1/3] ALSA SoC: Add OpenFirmware helper
	for matching	bus and codec drivers
Date: Tue, 22 Jul 2008 17:21:58 -0400
Message-ID: <20080722212158.GB12412@secretlab.ca>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-1314.google.com (qb-out-1314.google.com [72.14.204.168])
	by alsa0.perex.cz (Postfix) with ESMTP id D86B41038C2
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 23:22:23 +0200 (CEST)
Received: by qb-out-1314.google.com with SMTP id a29so3948981qbd.44
	for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2008 14:22:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 12:38:30PM -0400, Jon Smirl wrote:
> On 7/22/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  +int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
> >  +                             void *codec_data, struct snd_soc_dai *dai,
> >  +                             struct device_node *node);
> >  +
> >  +int of_snd_soc_register_platform(struct snd_soc_platform *platform,
> >  +                                struct device_node *node,
> >  +                                struct snd_soc_dai *cpu_dai);
> >  +
> 
> This doesn't compile for me.  Where is struct snd_soc_dai being defined?
> 
> It used to be....
> 
> +int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
> +			      void *codec_data, struct snd_soc_codec_dai *dai,
> +			      struct device_node *node);
> +
> +int of_snd_soc_register_platform(struct snd_soc_platform *platform,
> +				 struct device_node *node,
> +				 struct snd_soc_cpu_dai *cpu_dai);
> 

I had to change it to match what is in Linus' current top of tree.  The
snd_soc_cpu_dai and snd_soc_codec_dai structures have been merged.

g.
