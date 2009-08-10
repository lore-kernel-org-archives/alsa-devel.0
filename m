From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 15:30:35 +0200
Message-ID: <4A8020FB.7080302@ladisch.de>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>	<4A7FCF0A.1000806@ladisch.de>	<9e4733910908100445u3ea02395y9dc39b73ad41cb6b@mail.gmail.com>	<4A800B47.6020201@ladisch.de>	<9e4733910908100524w510ba17ep2d6482cdfad57597@mail.gmail.com>	<4A8012B4.5000009@ladisch.de>	<9e4733910908100541y495f491cy7a25351a8c36f3dd@mail.gmail.com>	<20090810124350.GB24947@sirena.org.uk>
	<9e4733910908100546r5fa2e189s12ff72c3217c271a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8A12B1038AA
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 15:30:25 +0200 (CEST)
In-Reply-To: <9e4733910908100546r5fa2e189s12ff72c3217c271a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> Does this link them?
> snd_pcm_set_sync(substream); in open()

No; this sets the substream's sync ID which tells userspace applications
that the driver actually supports sync start together with other
substreams with the same ID.

Linking is done by an application with snd_pcm_link().  The driver does
not get a notification of this; it notices this only in the trigger
callback, where the loop goes over more than one substream.

> and then remove this loop in trigger?
> snd_pcm_group_for_each_entry(substream, sub) {
> 			snd_pcm_trigger_done(substream, sub);

Why would you want to remove this loop?

The snd_pcm_group_for_each_entry() iterates over all substreams that are
linked.  The ALSA code that calls the trigger callback has a similar
loop and calls .trigger for any streams for which snd_pcm_trigger_done()
has not yet been called.


HTH
Clemens
