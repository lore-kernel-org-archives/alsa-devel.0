From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [patch] oxygen: clean up. make precedence explicit
Date: Fri, 19 Feb 2010 09:29:05 +0100
Message-ID: <4B7E4BD1.3040106@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 1D1EF10391D
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 09:29:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> This doesn't change anything, but I think it makes the code clearer.
> It silences a smatch warning:
> sound/pci/oxygen/oxygen_mixer.c +91 dac_mute_put(7) warn: add some parenthesis here?

That message doesn't say why some parentheses should be added.
And it's a question; how do I give it the answer "no"?  :-)

> -	changed = !value->value.integer.value[0] != chip->dac_mute;
> +	changed = (!value->value.integer.value[0]) != chip->dac_mute;

This doesn't look any clearer to me; I don't think that the unary
negation operator could be thought to have lower precedence than "!=".

Why does smatch warn about this combination?  Do such errors actually
happen?


Regards,
Clemens
