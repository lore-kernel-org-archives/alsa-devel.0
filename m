From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Mon, 06 Feb 2012 10:37:03 +0000
Message-ID: <1328524623.6799.9.camel@odin>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id BE5D4103A54
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 11:37:19 +0100 (CET)
Received: by mail-ww0-f46.google.com with SMTP id dt14so4056876wgb.27
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 02:37:06 -0800 (PST)
In-Reply-To: <20120203204640.GD23505@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-02-03 at 20:46 +0000, Mark Brown wrote:
> On Fri, Feb 03, 2012 at 05:43:09PM +0000, Liam Girdwood wrote:
> 
> > 1) Use snd_soc_add_card_controls() where no direct codec control is required.
> > 2) Use snd_soc_add_codec_controls() where there is direct codec control.
> 
> > In the case of 1) above we also update the machine drivers to get the correct
> > component data pointers from the kcontrol (rather than getting the machine pointer
> > via the codec pointer).
> 
> Hrm, I can't apply this right now as I don't have an appropriate system
> to hand but what are the cases where there is CODEC control?  This
> sounds suspicous, perhaps we need some of the drivers enhancing (though
> no reason to block this patch).

There were some machine drivers that would just do a little extra
indirection (getting the soc_card via the kcontrol codec ptr) with their
kcontrols to access the machine private data. The patch fixed the
appropriate machine drivers so that they can access soc_card directly
now.

There was also the McBSP DAI using the codec ptr for a similar purpose.

The other machine drivers were all using the codec pointer to do extra
codec configuration with their kcontrol code so there was no update for
them.

Liam  
