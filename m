From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 13:04:46 +0100
Message-ID: <20100722120446.GG4737@rakim.wolfsonmicro.main>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
	<201007221357.16840.peter.ujfalusi@nokia.com>
	<201007221407.18882.peter.ujfalusi@nokia.com>
	<s5hpqyfzrcg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BE6A243F7
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 14:04:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpqyfzrcg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Aaltonen Matti.J (Nokia-MS/Tampere)" <matti.j.aaltonen@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 22, 2010 at 01:30:23PM +0200, Takashi Iwai wrote:

> The hw constrains are basically for hw_params setup.  So, the question
> is whether do we want to make open successful but further setup fails,
> or do we give the error at open time?  IMO, the latter looks
> straightforward.  That is, changing the flag before open call is
> needed, or we need to check explicitly in the open callback itself.

> Or, let me know if I misunderstand the discussion here...

I think you understand correctly but we decided we can just totally
ignore this setting since from the point of view of application software
it can happily do full duplex operations with this device, the device
will just discard the data sent to it in some configurations.
