From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] ASoC: bt-sco: Add devicetree support for bt-sco codec
Date: Wed, 6 May 2015 21:38:55 +0200
Message-ID: <CAAfyv37jOJ=grVAM22-oLx2s6-8rXr2fVbgpNqkaJjwuEsHZ9Q@mail.gmail.com>
References: <1430856941-3938-1-git-send-email-marek@goldelico.com>
	<20150506121311.GP22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150506121311.GP22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, tiwai@suse.de, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, May 6, 2015 at 2:13 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 05, 2015 at 10:15:41PM +0200, Marek Belisko wrote:
>
>> +static const struct of_device_id bt_sco_codec_of_match[] = {
>> +     { .compatible = "delta,dfbmcs320", },
>> +     { .compatible = "linux,bt-sco", },
>
> Is there any burning reason for adding the linux,bt-sco compatible?
No no real reason just want to keep that if somebody would like use it from DT
referenced by bt-sco entry (similar as platform data). I'm adding DT
support for it because I want to use
this for W2CBW003 chip and I can use simply "linux,bt-sco" property in
DT or I instead of that add new vendor
prefix + add new compatible entry which is IMO much harder that
reference it by generic name.

Thanks,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
