From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] ASoC: AD1980 codec: add multi-channel
	function support
Date: Thu, 23 Oct 2008 11:34:00 +0100
Message-ID: <20081023103359.GD10280@sirena.org.uk>
References: <1224752520-25668-1-git-send-email-cooloney@kernel.org>
	<1224752520-25668-3-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FC9D10385B
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 12:34:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1224752520-25668-3-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 05:01:58PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>

> We added multi-channel function to this codec driver and Blackfin ASoC driver as well.
> It was tested on Blackfin hardware.

The changelog entry is now inaccurate since this was split out from the
machine.  This looks mostly OK but...

> +	/*power on LFE/CENTER/Surround DACs*/
> +	ext_status = ac97_read(codec, AC97_EXTENDED_STATUS);
> +	ac97_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);

...this should have spaces around the & - I'm rather surprised that
checkpatch.pl doesn't pick that up (I just tested and it doesn't).
Otherwise,

Acked-by: Mark Brown <broonie@opensource.wolfsonicro.com>
