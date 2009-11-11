From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc-core: move setting ac97 platform data
	earlier than	ac97 read/write
Date: Wed, 11 Nov 2009 11:33:20 +0000
Message-ID: <20091111113320.GC18005@opensource.wolfsonmicro.com>
References: <1257932475-5378-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E1C124465
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 12:33:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257932475-5378-1-git-send-email-21cnbao@gmail.com>
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

On Wed, Nov 11, 2009 at 05:41:15PM +0800, Barry Song wrote:
> While probing, AC97 codec drivers generically execute the following sequence:
> snd_soc_new_ac97_codec -> snd_soc_new_pcms -> reset ac-link/read AC97 ID to
> detect ->...  -> snd_soc_init_card

Actually, could you please regenerate this against current ASoC, it
doesn't apply.
