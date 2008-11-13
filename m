From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ARM DaVinci: Add Right-Justified mode and
	Codec clock master to davinci-i2s
Date: Thu, 13 Nov 2008 06:56:57 -0800
Message-ID: <878wrnk72e.fsf@deeprootsystems.com>
References: <1226168769-17776-1-git-send-email-hugo.villeneuve@lyrtech.com>
	<20081110114223.GB12804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20081110114223.GB12804-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Mon\, 10 Nov 2008 11\:42\:24 +0000")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> writes:

> On Sat, Nov 08, 2008 at 01:26:09PM -0500, hugo.villeneuve-alTlfEjb/c1BDgjK7y7TUQ@public.gmane.org wrote:
>> From: Hugo Villeneuve <hugo.villeneuve-alTlfEjb/c1BDgjK7y7TUQ@public.gmane.org>
>
>> ARM DaVinci: Add Right-Justified mode and Codec clock master to davinci-i2s
>
> Not a big deal but you shouldn't repeat the subject line of your patch
> in the body - it causes automated tools like git am to duplicate it in
> the commit mesage.
>
>> The TI DVEVM board uses the SND_SOC_DAIFMT_CBM_CFM & I2S formats, but the
>> Lyrtech SFFSDR board uses the SND_SOC_DAIFMT_CBM_CFS & RIGHT-JUSTIFIED formats.
>
> Is there any news on the progress of the new DaVinci DMA API to
> mainline?
>
>> Signed-off-by: Hugo Villeneuve <hugo.villeneuve-alTlfEjb/c1BDgjK7y7TUQ@public.gmane.org>
>
> Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>

OK, pulling into DaVinci git and will drop when resync with next ASoC.

Kevin
