From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/3] ALSA: ac97: Fix of-node refcount
	unbalance
Date: Tue, 19 Feb 2019 22:08:10 +0100
Message-ID: <87zhqrsczp.fsf@belgarion.home>
References: <20190219153124.12595-1-tiwai@suse.de>
 <20190219153124.12595-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by alsa1.perex.cz (Postfix) with ESMTP id AC9D2F80758
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 11:08:12 +0100 (CET)
In-Reply-To: <20190219153124.12595-2-tiwai@suse.de> (Takashi Iwai's message of
 "Tue, 19 Feb 2019 16:31:22 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> ac97_of_get_child_device() take the refcount of the node explicitly
> via of_node_get(), but this leads to an unbalance.  The
> for_each_child_of_node() loop itself takes the refcount for each
> iteration node, hence you don't need to take the extra refcount
> again.
>
> Fixes: 2225a3e6af78 ("ALSA: ac97: add codecs devicetree binding")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>
> Only compile-tested.  Please review carefully.  Thanks!
Hi Takashi,

Reviewed-by: Robert <robert.jarzmik@free.fr>

Cheers.

--
Robert
