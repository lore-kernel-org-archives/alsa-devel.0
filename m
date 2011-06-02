From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] asoc atmel_ssc: Don't try to free ssc if
	request failed
Date: Thu, 2 Jun 2011 19:11:06 +0100
Message-ID: <4DE7D23A.505@ti.com>
References: <BANLkTin=o135Ayy_yKiJ3JUs91Y_k9ciVw@mail.gmail.com>
	<20110602180540.GA4227@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A170244B7
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jun 2011 20:11:12 +0200 (CEST)
In-Reply-To: <20110602180540.GA4227@opensource.wolfsonmicro.com>
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
Cc: Joachim Eastwood <manabian@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 02/06/11 19:05, Mark Brown wrote:
> On Wed, Jun 01, 2011 at 11:59:10PM +0200, Joachim Eastwood wrote:
>> Hello,
>>
>> Patch below fixes a segmentation fault in atmel_ssc_dai if ssc_request() fails.
>>
>> We should only call ssc_free() when ssc_request() succeeds or bad
>> things will happen.
> 
> Adding Liam for his review.  Please CC maintainers on patches.
> 
>>
>> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>

Acked-by: Liam Girdwood <lrg@ti.com>
