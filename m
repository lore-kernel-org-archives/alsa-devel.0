From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Have multiple opens removed on one device?
Date: Mon, 22 Aug 2011 12:21:43 +0100
Message-ID: <20110822112143.GB9232@opensource.wolfsonmicro.com>
References: <CAHG8p1BRN365PTyDxh-6UFWKtf_M-WcVZDGmuXB0W+CjTgPNGQ@mail.gmail.com>
	<s5hipppsqe9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41C3110386D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 13:21:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hipppsqe9.wl%tiwai@suse.de>
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
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 12:15:58PM +0200, Takashi Iwai wrote:
> Scott Jiang wrote:

> > In kernel 2.6.34 I can use aplay to play audio at the same time, alsa
> > will mix the audio.

> No, kernel part doesn't do such a thing.  If it's mixed, it must be
> in the user-space (either dmix or a daemon like pulseaudio), unless
> you hardware can do mixing by itself.

There *are* some cards (mostly older ones like emu10k) that support
multiple streams transparently but this has never been supported in
ASoC due a lack of hardware that can do it.
