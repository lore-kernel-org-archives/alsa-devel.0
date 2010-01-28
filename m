From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/7] ASoC: S3C64XX: USE DMA info from
	platform data
Date: Thu, 28 Jan 2010 15:38:45 +0900
Message-ID: <1b68c6791001272238q6f421a2dxc2522a06e8855889@mail.gmail.com>
References: <1260332978-11475-1-git-send-email-jassisinghbrar@gmail.com>
	<20091209110024.GC19851@opensource.wolfsonmicro.com>
	<20100128042715.GR10014@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AFF2710381A
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 07:38:46 +0100 (CET)
Received: by vws17 with SMTP id 17so82194vws.38
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 22:38:45 -0800 (PST)
In-Reply-To: <20100128042715.GR10014@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2010 at 1:27 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Dec 09, 2009 at 11:00:24AM +0000, Mark Brown wrote:
>> On Wed, Dec 09, 2009 at 01:29:38PM +0900, jassisinghbrar@gmail.com wrote:
>> > From: Jassi Brar <jassi.brar@samsung.com>
>>
>> > Instead of hardcoding DMA channel numbers and address, for each controller
>> > in the driver, let the information be read from platform data.
>>
>> > Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>>
>> OK, but this needs to go along with the arch/arm side to avoid breaking
>> the driver.
>
> I've applied the arch/arm side of the patch already, as this was quite
> eassy to do. It is then a case of whether I should take the patch to
> remove it from sound/soc/s3c24xx/s3c64xx-i2s.c or should we wait until
> my/rmk's tree has been merged into the mainline?
btw, patch 5/7 http://mailman.alsa-project.org/pipermail/alsa-devel/2009-December/023782.html
is pending too for the same reason.
ofcourse, I will resend as you decide how to proceed.
thanks
