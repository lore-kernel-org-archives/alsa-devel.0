From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Errors in application building
Date: Wed, 11 Jul 2007 09:49:11 -0500
Message-ID: <61c0054e0707110749v199c9d89qf18732e3ce999e18@mail.gmail.com>
References: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
	<61c0054e0707031206i1717e36dy8e69c872b4f33a@mail.gmail.com>
	<61c0054e0707031240y6d60fed3yea2317b8ad888110@mail.gmail.com>
	<75b66ecd0707031247h842da9j97bce3f85cda33b1@mail.gmail.com>
	<61c0054e0707031414r7565c10ax3edab20bd78d4d4c@mail.gmail.com>
	<61c0054e0707051142h46cd5beer29d91e8b6fd4560c@mail.gmail.com>
	<61c0054e0707101219i5e414590r598b45767e7b462d@mail.gmail.com>
	<20070710155712.18ee1c94.AlsaUser@PragmaSoft.com>
	<61c0054e0707101418h461afc13sdc9ec6e9d37a8d07@mail.gmail.com>
	<61c0054e0707110739l29a9f71cmf18354eccb5b9f70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A8A310386E
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 16:49:13 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so127888ugf
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 07:49:11 -0700 (PDT)
In-Reply-To: <61c0054e0707110739l29a9f71cmf18354eccb5b9f70@mail.gmail.com>
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
To: "J. Scott Merritt" <AlsaUser@pragmasoft.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Do the alsa libraries link to pthread? If so, I should probably be
> compiling with -lpthread. Does anyone else see something I am missing that
> could be causing the segfault?



compiling with -lpthread appears to have solved the segfault issue. I do not
get that error when I do not include the alsa lib, so I assume something in
there is linking to pthread--I am not familiar enough yet with alsa to know
for sure.

Now I will continue building in the audio funtionality to see if I can get
it rolling.

Paul


-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
