From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: fix uninitialized
	variable	warning
Date: Wed, 4 Aug 2010 10:02:24 +0100
Message-ID: <20100804090223.GA5864@sirena.org.uk>
References: <1280863226-6824-1-git-send-email-wfp5p@virginia.edu>
	<1280863226-6824-5-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C3DC024534
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 11:02:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280863226-6824-5-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 03, 2010 at 03:20:26PM -0400, Bill Pemberton wrote:
> quiet the warning about use of uninitialized fll_div in
> wm8900_set_fll.  fll_div is initialized by fll_factors()

> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>

Always remember to CC maintainers on patches as covered in SubmittingPatches.

>  sound/soc/codecs/wm8900.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
> index 5da17a7..f1840c6 100644
> --- a/sound/soc/codecs/wm8900.c
> +++ b/sound/soc/codecs/wm8900.c
> @@ -746,7 +746,7 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
>  	int fll_id, unsigned int freq_in, unsigned int freq_out)
>  {
>  	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
> -	struct _fll_div fll_div;
> +	struct _fll_div uninitialized_var(fll_div);
>  	unsigned int reg;

No, just stomping over the variable to shut up the warning doesn't
improve anything at all.  You need to make sure that the compiler can
actually follow the control flow to see that the data is always
initialised rather than disabling the check and missing any actual
issues.

I rather suspect this is just a bug in your compiler's flow analysis,
it's not showing up with GCC 4.3.3 on ARM for me.
