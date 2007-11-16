From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: No sound on Intel DQ965GF motherboard
Date: Fri, 16 Nov 2007 10:21:17 -0500
Message-ID: <20071116152117.GA14292@thyrsus.com>
References: <20071116061042.C5E9D830734@snark.thyrsus.com>
	<s5hwssibvkp.wl%tiwai@suse.de>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snark.thyrsus.com (static-71-162-243-5.phlapa.fios.verizon.net
	[71.162.243.5]) by alsa0.perex.cz (Postfix) with ESMTP id 8BE6724334
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 16:21:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwssibvkp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de>:
> If you're using 2.6.24-rc* kernel (or did 1.0.15 backports), make sure
> that you enabled all CONFIG_SND_HDA_CODEC_* configs.  Some people tend
> to reduce options as much as possible although they are suggested as
> default=y.

I'm using 2.6.22, which is the level of the stock Ubuntu 7.10 kernel.
It has only one config symbol matching SND_HDA: CONFIG_SND_HDA_INTEL.
I rebuilt the snd_hda_module from those sources.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
