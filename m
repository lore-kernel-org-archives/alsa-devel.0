From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Fri, 01 Oct 2010 08:44:29 +0200
Message-ID: <4CA5834D.5030408@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>
	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>
	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>
	<s5hr5gb9k83.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 1B8271039C2
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 08:43:40 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Mark Brown wrote:
> > On Thu, Sep 30, 2010 at 04:09:56PM +0100, Colin Guthrie wrote:
> > > *shouldn't* use them, but at present it does and they *are* active and
> > > used, so it's not an issue for me), the problem is rather one of setting
> > > Master (not PCM) to 0% aka -46.5dB causes some kind of auto-mute that
> > > cuts off all sound. It shouldn't do that.
> > 
> > Is this perhaps just an error in the TLV information - should it be
> > flagging that the minimim gain is mute but isn't?
> 
> There is no clear (or consistent) definition in HD-audio codec, I guess.

The HDA spec is quite clear that muting is done only with the mute bit.

> Some chips do mute at 0 and some not.

Those that do are violating the specification.

But we have to support them anyway.
Colin, please tell us the IDs of your codec so that we can add a TLV
workaround to the driver.


Regards,
Clemens
