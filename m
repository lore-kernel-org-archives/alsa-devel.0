From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau: Factor out shared PLL
	configuration code
Date: Thu, 9 Jun 2016 20:40:46 +0200
Message-ID: <5759B82E.5040801@metafoo.de>
References: <1465493946-32594-1-git-send-email-lars@metafoo.de>
 <20160609174122.GB7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B298626070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 20:41:15 +0200 (CEST)
In-Reply-To: <20160609174122.GB7510@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/09/2016 07:41 PM, Mark Brown wrote:
> On Thu, Jun 09, 2016 at 07:39:06PM +0200, Lars-Peter Clausen wrote:
>> Multiple devices from the ADAU family share the same PLL structure and
>> configuration register layout. Introduce a new helper module that can be
>> used to calculated the PLL configuration registers based on a specified
>> input frequency and the desired output frequency of the PLL.
> 
> Sounds like we may be heading towards an MFD with a clock driver here?

Not at the moment, the PLL outputs are only used internally so it makes
no sense to expose it through the CCF at the moment. The questions on
IRC were more about how to replace the input clock configuration, which
is currently done through the set_sysclk callbacks, with the CCF.
