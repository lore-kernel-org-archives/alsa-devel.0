From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: Remove byte swap in 4x12
	SPI	write
Date: Wed, 11 May 2011 11:02:26 -0700
Message-ID: <4DCACF32.9090802@metafoo.de>
References: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4DCAC8E9.2060605@metafoo.de>
	<20110511174836.GA22798@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 4260B10395C
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 20:03:12 +0200 (CEST)
In-Reply-To: <20110511174836.GA22798@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mike Frysinger <vapier.adi@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 05/11/2011 10:48 AM, Mark Brown wrote:
> On Wed, May 11, 2011 at 10:35:37AM -0700, Lars-Peter Clausen wrote:
> 
>> I've probably not properly explained the problem in my previous patch.
>> endian.
> 
> This is totally unrelated to your previous patch (as is the last one),
> I'm doing some different work on the physical I/O code and frankly
> hadn't thought you had any patches you hadn't resent and got applied
> yet.

Ok, since the patches were basically identical to the patches I send the other
week, I thought they were related.

> 
>> The problem is due to how 16-bit SPI transfers work on linux and how
>> snd_soc_cache stores the data which is going to be send.
> 
> We shouldn't be using 16 bit transfers at all, that's insane.  If the
> board has gone and done that that's silly, and if drivers are relying
> on the board having done that then it's at best incredibly fragile.
> There certainly aren't any which check the word size.
> 
>> ASoC though uses a u8 array. So when this array is interpreted as a u16 array
>> instead the values will be in big-endian. As a result using 16-bit spi
>> transfers on a little-endian machine will send out the data byte-swapped.
>> Your patch does not change since.
> 
> Right, if the SPI controllers are being set up with anything other than
> 8 bit word sizes in transfers this is going to fall over.  However,
> since we can't rely on SPI controllers supporting anything other than 8
> bit transfers and we don't currently have a sensible way of negotiating
> the word size with the controller driver anyway I'd really expect us to
> only ever use 8 bit words without a bunch more infrastructure work.

Ok, could you comment again on this[1] then?
Because what the patch did was switching the codec from 16-bit to 8-bit
transfers, because of the issues described above.

Thanks
- Lars

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-May/039469.html
