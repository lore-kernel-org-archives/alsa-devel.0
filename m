From: Mans Rullgard <mans.rullgard@linaro.org>
Subject: Re: ASoC: auto-loading board-specific modules
Date: Thu, 8 Sep 2011 00:37:56 +0100
Message-ID: <CAG5Tg6X50WVUx8zBGDFT7TMoY+4qrnKdbsT11eLUUvmfu02jLg@mail.gmail.com>
References: <CAG5Tg6VzdgPLG4L9how4-L8SJHVrEk+Twh9QcKnVF_-rVPka+w@mail.gmail.com>
	<20110907223535.GA9557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 4126524461
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 01:37:58 +0200 (CEST)
Received: by pzk1 with SMTP id 1so335159pzk.2
	for <alsa-devel@alsa-project.org>; Wed, 07 Sep 2011 16:37:56 -0700 (PDT)
In-Reply-To: <20110907223535.GA9557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7 September 2011 23:35, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Sep 07, 2011 at 11:16:47PM +0100, Mans Rullgard wrote:
>
> Always CC maintainers. =A0Please folks, this shouldn't be hard to work
> out.
>
>> Currently in ASoC, there is for each supported board a module describing=
 the
>> board-specific DAI links by creating a "soc-audio" platform device with =
an
>> associated struct snd_soc_card.
>
> No, this has not been the case for new drivers for quite some time now
> and new drivers trying to do this get rejected. =A0You should probe using
> a regular device and use snd_soc_register_card() to register the card.

Is there some driver that does it right I could look at as a template for
fixing at least some of the old ones?

-- =

Mans Rullgard
Multimedia
mans.rullgard@linaro.org
