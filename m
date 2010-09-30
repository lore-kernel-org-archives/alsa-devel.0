From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: alsactl adds volume controls?
Date: Thu, 30 Sep 2010 17:47:53 +0100
Message-ID: <20100930164753.GB9431@sirena.org.uk>
References: <s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org> <4CA46E98.10402@ladisch.de>
	<4CA4A844.7060403@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 808141037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 18:47:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA4A844.7060403@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 04:09:56PM +0100, Colin Guthrie wrote:

> *shouldn't* use them, but at present it does and they *are* active and
> used, so it's not an issue for me), the problem is rather one of setting
> Master (not PCM) to 0% aka -46.5dB causes some kind of auto-mute that
> cuts off all sound. It shouldn't do that. I've not muted it. I've set it

Is this perhaps just an error in the TLV information - should it be
flagging that the minimim gain is mute but isn't?
