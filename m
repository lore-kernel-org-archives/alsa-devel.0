From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/5] MFD: DaVinci Voice Codec
Date: Fri, 12 Mar 2010 11:22:54 +0000
Message-ID: <20100312112254.GB23739@sirena.org.uk>
References: <1268321541-18922-1-git-send-email-miguel.aguilar@ridgerun.com>
	<1268380916.3755.4.camel@odin>
	<9FFC5872-87B8-452E-B85C-D029B4F67E5B@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ECD6A10395C
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 12:22:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9FFC5872-87B8-452E-B85C-D029B4F67E5B@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "nsekhar@ti.com" <nsekhar@ti.com>, "diego.dompe@ridgerun.com" <diego.dompe@ridgerun.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, "miguel.aguilar@ridgerun.com" <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 12, 2010 at 08:13:25AM +0000, Mark Brown wrote:
> On 12 Mar 2010, at 08:01, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > On Thu, 2010-03-11 at 09:32 -0600, miguel.aguilar@ridgerun.com wrote:

> >> This is the MFD driver for the DaVinci Voice codec, it has two  
> >> clients:

> >> * Voice codec interface
> >> * Voice codec CQ93VC

> >> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>

> > Please CC the MFD maintainer too for this one.

> Or if, as is the case here IIRC, they've already acked it include  
> their ack in repostings.

I've found Samuel's previous ack so I've applied the series now - the
issue with the capabilities not covering everything the hw_params do
that Liam identified can be addressed with an incremental patch.

Thanks!
