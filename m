From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/7] ASoC: pxa2xx-ac97: Remove unused DAI
	ID defines
Date: Mon, 24 Oct 2016 20:17:28 +0200
Message-ID: <d7036263-f032-53dd-92e8-2e0115798f0f@metafoo.de>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
 <1476552777-1849-5-git-send-email-lars@metafoo.de>
 <20161024173947.GM17252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id BE788266D05
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 20:17:36 +0200 (CEST)
In-Reply-To: <20161024173947.GM17252@sirena.org.uk>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/24/2016 07:39 PM, Mark Brown wrote:
> On Sat, Oct 15, 2016 at 07:32:55PM +0200, Lars-Peter Clausen wrote:
>> The DAI ID defines are back from the time when DAIs were referenced by a
>> numerical ID. These days a string is used for matching instead and the
>> defines are unused. The last user of these defines was removed in commit
>> f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
>> remove the defines as well.
> 
> This doesn't apply against current code, please check and resend.

It depends on the other earlier patches in this series. But I'll resend
after the next merge window, this is not urgent.
