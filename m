From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP DMA
	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 16:26:05 +0800
Message-ID: <f17812d70904230126i9321f67s3298fff4386feee1@mail.gmail.com>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
	<20090423082328.GB30105@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id AC2E3103845
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 10:26:06 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so370132qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 01:26:05 -0700 (PDT)
In-Reply-To: <20090423082328.GB30105@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 4:23 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Apr 23, 2009 at 01:08:51PM +0800, Eric Miao wrote:
>> The SSP DMA parameters can actually be easily generated at run-time since
>> they are almost similar except for the FIFO width and direction. Another
>> benefit is the re-use of information from 'struct ssp_device', like SSDR
>> physical FIFO address and DRCMR register index for both directions.
>
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>
> This looks like a win - is there any reason not to merge it without
> waiting for the rest of the series (I've not tested it yet)?
>

Should be no. I'll get this regenerated to be aligned with the current
code. Moment.

-- 
Cheers
- eric
