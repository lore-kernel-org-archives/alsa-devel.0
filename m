From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v4 07/19] ALSA: Oxygen: Add new CS4245 SPI
 functions
Date: Fri, 24 Jan 2014 15:46:46 +0100
Message-ID: <52E27CD6.7010109@ladisch.de>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
 <1390565900-3337-7-git-send-email-v1ron@mail.ru>
 <20140124134351.GC11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DC1D4265450
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 15:46:46 +0100 (CET)
In-Reply-To: <20140124134351.GC11727@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Jan 24, 2014 at 04:18:08PM +0400, Roman Volkov wrote:
>> Add the new SPI write and read functions. The SPI read function
>> is used for creating initial registers dump and may be used for
>> debugging purposes. SPI operations are cached, so there is a new
>> function to manage the cache (shadow). I have to remove
>> the shift from the CS4245_SPI_* constants, since when
>> we are performing the reading, we need to shift by 8 instead
>> of 16.
>
> I can't help but think that this driver ought to be making more use of
> frameworks

Everbody else thinks the same: <http://lkml.org/lkml/2012/3/13/215>.

Unfortunately, thinking requires less effort than writing patches.


Regards,
Clemens
