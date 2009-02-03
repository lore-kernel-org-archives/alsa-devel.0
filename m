From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: uda1380: split set_dai_fmt into
	_both, _playback and _capture variants
Date: Tue, 3 Feb 2009 17:45:10 +0100
Message-ID: <74d0deb30902030845h2320deafj7f66921b22f91069@mail.gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-2-git-send-email-philipp.zabel@gmail.com>
	<20090203164132.GG23827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F3B910387B
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:45:11 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so878754ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:45:10 -0800 (PST)
In-Reply-To: <20090203164132.GG23827@sirena.org.uk>
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
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 3, 2009 at 5:41 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Feb 03, 2009 at 05:19:40PM +0100, Philipp Zabel wrote:
>> This patch splits set_dai_fmt into three variants (single interface,
>> dual interface playback only, dual interface capture only) so that
>> data input and output formats can be configured separately for dual
>> interface setups.
>
>> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>
> Is there any reason not to apply this immediately?

Not that I am aware of. Maybe Vasily can test this patch first.
(I can only test the dual interface case.)

regards
Philipp
