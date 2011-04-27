From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: prevent compilers from optimising
 pll calculation into __aeabi__uldivmod
Date: Wed, 27 Apr 2011 09:49:04 +0100
Message-ID: <20110427084904.GA16666@opensource.wolfsonmicro.com>
References: <1303889252-6722-1-git-send-email-bs14@csr.com>
	<s5h8vuwgl7f.wl%tiwai@suse.de>
	<BANLkTi=RuNgN_+26GBrwoHJuz1xSM=YcfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2EBB61038D0
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 10:48:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=RuNgN_+26GBrwoHJuz1xSM=YcfQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, Barry Song <bs14@csr.com>, Takashi Iwai <tiwai@suse.de>, Zhiwu Song <zhiwu.song@csr.com>, Binghua Duan <binghua.duan@csr.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 27, 2011 at 04:24:44PM +0800, Barry Song wrote:
> 2011/4/27 Takashi Iwai <tiwai@suse.de>:

> > Don't do this in the low driver level. =A0If any, we should fix do_div()
> > instead.

> do_div is just a macro, it has no problem by itself. only while
> working together with other more codes before do_div, gcc can make
> some codes merging and cause problems.

> if do_div is a function, we'd just fix it.

It's a macro which expands to a problem so we should make it expand to
something which includes the fix as well rather than going round and
fixing each and every caller.
