From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l52: Reorder Min/Max and
 update to SX_TLV for Beep Volume
Date: Mon, 5 Aug 2013 15:31:26 -0500
Message-ID: <alpine.DEB.2.10.1308051529100.5288@heelrod.ad.cirrus.com>
References: <alpine.DEB.2.10.1308051508140.5288@heelrod.ad.cirrus.com>
 <20130805202439.GA30764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 33B32265206
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 22:31:01 +0200 (CEST)
In-Reply-To: <20130805202439.GA30764@sirena.org.uk>
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
Cc: Brian Austin <brian.austin@cirrus.com>, lars@metafoo.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Aug 2013, Mark Brown wrote:

> On Mon, Aug 05, 2013 at 03:08:47PM -0500, Brian Austin wrote:
>> Beep Volume Min/Max was backwards.
>> Change to SOC_SONGLE_SX_TLV for correct volume representation
>
> This doesn't apply against v3.11-rc4 - can you check what's going on
> there please?  I don't see any obvious issues by eye which is
> worrying...
>
huh,  I just did a fresh pull of for-next and applied and it did fine...
It is SINGLE instead of SONGLE though :) But that wasn't the patch itself
