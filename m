From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SPI PCM capture device examples please
Date: Thu, 14 Nov 2013 15:12:10 +0100
Message-ID: <5284DA3A.9030602@ladisch.de>
References: <52836B6B.3070703@flatmax.org> <528420DD.6070506@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C3223261A1F
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 15:12:12 +0100 (CET)
In-Reply-To: <528420DD.6070506@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Flax wrote:
>> Is it possible to write an ALSA driver for a device which already has an SPI driver ?

Yes, this is possible.

Audio codecs typcially do not use SPI, so no such driver has been
written yet.

> I guess that IIO support for ASLA is not on the cards ?

Well, that depends on whether you are going to write that driver ...


Regards,
Clemens
