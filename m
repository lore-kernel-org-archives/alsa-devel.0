From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: Re: [PATCH 1/4] ASoC: max98373: Changed SPDX header in
 C++ comments style
Date: Thu, 18 Jan 2018 21:35:19 +0000
Message-ID: <BY2PR11MB08379E53A58E8C0853FB6708E7E80@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1515560521-10850-1-git-send-email-ryans.lee@maximintegrated.com>
 <20180110101506.GC9003@sirena.org.uk> <s5htvvuxbcr.wl-tiwai@suse.de>
 <20180110102940.GA13207@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0128.outbound.protection.outlook.com [104.47.42.128])
 by alsa0.perex.cz (Postfix) with ESMTP id ABF2E266E71
 for <alsa-devel@alsa-project.org>; Thu, 18 Jan 2018 22:35:23 +0100 (CET)
In-Reply-To: <20180110102940.GA13207@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Wednesday, January 10, 2018 2:30 AM
>To: Takashi Iwai <tiwai@suse.de>
>Cc: Ryan Lee <RyanS.Lee@maximintegrated.com>; alsa-devel@alsa-project.org;
>lgirdwood@gmail.com; ryan.lee.maxim@gmail.com; perex@perex.cz; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH 1/4] ASoC: max98373: Changed SPDX header in C++
>comments style
>
>On Wed, Jan 10, 2018 at 11:21:56AM +0100, Takashi Iwai wrote:
>> Mark Brown wrote:
>> > On Tue, Jan 09, 2018 at 09:01:58PM -0800, Ryan Lee wrote:
>
>> > > @@ -1,4 +1,4 @@
>> > > -/* SPDX-License-Identifier: GPL-2.0 */
>> > > +// SPDX-License-Identifier: GPL-2.0
>> > >  /* Copyright (c) 2017, Maxim Integrated */
>
>> > Please change the entire header to C++, mixing C and C++ on adjacent
>> > lines looks ugly.
>
>> I'm not sure whether it's a good direction to go, either.
>
>> I rather wonder why SPDX line *must* be in C++ comment style...
>
>Apparently it's to remove any ambiguity for the tooling or something, plus Linus
>decided he likes C++ comments.
>
>I don't understand why this isn't done as a macro like MODULE_LICENSE() and
>so on but the decision was rushed through and not really publicised
>:9

Thank you for your feedback.
I modified two header lines in C++ comment style and send it again.
