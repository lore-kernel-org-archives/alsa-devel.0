From: maximilian attems <max@stro.at>
Subject: Re: Bug#568806: linux-image-2.6.32-trunk-amd64:
	Internal mic of dell m1330 stopped working with 2.6.32 kernel
Date: Sun, 7 Mar 2010 23:44:26 +0100
Message-ID: <20100307224426.GK7231@baikonur.stro.at>
References: <20100207210451.16232.9913.reportbug@laptop.sjoerd.lan>
	<20100207213459.GP9624@baikonur.stro.at>
	<4B8E369A.20305@lorentz.leidenuniv.nl>
	<20100304210505.GB2255@stro.at>
	<4B9228E4.9040309@lorentz.leidenuniv.nl>
	<20100306185202.GA4051@stro.at>
	<4B93E0DE.8060309@lorentz.leidenuniv.nl>
	<20100307173548.GI7231@baikonur.stro.at>
	<4B941ACD.9070500@lorentz.leidenuniv.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from baikonur.stro.at (baikonur.stro.at [213.239.196.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A480244F3
	for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2010 23:51:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B941ACD.9070500@lorentz.leidenuniv.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sjoerd Hardeman <sjoerd@lorentz.leidenuniv.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, 568806@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

[ adding alsa dev on cc ]
hda regression on 2.6.32, see full report on 
http://bugs.debian.org/568806

On Sun, Mar 07, 2010 at 10:29:49PM +0100, Sjoerd Hardeman wrote:
> > 
> > you could try before unload hda snd module and pass all its different
> > variants, see Documentation/sound/alsa/HD-Audio-Models.txt
> That was a good idea. It took some time, but the option "model=dell-md6"
> worked, as well as "model=dell-m23". SO I probably need to file a bug
> that the auto-recognition stopped working?

please provide alsa-info.sh output in working and nonworking case.
so that alsa devs can see the diff.

thanks
