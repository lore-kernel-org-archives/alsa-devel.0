From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
 and ARM9 atmel boards.
Date: Thu, 02 Oct 2008 18:00:37 +0200
Message-ID: <48E4F025.80907@atmel.com>
References: <48E47D42.8080306@atmel.com> <20081002150731.GH2848@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 795AE2439C
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 18:00:51 +0200 (CEST)
In-Reply-To: <20081002150731.GH2848@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown a =E9crit :
> On Thu, Oct 02, 2008 at 09:50:26AM +0200, Sedji Gaouaou wrote:
> =

>> Create a common directory for AVR32 and ARM9 atmel boards to unify atmel =

>> audio DAI.
> =

>> Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
> =

> Hrm.  It doesn't look like playpaq_wm8510.c will build after this change
> - for one thing, at32-pcm.h and at32-ssc.h don't exist any more in the =

> new atmel directory but there's no change to the file to reflect that.
> If you're unable to test AVR32 yourself then perhaps Geoffrey (CCed)
> will be able to help out here?
> =

Yes my mistake!! I will change change right now. Nevertheless I don't =

even have a AVR compiler so I can't really test the AVR code....
> Also, please note the changes to the playpaq driver which were made in
> commit c2d8a0f79a63e3d3ead52fba3a6300f86514758b which was merged into
> Takashi's tree the other day.
>
Again my mistake :)
> Can I also suggest splitting this up so that you do the merge of the
> existing code in one patch then add your new board drivers in another?
> If nothing else it'd bring down the size of the main diff.  :)
> =

Ok, no worries. I will create:
	a patch that contains the atmel_ssc_dai.c and .h file,
	a patch for the atmel-pcm.c/.h files
	a patch playback_wm8510.c and sam9g20_wm8731.c files.
	a patch for the Makefile and the Kconfig.

Is that ok?
