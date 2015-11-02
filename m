From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 1/2] ASoC: wm9713: convert to regmap
Date: Mon, 2 Nov 2015 09:06:36 +0000
Message-ID: <20151102090636.GM10520@ck-lbox>
References: <1446405820-24923-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 88F81260691
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 10:22:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1446405820-24923-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 01, 2015 at 08:23:39PM +0100, Robert Jarzmik wrote:
> Convert the Wolfson WM9713 to regmap API. This will leverage all the
> regmap functions (debug, registers update, etc ...).
> 
> As a bonus, this will pave the path to gpio chip introduction, and
> devicetree support. This was tested on the mioa701 board, pxa27x based,
> in PCM playback, and through suspend/resume.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: fix suspend/resume (that specific part is not tested yet)
> Since v2: split out the snd_soc_*() from regmap support
> Since v3: remove suspend/resume regmap cache operations, rely on
>           regmap volatile registers
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
