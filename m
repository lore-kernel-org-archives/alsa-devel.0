From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCHv2] ASoC: fsl-sai: using 'lsb-first' property instead of
 'big-endian-data'.
Date: Fri, 29 Aug 2014 12:18:04 -0700
Message-ID: <20140829191803.GA7756@Asurada>
References: <20140829110601.GB21473@leverpostej>
 <20140829115943.GV29327@sirena.org.uk>
 <20140829164010.GA5520@Asurada>
 <20140829172601.GC18555@leverpostej>
 <20140829174019.GA5536@Asurada>
 <20140829191141.GA29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140829191141.GA29327@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Xiubo Li <Li.Xiubo@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 29, 2014 at 08:11:41PM +0100, Mark Brown wrote:
> On Fri, Aug 29, 2014 at 10:40:20AM -0700, Nicolin Chen wrote:
> 
> > Agreed, it's better to be described in the commit comments as well.
> 
> > And regarding the compatibility with the old DT, I personally prefer
> > it to be added in the change for safety but if this case is allowable
> > which I'm not so sure about it, I'm fairly okay with the rename.
> 
> If you're happy I can easily add a note, but keeping the old property

That will be helpful, thank you :)

> would remove all doubt :)  I'll wait for either an ack or a respin.

Yea, I'm fine with it. Acked.

Thanks
Nicolin
