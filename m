From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
	registration
Date: Sun, 13 Jul 2014 15:36:52 +0200
Message-ID: <53C28B74.6010401@metafoo.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
 <53C153FF.4090705@metafoo.de> <20140712194903.GB6800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-212.synserver.de
 [212.40.185.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 1988E26087E
 for <alsa-devel@alsa-project.org>; Sun, 13 Jul 2014 15:37:58 +0200 (CEST)
In-Reply-To: <20140712194903.GB6800@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 07/12/2014 09:49 PM, Mark Brown wrote:
> On Sat, Jul 12, 2014 at 05:27:59PM +0200, Lars-Peter Clausen wrote:
>> On 07/11/2014 03:45 PM, Arnd Bergmann wrote:
>
>>> As a prerequisite for moving s3c64xx into multiplatform configurations,
>>> we need to change the smartq audio driver to stop using hardcoded
>>> gpio numbers from the header file, and instead pass the gpio data
>>> through platform_data.
>
>> This should be using the gpiod API. The gpiod API allows you to pass the
>> GPIOs without having to add a platform_data struct.
>
> OTOH that's a more invasive change that's harder to do mechanically -
> I'm not sure it's sensible to insist on someone doing it for generic
> cleanups (rather than actively working with the particular platform).

I don't think it is more invasive than using platform data. I did the same 
recently for jz4740 qi-lb60[1] and the changes in the patch are fairly trivial. 
The non-descriptor API is deprecated, so this even if this patch is applied as 
is sooner or later somebody will mechanically convert it to the descriptor API.

- Lars

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=218e18a3728507ee82ed2eb10c789671a00e34bd
