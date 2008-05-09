From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] emux midi synthesizer doesn't
 honor	SOFT_PEDAL-release event
Date: Fri, 09 May 2008 09:33:56 +0200
Message-ID: <4823FE64.3050603@ladisch.de>
References: <1210280016-14742-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2A21924386
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 09:34:02 +0200 (CEST)
In-Reply-To: <1210280016-14742-1-git-send-email-max@stro.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: maximilian attems <max@stro.at>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, uwe_debbug@arcor.de
List-Id: alsa-devel@alsa-project.org

maximilian attems wrote:
> The attached patch fixes this problem by analysing the value (0 or 127)
> of the midi control event and resetting the effect register in case of a
> release event.
> ...
> +		if (chan->control[type])

Boolean MIDI controls should interpret 0..63 as false and 64..127 as
true, i.e.:

+		if (chan->control[type] >= 64)


Regards,
Clemens
