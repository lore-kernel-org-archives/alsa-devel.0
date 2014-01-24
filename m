From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 3/3] ASoC: Samsung: Disable build on
	multiplatform
Date: Fri, 24 Jan 2014 17:25:09 +0530
Message-ID: <CAK9yfHxGquh+gVW4E6_=4Qax_HLxdPtF9paJW6GO7OiXObeMNg@mail.gmail.com>
References: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
 <1390560804-31135-3-git-send-email-sachin.kamat@linaro.org>
 <20140124113204.GT11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 84A9B261684
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 12:55:10 +0100 (CET)
Received: by mail-ob0-f173.google.com with SMTP id vb8so3513286obc.32
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 03:55:09 -0800 (PST)
In-Reply-To: <20140124113204.GT11727@sirena.org.uk>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Patch Tracking <patches@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 24 January 2014 17:02, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 24, 2014 at 04:23:24PM +0530, Sachin Kamat wrote:
>> Samsung sound drivers use mach/dma.h which is not available
>> on multiplatform. Hence disable audio support on multiplatform
>> build for now. Without this patch we get the following build errors:
>
> No, the thing to do here is fix the multiplatform build.

Yes this is only masking the build error temporarily until the code
becomes multi-platform aware.
Since legacy code is involved in this, I am not aware if it is going
to happen sooner than later.

-- 
With warm regards,
Sachin
