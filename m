From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Mon, 11 Jan 2016 19:53:43 -0600
Message-ID: <56945CA7.70100@tabi.org>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
 <5693B7CC.8000905@maciej.szmigiero.name>
 <20160111145430.GE6588@sirena.org.uk> <5693CE21.8010009@tabi.org>
 <20160111161225.GJ6588@sirena.org.uk> <569455AA.4060907@tabi.org>
 <20160112013421.GW6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id C99EA260455
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 02:53:43 +0100 (CET)
In-Reply-To: <20160112013421.GW6588@sirena.org.uk>
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Quite possibly (it'll be more efficient and it's intended for such use
> cases) but as I said in my other reply that then has the issue that it
> implicitly gives default values to all the registers so I'd expect we
> still need to handle the cache initialisation explicitly (or
> alternatively the hardware sync with the cache on startup).

Why does REGCACHE_FLAT assume that all registers have a default value of 
0?  Shouldn't it have the same behavior w.r.t. cache values as 
REGCACHE_RBTREE?
