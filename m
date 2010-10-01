From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how many processed frames? + various thoughts
Date: Fri, 01 Oct 2010 09:03:37 +0200
Message-ID: <4CA587C9.6040506@ladisch.de>
References: <BAY148-w10DFB4C223E0F94E5ABEB58A680@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 20B681039C9
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 09:02:47 +0200 (CEST)
In-Reply-To: <BAY148-w10DFB4C223E0F94E5ABEB58A680@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John John <tobler_one@hotmail.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John John wrote:
> Knowing the sample rate and the processed samples, I'm able to
> calculate the clock (what do you think about this approach?).

The sound card's clock will not be exactly synchronous with the
computer's clock.

> is there a good function into alsa API which returns the number of
> processed frames?

snd_pcm_writei() does return the number of processed frames.

snd_pcm_delay() returns the offset to the position of the sample that is
currently being played.


Regards,
Clemens
