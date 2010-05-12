From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Wed, 12 May 2010 15:16:54 +0100
Message-ID: <20100512141653.GB4312@sirena.org.uk>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C37DE1038A9
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 16:16:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
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
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 08:50:42AM -0500, pl bossart wrote:

> This might be almost equivalent to the timer approach in terms of # of
> wakeups, however the timer can be reprogrammed on-the-fly whereas
> periods can only be changed by closing and reopening the device. You
> can also adjust the timer shall underflows occur. And the timer slack
> lets the kernel group events. Not to mention that you will need

The timer is also useful for allowing PulseAudio to dynamically adjust
the period size as the runtime situation changes - if you're running
high latency streams and have a low latency application start up then
PulseAudio can just change the timer to get more frequent events.
