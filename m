From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] soc-core: move setting ac97
 platformdata earlier than ac97 read/write
Date: Thu, 12 Nov 2009 15:35:20 +0000
Message-ID: <20091112153520.GA24874@rakim.wolfsonmicro.main>
References: <1257998507-31864-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24891245F9
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 16:35:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257998507-31864-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Marek Vasut <marek.vasut@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 12, 2009 at 12:01:47PM +0800, Barry Song wrote:
> While probing, AC97 codec drivers and soc-core generically execute the
> following sequence:
> snd_soc_new_ac97_codec -> snd_soc_new_pcms -> reset ac-link/read AC97 ID
> to detect ->...  -> set platform_data to ac97 by soc-core

Applied, thanks.
