From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc-core: move setting ac97 platform data
	earlier than	ac97 read/write
Date: Wed, 11 Nov 2009 11:28:18 +0000
Message-ID: <20091111112818.GB18005@opensource.wolfsonmicro.com>
References: <1257932475-5378-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26D0F2445E
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 12:28:19 +0100 (CET)
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
> 
> commit 474828a40f6ddab6e2a3475a19c5c84aa3ec7d60 adds platform_data to
> snd_ac97 instance. But ac97 platform data hasn't given to snd_ac97 until
> snd_soc_init_card. Then while ac97_read access platform_data of snd_ac97
> for detecting, NULL pointer oops will fire. That means old platform_data
> patch doesn't work in real-life cases.
> 
> This patch moves the operation of setting ac97 platform_data earlier
> than ac97 reading/writing operations. Then it makes platform_data of
> AC97 become practically useful.
> 
> Signed-off-by: Barry Song <21cnbao@gmail.com>

Applied, thanks.
