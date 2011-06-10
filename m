From: Sangbeom Kim <sbkim73@samsung.com>
Subject: RE: [alsa-devel] [PATCH 3/4] ASoC: SAMSUNG: Change platform driver	for
 SMDKs
Date: Fri, 10 Jun 2011 16:16:16 +0900
Message-ID: <000a01cc273e$49dc4610$dd94d230$@com>
References: <1307606950-8310-1-git-send-email-sbkim73@samsung.com>
 <1307606950-8310-4-git-send-email-sbkim73@samsung.com>
 <BANLkTinUk6CRdh8mYAk7fbd9Ga6iBRfcaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <BANLkTinUk6CRdh8mYAk7fbd9Ga6iBRfcaA@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jassi Brar' <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 9, 2011 at 4:04 PM, Jassi Brar wrote:
> NAK.
> It will break the most common user - SMDK6410, as s3c6410 doesn't have any
> I2S internal DMA.
> Please try to test the changes before submitting. I know it's boring,
> but it's even more important :)
> 
> Thanks

I only focused on S5PV210 and S5PV310.
I didn't consider s3c and s5p series.
In the next version, I will delete it.
But I had found some problem and want to share.
Like this patch, If different platform driver is used for each channel,
1st channel is overwritten by platform driver of 2nd channel.
Have you ever experienced before like this problem?

Thanks, 
SB Kim
