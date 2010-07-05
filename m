From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: issue with TWL4030
Date: Mon, 05 Jul 2010 22:40:40 +0100
Message-ID: <1278366040.3258.238.camel@odin>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<20100703000635.GA3533@sirena.org.uk>
	, <AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
	<C358A26273CF2948B8BCDBA661A581782A6FBF945F@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E96E103809
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 23:40:39 +0200 (CEST)
Received: by fxm15 with SMTP id 15so4110792fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2010 14:40:38 -0700 (PDT)
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A6FBF945F@NOK-EUMSG-03.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-07-05 at 23:13 +0200, peter.ujfalusi@nokia.com wrote:

> While I agree with Mark, that OSS emulation should be phased out now (it's 2010)..
> However, extending the state handling might fix your problem, but it complicates
> things greatly, which can lead to more problems...

Just to further clarify wrt OSS emulation here, it was decided at last
years Plumbers conference audio session (where Mark and I were both in
attendance along with Paul Davis, Lennart Poettering and a lot of distro
folks) that the distros would start dropping OSS support from their
default installs (although OSS could still be installed manually later).

In light of this, new ASoC code will no longer be tested against OSS
emulation. It's just too much of a pain to implement and test for too
little benefit for us (we will still accept OSS emulation patches
though).

Please port your app to ALSA, it's really the easiest option (look at
aplay.c for programming sequence). 

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
