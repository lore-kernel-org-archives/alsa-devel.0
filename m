From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 09:40:58 +0200
Message-ID: <4A7FCF0A.1000806@ladisch.de>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6513210383B
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 09:40:49 +0200 (CEST)
In-Reply-To: <9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> Here's how I implemented sync start/stop.......

Have a look at oxygen_trigger() in sound/pci/oxygen/oxygen_pcm.c for a
working sync start/stop implementation.

> 	snd_pcm_group_for_each_entry(substream, sub) {
> 
> 		rtd = substream->private_data;

There is no guarantee the all linked substreams belong to the same card
or the same driver; you have to check that first and ignore streams you
don't know about.

> 		if (sub != substream)
> 			snd_pcm_trigger_done(substream, sub);

You can just call snd_pcm_trigger_done() for every substream you handle.

> 		...
> 	}
> 	return 0;

There is no common code for the two substreams.
Is your hardware actually capable of starting them at exactly the same
time?


Best regards,
Clemens
