From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 1/2] ASoC: WM8962: mark cache_dirty flag
 after software reset in pm_resume
Date: Thu, 8 Oct 2015 10:34:48 +0900
Message-ID: <5615C838.6010903@mentor.com>
References: <1444115215-4388-1-git-send-email-jiada_wang@mentor.com>
 <1444115215-4388-2-git-send-email-jiada_wang@mentor.com>
 <20151006105907.GM12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 03EA1261566
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 03:34:52 +0200 (CEST)
In-Reply-To: <20151006105907.GM12635@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi

On 10/06/2015 07:59 PM, Mark Brown wrote:
> On Tue, Oct 06, 2015 at 04:06:54PM +0900, Jiada Wang wrote:
>
>> +	/* All registers have been reset to default value without calling
>> +	 * to regmap interface, even if reset fails, some registers
>> +	 * maybe in intermediate status, so we need to mark regmap
>> +	 * cache_dirty flag.
>> +	 */
>> +	regcache_mark_dirty(wm8962->regmap);
>
> This is a standard thing that applies to almost all devices, there
> should be no need for such an extensive comment (which would normally
> flag up that there's something weird and surprising going on).
>

Will remove the comment in next update
