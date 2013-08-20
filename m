From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
Date: Tue, 20 Aug 2013 13:53:49 -0600
Message-ID: <5213C94D.7050304@wwwdotorg.org>
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org> <20130820001858.GF30073@sirena.org.uk>
 <52138FDE.3080007@wwwdotorg.org> <20130820190701.GR30073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 536DC265283
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 21:53:54 +0200 (CEST)
In-Reply-To: <20130820190701.GR30073@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com, s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/20/2013 01:07 PM, Mark Brown wrote:
> On Tue, Aug 20, 2013 at 09:48:46AM -0600, Stephen Warren wrote:
>> On 08/19/2013 06:18 PM, Mark Brown wrote:
> 
>>> S/PDIF is also sometimes used as an interconnect between
>>> devices - some CODECs have S/PDIF I/O (more normally used as an
>>> external connector on the box).  This is most frequently seen
>>> as a way to
> 
>> That's not a good argument for an incorrect binding.
> 
> The point is that it might turn into a more correct binding
> depending on what the S/PDIF device actually is.

There's *never* an object on the board called a "dummy codec".
