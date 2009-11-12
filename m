From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] add support to reorder CPU and Codec DAI
	suspend/resume
Date: Thu, 12 Nov 2009 13:47:36 +0800
Message-ID: <3c17e3570911112147y40c3ebd9q85f99decfdefff78@mail.gmail.com>
References: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
	<20091111112431.GA18005@opensource.wolfsonmicro.com>
	<3c17e3570911110448v7f7da90bs8ecad60c4afda5bc@mail.gmail.com>
	<20091111142050.GB32595@sirena.org.uk>
	<3c17e3570911110634k60ecc02fwf52c168e9f5ad7a2@mail.gmail.com>
	<20091111144252.GB20417@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f215.google.com (mail-gx0-f215.google.com
	[209.85.217.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B5451037F7
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 06:47:56 +0100 (CET)
Received: by gxk7 with SMTP id 7so2663462gxk.12
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 21:47:56 -0800 (PST)
In-Reply-To: <20091111144252.GB20417@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 10:42 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Nov 11, 2009 at 10:34:00PM +0800, Barry Song wrote:
>
>> The only difference should be whether clock/sync is fired from codec
>> before or after TDM interfaces are resumed to be ready for the
>> different resume order of CPU and Codec DAI, as I guess. That's
>> difficult to explain why.
>
> It'd really like to understand what's going wrong with the controller
> here - it should just sync up off the frame sync signal.

Don't know what happens exactly in hardware controllers . But I
"fixed" this porblem by isolating interfaces's sync/clock pins from
Codec(config them to GPIOs), then the whole system gets normal. Since
you have a plan for pm-link, I will use this way to keep the fix in
blackfin locally.

>
