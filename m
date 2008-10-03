From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
 and ARM9 atmel boards.
Date: Fri, 03 Oct 2008 16:51:04 +0200
Message-ID: <48E63158.9020708@atmel.com>
References: <48E47D42.8080306@atmel.com>	<20081002150731.GH2848@sirena.org.uk>	<48E4F025.80907@atmel.com>	<20081002181211.GA3345@sirena.org.uk>	<48E613BB.6090003@atmel.com>	<20081003131411.GC26035@sirena.org.uk>	<48E62A89.8070803@atmel.com>	<20081003143523.GE26035@sirena.org.uk>
	<20081003164901.7ebddcd9@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 70B0224749
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 16:51:16 +0200 (CEST)
In-Reply-To: <20081003164901.7ebddcd9@hskinnemo-gx745.norway.atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Mark Brown <broonie@sirena.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

Hi Haavard,
Haavard Skinnemoen a =E9crit :
> Mark Brown <broonie@sirena.org.uk> wrote:
>> I'd still like to see this tested at least somewhat on AVR32, just to
>> make sure.  Even a build test would be good.
> =

> I can do a build test, but I don't have any board with a supported
> codec. Ideally, the at73c213 driver should be moved over to the SoC
> framework, but I'm not sure if I'll find much time to do it in the near
> future.
> =

> Haavard
> =

This will be my next task I think, I will try to move the at73c213 =

driver, but I wanted to have a clean ssc dai first.
