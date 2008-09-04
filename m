From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 3/9] ASoC: Blackfin: SPORT peripheral
	interface driver
Date: Thu, 4 Sep 2008 10:11:39 -0400
Message-ID: <8bd0f97a0809040711k70a9784cu1f2dac31b23c978c@mail.gmail.com>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-4-git-send-email-cooloney@kernel.org>
	<20080904104753.GC12775@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 577F824334
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 16:11:42 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so414858ywk.2
	for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2008 07:11:41 -0700 (PDT)
In-Reply-To: <20080904104753.GC12775@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 4, 2008 at 6:47 AM, Mark Brown wrote:
> On Thu, Sep 04, 2008 at 04:22:02PM +0800, Bryan Wu wrote:
>> From: Cliff Cai <cliff.cai@analog.com>
>
>> SPORT is a serial port which can support serveral serial communication protocols.
>> It can be used as I2C/PCM/AC97. For further information, please look up the HRM.
>
>> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> with the proviso that there's no ALSA or ASoC interfacing stuff in here
> so I'm likely to miss stuff.

yeah, this is like a library for our SPORT peripheral to avoid
duplicating it in all the Blackfin ALSA pieces
-mike
