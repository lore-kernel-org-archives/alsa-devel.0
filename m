From: "Sudhakar Rajashekhara" <sudhakar.raj@ti.com>
Subject: Re: [PATCH 1/3] ASoC: DaVinci: Added two clocking
	possibilities to McBSP (I2S)
Date: Tue, 6 Jul 2010 17:00:24 +0530
Message-ID: <43818.6673484326$1278416125@news.gmane.org>
References: <1278405544-3852-1-git-send-email-lamiaposta71@gmail.com>	
	<1278405544-3852-2-git-send-email-lamiaposta71@gmail.com>
	<1278409559.3103.136.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 556D42440E
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 13:35:13 +0200 (CEST)
In-Reply-To: <1278409559.3103.136.camel@odin>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Liam Girdwood' <lrg@slimlogic.co.uk>, 'Raffaele Recalcati' <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, 'Takashi Iwai' <tiwai@suse.de>, linux-kernel@vger.kernel.org, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, 'Davide Bonfanti' <davide.bonfanti@bticino.it>, 'Raffaele Recalcati' <raffaele.recalcati@bticino.it>, 'Troy Kisky' <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Jul 06, 2010 at 15:15:59, Liam Girdwood wrote:
> On Tue, 2010-07-06 at 10:39 +0200, Raffaele Recalcati wrote:
> > From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> > 
> >     Added two clocking options for dm365 McBSP peripheral when used
> >     with I2S timings, that are SND_SOC_DAIFMT_CBS_CFS (the cpu generates
> >     clock and frame sync) and SND_SOC_DAIFMT_CBS_CFM (the cpu gets clock
> >     from external pin and generates frame sync).
> >     A slave clock management can be important when the external codec needs
> >     the system clock and the bit clock synchronized (tested with uda1345).
> >     This patch has been developed against the:
> >         http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> >     git tree and has been tested on bmx board (similar to dm365 evm, but using
> >     uda1345 as external audio codec).
> > 
> > Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> > Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>
> 
> All
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
> 
> But lets get some feedback from the DaVinci folks on this too.
> 

Acked-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Regards,
Sudhakar
