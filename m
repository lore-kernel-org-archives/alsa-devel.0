From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
 and ARM9	atmel boards.
Date: Fri, 03 Oct 2008 14:44:43 +0200
Message-ID: <48E613BB.6090003@atmel.com>
References: <48E47D42.8080306@atmel.com> <20081002150731.GH2848@sirena.org.uk>
	<48E4F025.80907@atmel.com> <20081002181211.GA3345@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D2052470E
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 14:44:54 +0200 (CEST)
In-Reply-To: <20081002181211.GA3345@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

Hi
Mark Brown a =E9crit :
> On Thu, Oct 02, 2008 at 06:00:37PM +0200, Sedji Gaouaou wrote
> Ah, right.  While I understand that the hardware is pretty much identical
> are you sure that the APIs for accessing it are the same on both AVR32
> and AT91?  My understanding was that there was some work required to
> handle both but I've no familiarity with either architecture.
> =

> CCing in Haavard Skinnemoen for AVR32 advice: Haavard, Sedji is submitting
> patches which unify the audio support for AT91 and AVR32.
> =

Actually I based my patch on the at32-pcm and at32-ssc files which were =

based on at91-ssc and at91-pcm files, so I don't think there should be =

any differences.

Regards,
Sedji
