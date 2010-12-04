From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source
 clock id and asoc platform device
Date: Sun, 5 Dec 2010 00:40:01 +0900
Message-ID: <AANLkTinw3+t=eVLRUiRhwPA2c_nZ7q7Kfm-QOBmsZLRT@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
	<20101203114416.GG3182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 53FE024414
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2010 16:40:02 +0100 (CET)
Received: by bwz8 with SMTP id 8so9624241bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 04 Dec 2010 07:40:02 -0800 (PST)
In-Reply-To: <20101203114416.GG3182@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 3, 2010 at 8:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

>> This patch modify to match ids between source clock id and asoc platform
>> device that spdif driver can find sclk_audio0 with device id.
>
> Something's seriously wrong if you need to do this...

It's necessary evil ATM.
There is no access to SPDIF device in machine code and we need to
get/set the clock.
So the soc-audio is used as a place-holder.
