From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0 internal
	dma driver
Date: Tue, 19 Jul 2011 08:44:18 +0900
Message-ID: <CA+s+8rchRUNdVGXQsdRgOyE5hj5pOBvQ3MhjZaukogFFRyBmgg@mail.gmail.com>
References: <1310520321-11106-1-git-send-email-sbkim73@samsung.com>
	<CA+s+8rc=nwggHhX7qZ0sCsH=z6qTDj9Gc2385xLgK0R+An85wQ@mail.gmail.com>
	<CABb+yY31mq-uber-iaXBSsCCYoq0W04whVzFHd6XEfshxwpT+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E9AC7248A7
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 01:44:19 +0200 (CEST)
Received: by wyh21 with SMTP id 21so1625529wyh.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2011 16:44:18 -0700 (PDT)
In-Reply-To: <CABb+yY31mq-uber-iaXBSsCCYoq0W04whVzFHd6XEfshxwpT+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi Jassi,

On Wed, Jul 13, 2011 at 2:41 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Wed, Jul 13, 2011 at 8:38 AM, Seungwhan Youn <claude.youn@gmail.com> wrote:
>> Hi,
>>
>> On Wed, Jul 13, 2011 at 10:25 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
>>> I2S in Exynos4 and S5PC110(S5PV210) has a internal dma.
>>> It can be used low power audio mode and 2nd channel transfer.
>>> This patch can support idma.
>>>
>>> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
>>> ---
>> In this case, MAX_IDMA_BUFFER is 160k and MAX_IDMA_PERIOD is 128k,
>> buffer is not twice of period. If you set like this, many of general
>> ALSA applications return error on initial buffers.
> I don't think so. Did you see any such problem ?
> In my opnion, ALSA will always use 2 periods of approx. MAX_IDMA_BUFFER/2 bytes

I'm sorry for late reply. Yes, I was wrong. After your reply, I tested
simple speaker-test with applying this patch, and it worked correctly.
I'm sorry for this conflict.
