From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
Date: Tue, 21 Apr 2009 11:44:13 +0200
Message-ID: <20090421114413.61e52817@hyperion.delvare>
References: <20090420225659.7b92a184@hyperion.delvare>
	<s5h1vrmikm3.wl%tiwai@suse.de>
	<20090421112300.467e9f9b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F25B2460E
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 11:44:21 +0200 (CEST)
In-Reply-To: <20090421112300.467e9f9b@hyperion.delvare>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Apr 2009 11:23:00 +0200, Jean Delvare wrote:
> On Tue, 21 Apr 2009 08:31:00 +0200, Takashi Iwai wrote:
> > At Mon, 20 Apr 2009 22:56:59 +0200,
> > Jean Delvare wrote:
> > > 
> > > The legacy i2c binding model is going away soon, so convert the ppc
> > > keywest sound driver to the new model or it will break.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > ---
> > > Takashi, please push this patch to Linus quickly, as this is blocking
> > > the removal of the legacy i2c binding model, which is scheduled for
> > > 2.6.30.
> > > 
> > > I did not get any test report for this one, but it's relatively simple
> > > so I am confident I got it right.
> > 
> > Applied this one, too.  Thanks.
> 
> Thanks Takashi.
> 
> BTW, I forgot to mention again that the new i2c binding model is
> functional since kernel 2.6.25, so for the external alsa driver tree
> you will want to guard these changes with appropriate ifdef magic.

Err, make that 2.6.30, sorry. While the infrastructure was there since
2.6.25, the way I converted the sound drivers doesn't fit in what
earlier kernels considered acceptable (the checks on which driver
methods were implemented was a little too strict IMHO). So the
converted drivers can only be used with kernels >= 2.6.30.

-- 
Jean Delvare
