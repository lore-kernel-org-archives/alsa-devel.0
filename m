From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Fix double free and memory leak in
 many codec drivers
Date: Tue, 26 Aug 2008 14:23:47 +0200
Message-ID: <20080826142347.669f86f3@hyperion.delvare>
References: <1219661360-3555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljyle2ft.wl%tiwai@suse.de>
	<20080825121147.GA24258@sirena.org.uk>
	<s5htzd8c6jn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A80010382C
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 14:23:56 +0200 (CEST)
In-Reply-To: <s5htzd8c6jn.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Aug 2008 14:19:40 +0200, Takashi Iwai wrote:
> At Mon, 25 Aug 2008 13:11:49 +0100,
> Mark Brown wrote:
> > 
> > On Mon, Aug 25, 2008 at 01:53:10PM +0200, Takashi Iwai wrote:
> > 
> > > This looks like a 2.6.27 material, right?
> > 
> > Ideally, yes.
> 
> FYI, it was merged to the upstream.

Great, thanks Takashi.

-- 
Jean Delvare
