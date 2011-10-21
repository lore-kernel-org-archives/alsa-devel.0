From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Fri, 21 Oct 2011 09:53:04 +0100
Message-ID: <20111021085303.GB3513@opensource.wolfsonmicro.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97B5D103A79
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 10:53:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Babu, Ramesh" <ramesh.babu@intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 11:42:27AM +0530, Babu, Ramesh wrote:

> I feel ignore_pmdown_time needs to be part of snd_soc_dai_driver structure.
> It will give flexibility to control individual dai.  Individual dai's can choose to
> Ignore power down delay.

Why do you need to do this?

> Would it make sense?

> In my codec, I need to ignore the power down delay for voice dais, but retain the delay
> for HiFi dai's.

I'm not sure associating it with DAIs is a good idea, I'd expect any
issues to be with the analouge outputs not DAIs.
