From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: Re: [PATCH 2/2] ALSA: ca0106: Fix mixer and dac
 channel	assignments.
Date: Wed, 22 Sep 2010 00:24:56 +1000
Message-ID: <1285079096.5919.0.camel@marvin>
References: <1285077079-5519-1-git-send-email-andy-alsa@ultra-premium.com>
	<1285077079-5519-2-git-send-email-andy-alsa@ultra-premium.com>
	<s5hhbhjdwn9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E55E2434C
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 16:25:03 +0200 (CEST)
In-Reply-To: <s5hhbhjdwn9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-09-21 at 16:00 +0200, Takashi Iwai wrote:
> I wonder whether this can regress on other boards.
> The front channel is the obvious channel so this must have been
> tested.  Maybe we should change the mapping only for your specific
> model by adding some flag.

The behaviour I was seeing was that if I just added the device id, then
the front channel would work fine, but I would get no sound from the
rears, and the mixer controls didn't quite match the labels. 

I was a bit suspect of this change:

> -     if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
> +     if (chip->details->spi_dac) {

But I convinced myself that it was a hack to work around the registers
being wrong in other places, and the card in its default state had the
front dac already powered up. Looking at the code, I can see similar
logic in the snd_ca0106_pcm_close_playback() function, which has a
special case for the front channel, and I think should also be modified.

I'll put together some revised patches (with sign offs and the proposed
fix) hopefully tomorrow.

If anyone has a ca0106 card that they can test this with, it would be
much appreciated.

Andy
