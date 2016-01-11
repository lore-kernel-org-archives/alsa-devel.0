From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Mon, 11 Jan 2016 09:45:37 -0600
Message-ID: <5693CE21.8010009@tabi.org>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
 <5693B7CC.8000905@maciej.szmigiero.name>
 <20160111145430.GE6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160111145430.GE6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabio Estevam <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> That's possibly problematic because the flat cache will of necessity end
> up with defaults (of 0 from the kzalloc()) for all the registers.
> You'll still have default values in the cache, though some of the
> behaviour around optimising syncs does change without them explicitly
> given.  It does deal with the allocation issue but given that the issue
> was incorrect defaults I'd be a bit concerned.

Ok, I'm confused.  Granted, all of this regcache stuff was added after I 
stopped working on this driver, so I'm out of the loop.  But it appears 
that the regcache cannot properly handle an uninitialized cache.  I 
would expect it to know to perform hard reads of any registers that are 
uninitialized.

If the regcache wants to have an initialized cache, then it should 
automatically perform reads an all non-volatile, non-precious registers 
at initialization.
