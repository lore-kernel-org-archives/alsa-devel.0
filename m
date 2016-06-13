From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 2/2] ASoc: wm8731: add normal mode with
	12MHz XTAL
Date: Mon, 13 Jun 2016 19:45:22 +1000
Message-ID: <575E80B2.3040309@flatmax.org>
References: <1465517516-1917-1-git-send-email-flatmax@flatmax.org>
 <1465517516-1917-2-git-send-email-flatmax@flatmax.org>
 <575BD6F2.70600@flatmax.org> <575CD572.2040700@flatmax.org>
 <20160613083714.GU20422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas02p.mx.bigpond.com (nschwmtas02p.mx.bigpond.com
 [61.9.189.140]) by alsa0.perex.cz (Postfix) with ESMTP id 133652619D7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 11:45:37 +0200 (CEST)
In-Reply-To: <20160613083714.GU20422@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 13/06/16 18:37, Charles Keepax wrote:
> On Sun, Jun 12, 2016 at 01:22:26PM +1000, Matt Flax wrote:
>> It appears that my logic here is flawed.
>>  From what I can tell, it isn't possible to get a suitable bit clock out of
>> the codec when using a 12 MHz crystal. For that reason, in my hardware I
>> will change crystals from 12 MHz.
> This looks correct the chip only has simple dividers so you won't
> be able to get a good audio rate clock from a 12MHz crystal.
>
>> I just want to check ... are there any versions of this codec which output
>> the bit clock when in USB mode on the BCLK pin ?
>>
> Apologies I am not quite sure I follow what USB mode is in this
> context, and the bit clock surely always comes out of the BCLK
> pin. Do you simply mean a system with a clock speed that
> relates to the 48MHz USB clock, such as your 12MHz? Basically any
> part that has a PLL/FLL should work for that, for example the
> wm8998:
>
> http://www.cirrus.com/en/products/pro/detail/P1265.html

Literally, with the chip set to usb mode (register 0b0001000 bit 0, page 
41 of the data sheet) it appears that the 12 MHz clock comes out of the 
BCLK pin, rather then the bit clock.

Matt

> Thanks,
> Charles
