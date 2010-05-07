From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 10/11] ASoC: S3C64XX: IISv4: Add CPU driver
Date: Fri, 7 May 2010 10:33:39 +0900
Message-ID: <v2u1b68c6791005061833r9a98cbbbk771cce705d82a5cd@mail.gmail.com>
References: <1272351431-3981-1-git-send-email-jassi.brar@samsung.com>
	<20100505143046.GA9530@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 430DD24151
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 03:33:41 +0200 (CEST)
Received: by vws1 with SMTP id 1so546594vws.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 18:33:39 -0700 (PDT)
In-Reply-To: <20100505143046.GA9530@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, May 5, 2010 at 11:30 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Apr 27, 2010 at 03:57:11PM +0900, Jassi Brar wrote:
>> Add the CPU driver for the IISv4 block found on S3C6410.
>> For now, the driver is almost a copy of s3c64xx-i2s.c but
>> it should diverge as more IISv4 specific stuff is added.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>
> Actually, this is the first patch that seems to have an issue so I've
> applied the patches up till this point.
That is strange, because I am able to cleanly apply these 11 patches
against commit  cb7cf44c880aeb8caf8 of for-2.6.35
Could you please try again?
Thanks
