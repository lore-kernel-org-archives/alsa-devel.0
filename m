From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 2/3] ALSA: aoa: Fix of-node refcount
	unbalance
Date: Tue, 19 Feb 2019 16:50:00 +0100
Message-ID: <745519866a406b0ee1df34f03fc29e892f0fca0f.camel@sipsolutions.net>
References: <20190219153124.12595-1-tiwai@suse.de>
 <20190219153124.12595-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (s3.sipsolutions.net [144.76.43.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 82DBB265535
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:50:02 +0100 (CET)
In-Reply-To: <20190219153124.12595-3-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-02-19 at 16:31 +0100, Takashi Iwai wrote:
> We forgot to unreference a node obtained via of_find_node_by_name()
> after its usage.

How did you find this now?! Though I guess something like smatch could
find it, or even coccinelle?

> Only compile-tested.  Please review carefully.  Thanks!

Yes, looks right

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

I still have, but no longer run, the machine that uses this driver ...
anyone need a Powermac G5 quad? ;-)

johannes
