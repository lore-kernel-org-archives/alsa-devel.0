From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA and MediaController
Date: Tue, 17 May 2011 11:02:28 -0700
Message-ID: <20110517180227.GA14122@opensource.wolfsonmicro.com>
References: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F12410381A
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 20:02:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2011 at 12:48:59PM -0500, pl bossart wrote:

> - Is the list of ALSA controls is completely defined after the card
> initialization step? Or do we have cases where ALSA controls are
> created dynamically after the init? I tend to believe the former is
> true but want to verify this with others on the mailing list. It's my
> understanding that only connections may be changed in such a graph.

Currently it is static for at least ASoC but I'd expect this will change
as the DSP stuff gets more advanced.
