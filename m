From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Mon, 11 Jan 2016 19:23:54 -0600
Message-ID: <569455AA.4060907@tabi.org>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
 <5693B7CC.8000905@maciej.szmigiero.name>
 <20160111145430.GE6588@sirena.org.uk> <5693CE21.8010009@tabi.org>
 <20160111161225.GJ6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160111161225.GJ6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Fabio Estevam <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> regcache handles this fine, it's perfectly happy to just go and allocate
> the cache as registers get used (this is why the code that's doing the
> allocation exists...).  What is causing problems here is that the first
> access to the register is happening in interrupt context so we can't do
> a GFP_KERNEL allocation for it.

Considering how small and not-sparse the SSI register space is, would 
using REGCACHE_FLAT be appropriate?
