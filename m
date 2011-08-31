From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa timing question
Date: Wed, 31 Aug 2011 22:07:25 +0200
Message-ID: <4E5E947D.3020300@ladisch.de>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>	<4E55F6A2.3040307@ladisch.de>	<CAE3TgXHTshARnB8oYssGnU4gD1K1jCa2J-VX0OGhuqZ375RQAQ@mail.gmail.com>	<4E5C9624.6040405@ladisch.de>
	<CAE3TgXE9tQPFZi5bUYkpkTQ4PC1Fh2FmHngrxLg+jWJ3a3_8WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5022A244A2
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 22:07:48 +0200 (CEST)
In-Reply-To: <CAE3TgXE9tQPFZi5bUYkpkTQ4PC1Fh2FmHngrxLg+jWJ3a3_8WA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Toy wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
>     The defaults for dmix's period_size, period_time, and periods are 1024,
>     -1, and 16.  They can be overridden by setting the configuration values
>     defaults.dmix.DRIVER.period_size/period_time/periods, where DRIVER is
>     the internal driver name (the name between the colon and the hyphen in
>     /proc/asound/cards, or the file name in /usr/share/alsa/cards/).
>
> Thanks for the info.  Can this be done programmatically?

Not really.  You could define your own device, but it wouldn't work together
with any open default dmix device.

> However for the application, I don't want to have to tell the user to set
> up dmix.

If you know that you're using dmix, and which hardware device is actually
used, you could use a PCM slave timer to get notifications of period
interrupts.  (The dmix plugin also uses this mechanism, but then rounds
the events to the application's period size.)

For PulseAudio, there seems to be no choice but to use a period size that
is somehow aligned to PA's internal timer granularity.


Regards,
Clemens
