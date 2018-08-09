From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adav80x: mark expected switch
 fall-through
Date: Thu, 9 Aug 2018 13:23:58 +0200
Message-ID: <a68c854c-013a-8cb2-49de-5bb109b27fc3@metafoo.de>
References: <20180808191933.GA27767@embeddedor.com>
 <20180809093002.GB6132@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 928322677DA
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 13:24:01 +0200 (CEST)
In-Reply-To: <20180809093002.GB6132@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/09/2018 11:30 AM, Mark Brown wrote:
> On Wed, Aug 08, 2018 at 02:19:33PM -0500, Gustavo A. R. Silva wrote:
> 
>> @@ -648,6 +648,7 @@ static int adav80x_set_pll(struct snd_soc_component *component, int pll_id,
>>  			pll_ctrl1 |= ADAV80X_PLL_CTRL1_PLLDIV;
>>  			break;
>>  		}
>> +		/* fall through */
>>  	default:
>>  		return -EINVAL;
>>  	}
> 
> Are you *positive* this is a deliberate fall through?

It is. But it might make sense to re-order the code to look like

    case 54000000:
        if (source != ADAV80X_PLL_SRC_XIN)
            return -EINVAL;

        pll_ctrl1 |= ADAV80X_PLL_CTRL1_PLLDIV;
        break;

It is just as many lines added when adding the /* fall through */, but it
makes it more obvious what is going on.

Either way:

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
