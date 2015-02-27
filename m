From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] ARM: TLV320AIC23 SoC Audio Codec: Fix
 errors reported related to input routing signals.
Date: Fri, 27 Feb 2015 14:16:40 +0100
Message-ID: <54F06E38.5020608@metafoo.de>
References: <1424950347-26241-1-git-send-email-dobatog@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-149.synserver.de (smtp-out-153.synserver.de
 [212.40.185.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 04627260703
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 14:16:40 +0100 (CET)
In-Reply-To: <1424950347-26241-1-git-send-email-dobatog@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gabriel Dobato <dobatog@gmail.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/26/2015 12:32 PM, Gabriel Dobato wrote:
> From: dobatog <dobatog@gmail.com>
>
> The following patch, based on stable v3.19,  corrects the errors that are reported in the boot trace in reference to the Input Signals of the audio codec TLV320AIC23:
>
> tlv320aic23-codec 1-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for LLINEIN --> NULL --> Line Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route LLINEIN -> NULL -> Line Input
> tlv320aic23-codec 1-001a: Control not supported for path RLINEIN -> [NULL] -> Line Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for RLINEIN --> NULL --> Line Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route RLINEIN -> NULL -> Line Input
> tlv320aic23-codec 1-001a: Control not supported for path MICIN -> [NULL] -> Mic Input
> tlv320aic23-codec 1-001a: ASoC: no dapm match for MICIN --> NULL --> Mic Input
> tlv320aic23-codec 1-001a: ASoC: Failed to add route MICIN -> NULL -> Mic Input
>
> I am trying to set the sound system in a CM-510 (Compulab - SoM) based board with DT, using Simple-Card-Audio and  the TLV320AIC23 audio codec included in the SoM . I faced this problem and thanks to the help of Sebastian Hesselbarth who noticed the possible error located in the structure snd_soc_dapm_route tlv320aic23_intercon[] , now errors are not reported.
>
> Tested on CM-510 (Compulab SoM Board).
>
> Signed-off-by: dobatog <dobatog@gmail.com>

Hi,

The patch itself looks good, but the commit message needs some work.

The subject line should be something like "ASoC: tlv320aic23: ..." to 
indicate that this is for the ASoC subsystem and the tlv320aic23 driver.

The commit message should be line-wrapped at around 76 characters.

Signed-off-by and From tag need to have your full name.

- Lars
