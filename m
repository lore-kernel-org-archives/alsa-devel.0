From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Wed, 03 Jul 2013 11:09:22 +0200
Message-ID: <51D3EA42.3040205@metafoo.de>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <20130702121345.GL27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-086.synserver.de (smtp-out-086.synserver.de
 [212.40.185.86])
 by alsa0.perex.cz (Postfix) with ESMTP id D4DA6265532
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 11:08:46 +0200 (CEST)
In-Reply-To: <20130702121345.GL27646@sirena.org.uk>
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
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/02/2013 02:13 PM, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 07:50:16AM +0200, Mike Looijmans wrote:
>> On 07/02/2013 05:33 AM, Joel Fernandes wrote:
[...]
>> This meant I had to use a DMA PARAM slot for every "period". The
>> OMAP L138 has 128 of those slots, so it's no problem to use a bunch
>> of them. Because the chain is cyclic, there is no need to update any
>> DMA parameter while running. All that ALSA needs to do is empty the
>> buffer before the cycle completes and the current position gets
>> overwritten.
> 
> This sort of cyclic thing tends to be best, ideally you don't need
> interrupts at all (other than a timer).

Yes, this is usually how it is done. But I'm wondering maybe the EDMA
controller only has a small total amount of slots available.

- Lars
