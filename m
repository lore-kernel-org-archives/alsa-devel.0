From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with setting period time and buffer time.
Date: Tue, 19 Feb 2008 09:17:15 +0100
Message-ID: <47BA908B.7040700@ladisch.de>
References: <9673d3ac0802181557m6bd35f28w7680c9a9a979ab67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B54FA245B6
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 09:15:27 +0100 (CET)
In-Reply-To: <9673d3ac0802181557m6bd35f28w7680c9a9a979ab67@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ignacy Kasperowicz <fikufik@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ignacy Kasperowicz wrote:
> I need to set proper period time for my application. What I need my
> code to do is to play sine wave with set frequency and for exact time
> of 1/1200 s (something about 834 us).

The period time specifies after which interval the sound hardware issues
an interrupt, i.e., after which time your application gets waken up when
it is waiting for the sound buffer to become non-empty.  This has
nothing to do with the actual sounds that are being played.

You are not required to write data in period-sized chunks, so you don't
actually need to care about the period time.

> When I try to set period time for 834 us I've got this error:
> Unable to set period time 834 for playback: Invalid argument .
> Honestly speaking  I've got this error message no matter what value I
> try to set).

Period (and buffer) times are hardware dependent; you cannot be sure
that any specific value is supported by the sound card.

(And you're calling snd_pcm_hw_params_set_period_time_max() which would
allow the driver to choose any lower value.)


HTH
Clemens
