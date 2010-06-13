From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Timing Info
Date: Sun, 13 Jun 2010 16:10:19 +0200
Message-ID: <4C14E6CB.2030909@ladisch.de>
References: <AANLkTil1tGrkCdRt1s9AZ8eWYG55hYrPOCq6TRaEhpRK@mail.gmail.com>
	<AANLkTik3ycq3POxHRG_bc0jO-KByZVvirVJ-X9-bySY_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A520E244C7
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Jun 2010 16:10:23 +0200 (CEST)
In-Reply-To: <AANLkTik3ycq3POxHRG_bc0jO-KByZVvirVJ-X9-bySY_@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Dugas <paul@dugasenterprises.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Dugas wrote:
> Looks like some processing of the trigger timestamp is what I need

Trigger events are starting or stopping of a stream.

> What's the "timestamp mode".  Does it generate a timestamp each
> period?  How would I access that timestamp?

Set SND_PCM_TSTAMP_ENABLE to generate a timestamp whenever the hardware
position is updated.  Call snd_pcm_status to read the position and the
corresponding timestamp.


HTH
Clemens
