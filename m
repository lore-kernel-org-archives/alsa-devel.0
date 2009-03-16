From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 9/9] ARM: DaVinci: ASoC: Adds build	support
	for DM646X audio driver
Date: Mon, 16 Mar 2009 15:29:15 +0000
Message-ID: <20090316152915.GH16539@sirena.org.uk>
References: <1237205187-30297-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 42BF8103856
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 16:29:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237205187-30297-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 16, 2009 at 08:06:27AM -0400, Naresh Medisetty wrote:

> +config SND_SOC_CODEC_STUBS
> +        tristate
> +

You need to add this to SND_SOC_ALL_CODECS.
