From: "Michel Benoit" <murpme@gmail.com>
Subject: Re: alsa on Atmel at91
Date: Fri, 11 May 2007 09:13:49 +0200
Message-ID: <c88e466f0705110013n72325746w3698f4627cbbea6e@mail.gmail.com>
References: <c88e466f0704151238q326df219uf95679897f4c44@mail.gmail.com>
	<1176827782.32188.224.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180218p708ba602h766f6a3f36c1add0@mail.gmail.com>
	<1176889951.32188.246.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180500l2f016c4bs28c6a3c1a3663575@mail.gmail.com>
	<1176900272.32188.274.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180745k1201ff11kc477d9cc8ebf899c@mail.gmail.com>
	<c88e466f0705100429w7a4e86deyfea22508370358fd@mail.gmail.com>
	<c88e466f0705100644q50f89fbfr3499a4491d741f2b@mail.gmail.com>
	<c88e466f0705100716j44711fdnaa6f83e2f27afa3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E6C9E24455
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 09:13:51 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so846809nzf
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 00:13:50 -0700 (PDT)
In-Reply-To: <c88e466f0705100716j44711fdnaa6f83e2f27afa3d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

> After reading up on .symvers it seems that there is a version number
> used to select which function to link against.
>
> If I look in the file src/Versions it seems that there is no
> definition for ALSA_1.0.13.  Could this be the problem?  I'm still
> trying to figure out how and where the version ALSA_X.X.X is passed in
> to the linker.

More research reveals that the symbol defined with @@ is the default
symbol taht is used when no version is given.  In my case the symbols
defined in pcm.c are:

.symver __snd_pcm_hw_params_get_period_size,snd_pcm_hw_params_get_period_size@@ALSA_0.9.0rc4
.symver __old_snd_pcm_hw_params_get_period_size,snd_pcm_hw_params_get_period_size@ALSA_0.9


and the __old version of the function should only be called if version
ALSA_0.9 is explicitely set by the app or somehow the default version
is being disabled or ignored.

Does anyone know how an application defines which version of symbols
it wants to use from a library?

Is there a way to disable symbol versioning in a lib?

Is any of this done explicitely as part of the alsa-lib and alsa-utils
build procedures?

Michel
