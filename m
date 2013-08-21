From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
Date: Wed, 21 Aug 2013 10:08:08 -0600
Message-ID: <5214E5E8.1000102@wwwdotorg.org>
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org> <20130820001858.GF30073@sirena.org.uk>
 <52138FDE.3080007@wwwdotorg.org> <20130820190701.GR30073@sirena.org.uk>
 <5213C94D.7050304@wwwdotorg.org> <20130820222810.GU30073@sirena.org.uk>
 <20130821021801.GA6177@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 23533261B25
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 18:08:14 +0200 (CEST)
In-Reply-To: <20130821021801.GA6177@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org, s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, Mark Brown <broonie@kernel.org>, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

On 08/20/2013 08:18 PM, Nicolin Chen wrote:
> On Tue, Aug 20, 2013 at 11:28:10PM +0100, Mark Brown wrote:
>> On Tue, Aug 20, 2013 at 01:53:49PM -0600, Stephen Warren wrote:
>>> On 08/20/2013 01:07 PM, Mark Brown wrote:
>>
>>>> The point is that it might turn into a more correct binding
>>>> depending on what the S/PDIF device actually is.
>>
>>> There's *never* an object on the board called a "dummy codec".
>>
>> Oh, is that what you're talking about?  Yes, that makes sense.  I had
>> been responding to the comments about the transceivers.
> 
> I'll remove the 'dummy' words in the next version from the binding doc.

I think the word "CODEC" is also problematic in this context, since
whatever is connector to the S/PDIF output path may not be a CODEC.
That's why I suggested some more generic property names that IIRC
concentrated on enabling rx/tx rather than indicating what was actually
connected to the S/PDIF controller.
