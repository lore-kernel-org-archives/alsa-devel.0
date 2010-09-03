From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Fri, 3 Sep 2010 14:20:47 +0300
Message-ID: <20100903142047.c70c21c8.jhnikula@gmail.com>
References: <20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
	<20100824101032.GA15278@rakim.wolfsonmicro.main>
	<20100825135922.5589ba30.jhnikula@gmail.com>
	<20100826133229.GA3803@opensource.wolfsonmicro.com>
	<20100830141729.75388459.jhnikula@gmail.com>
	<20100902142518.GA5809@rakim.wolfsonmicro.main>
	<20100903105532.07894824.jhnikula@gmail.com>
	<20100903093345.GA16587@rakim.wolfsonmicro.main>
	<1283508057.3069.46.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BB4F9243F9
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 13:20:27 +0200 (CEST)
Received: by eyd9 with SMTP id 9so919458eyd.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2010 04:20:24 -0700 (PDT)
In-Reply-To: <1283508057.3069.46.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 03 Sep 2010 11:00:57 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > I think I'd like a firm idea of how the cross device DAPM works before
> > we do anything with the prefixes since there's some overlap there (if
> > only due to the fact that half the controls come from DAPM), even if the
> > cross device DAPM doesn't actually work yet.  I think your current code
> > is probably going to work well with DAPM but I need to have a bit of a
> > think about that over the weekend.
> 
Ok, sounds good. Doing DAPM first avoids that there is no then need to
go back and forth with prefixing.

> I've made some initial progress here with DAPM by de-coupling it from
> CODEC drivers. So I now have a struct dapm_context * in the codec,
> platform and machine drivers. I just now need to get some time to
> experiment with the best way to hook them all up.
> 
> It's currently in my L24.9 branch, although the patches are in need of
> clean up and squashing so are not ready for upstream yet.
> 
Thanks for info. Have to give a try to it :-)


-- 
Jarkko
