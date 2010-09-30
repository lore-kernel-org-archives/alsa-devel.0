From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: alsactl adds volume controls?
Date: Thu, 30 Sep 2010 13:36:56 -0700
Message-ID: <20100930203655.GD4175@opensource.wolfsonmicro.com>
References: <alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org> <4CA46E98.10402@ladisch.de>
	<4CA4A844.7060403@colin.guthr.ie>
	<20100930164753.GB9431@sirena.org.uk>
	<s5hr5gb9k83.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9BF4210397C
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 22:36:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr5gb9k83.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 08:09:32PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Is this perhaps just an error in the TLV information - should it be
> > flagging that the minimim gain is mute but isn't?

> There is no clear (or consistent) definition in HD-audio codec, I guess.

Oh, fail.  Of course, a sufficient attenuation is indistinguishable from
mute anyway which complicates matters a little.
