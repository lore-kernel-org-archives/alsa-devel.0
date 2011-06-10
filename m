From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: SAMSUNG: Change platform driver
 for SMDKs
Date: Fri, 10 Jun 2011 16:13:31 +0530
Message-ID: <BANLkTinCSkCx7-AB8Ukfc4YqF3b8WmoBgA@mail.gmail.com>
References: <1307606950-8310-1-git-send-email-sbkim73@samsung.com>
	<1307606950-8310-4-git-send-email-sbkim73@samsung.com>
	<BANLkTinUk6CRdh8mYAk7fbd9Ga6iBRfcaA@mail.gmail.com>
	<000a01cc273e$49dc4610$dd94d230$@com>
	<BANLkTikswO-5LOreJq=OXutya_CzYUkh1g@mail.gmail.com>
	<20110610094920.GC26436@opensource.wolfsonmicro.com>
	<BANLkTinCKbPC0gTO5FJXn96wLMEUdZ+R3Q@mail.gmail.com>
	<20110610101638.GF26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110610101638.GF26436@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 3:46 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jun 10, 2011 at 03:42:27PM +0530, Jassi Brar wrote:
>> On Fri, Jun 10, 2011 at 3:19 PM, Mark Brown
>
>> > If iDMA is always a better choice on CPUs that support it then the
>> > cpu_is_() macros might be a good way to make the selection?
>
>> Actually I remembered just after I posted - iDMA wouldn't support capture.
>> So iDMA is a bad choice after all.
>
> So I guess the relevant boards would be better off adding a separate DAI
> to allow applications to select the DAI they want at runtime?

oops!  he is changing platform driver for the secondary i/f which
doesn't support
capture in the first place. So I think it can be done, though we need
to see if it
would be better to provide a way(control ?) to userspace to select
between sys/internal dma.
