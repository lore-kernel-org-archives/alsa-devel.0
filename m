From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: SPI PCM capture device examples please
Date: Thu, 14 Nov 2013 15:36:58 +0100
Message-ID: <5284E00A.5080409@metafoo.de>
References: <52836B6B.3070703@flatmax.org> <528420DD.6070506@flatmax.org>
 <5284DA3A.9030602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-123.synserver.de (smtp-out-124.synserver.de
 [212.40.185.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 929C6261A27
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 15:36:43 +0100 (CET)
In-Reply-To: <5284DA3A.9030602@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

On 11/14/2013 03:12 PM, Clemens Ladisch wrote:
> Matt Flax wrote:
>>> Is it possible to write an ALSA driver for a device which already has an SPI driver ?
> 
> Yes, this is possible.
> 
> Audio codecs typcially do not use SPI, so no such driver has been
> written yet.
> 
>> I guess that IIO support for ASLA is not on the cards ?
> 
> Well, that depends on whether you are going to write that driver ...

There is already a IIO driver for this part. So if you really wanted to use
it using the ALSA userspace API the best solution would be to write a
generic IIO-to-ALSA bridge.

- Lars
