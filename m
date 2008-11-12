From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] ASoC: s3c24xx 8 bit sound fix
Date: Wed, 12 Nov 2008 15:10:38 +0000
Message-ID: <20081112151036.GE8767@sirena.org.uk>
References: <20081112115507.GA22288@rakim.wolfsonmicro.main>
	<1226490949-22360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226490949-22360-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hzlk5jf8h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 11A5F24481
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:10:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzlk5jf8h.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Christian Pellegrin <chripell@gmail.com>, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 01:33:34PM +0100, Takashi Iwai wrote:

> I still feel a bit uncomfortable with this as it changes the global
> variables.  Maybe better to assign the corresponding fields in the
> local struct.

The global variable is used to tell the DMA driver how to set the
hardware up for the port.  Since the variable is tied to the underlying
hardware channel it's used for there's no real win from duplicating it
into a variable - the hardware it is used to configure can't be shared.
