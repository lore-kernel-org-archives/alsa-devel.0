From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Date: Wed, 27 Jun 2018 23:03:16 +0200
Message-ID: <45a4e773-aaa3-6d43-f02d-5056a2a265d4@zonque.org>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180618104159.24b9fffb@bbrezillon> <87d0wnrhqz.fsf@belgarion.home>
 <20180625130704.GQ9413@sirena.org.uk> <87r2ksl0wa.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 910222679A6
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 23:03:18 +0200 (CEST)
In-Reply-To: <87r2ksl0wa.fsf@belgarion.home>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, alsa-devel@alsa-project.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wednesday, June 27, 2018 05:11 PM, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:
> 
>> On Mon, Jun 18, 2018 at 09:56:20PM +0200, Robert Jarzmik wrote:
>>
>>> I must insist on "Wednesday", as I need to have one last pass from 0-day kernel
>>> checker to be fully covered, and I'd like as well to know which tree the ASoC
>>> patch will take, ie. if Mark commits to take it, or rather wants to pull from
>>> the imutable branch.
>>
>> I'll pull the branch in (a signed tag would've been nicer but it's not
>> the end of the world).
> Yeah, I realised that too ... late.
> 
> Anyways, the immutable branch doesn't contain the specific ASoC patch "ASoC:
> pxa: remove the dmaengine compat need", and up to my better understanding
> neither does your for-next branch.
> 
> So until I see it in your branch it will dwelve happily in pxa/for-next. If it
> has to be routed through your tree, so that Daniel can work on ASoC pxa, I'd
> like to know at -rc4 time so that I drop it from my pxa/for-next branch.

Ah, yes. The series I just posted depends on that.
