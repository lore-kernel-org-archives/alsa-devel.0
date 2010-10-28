From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: New SoC layer codec registration problem
Date: Thu, 28 Oct 2010 19:33:03 +0100
Message-ID: <20101028183302.GA14076@sirena.org.uk>
References: <1288257140.2098.41.camel@r60e>
	<AANLkTi=wCBkw7v7xMwbcf7F_qQSyD6zb=HTnqeD+EGHM@mail.gmail.com>
	<1288281110.2098.47.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4958110380B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 20:33:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288281110.2098.47.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, Victor Rodriguez <vm.rod25@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 28, 2010 at 07:51:50PM +0400, Alexander wrote:

Please remember to always CC maintainers, messages sent only to the
mailing list are likely to get dropped on the floor.

> Oh, no, this part is correct, I'm sure.
> The question is why fmt_single_name() picks up "spi0.0" instead of
> "cs4271-codec", I've added some debug output. And this function relies

We identify devices based on something unique per device so that if you
have more than one device of the same type in a system the stack can
tell them apart.
