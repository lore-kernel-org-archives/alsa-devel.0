From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to
 new-style i2c drivers (v3)
Date: Wed, 15 Apr 2009 15:53:12 +0200
Message-ID: <20090415155312.7ea73a6a@hyperion.delvare>
References: <20090415142225.2bfd37f6@hyperion.delvare>
	<1239800444.9071.5.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E6EFF1038E9
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 15:53:22 +0200 (CEST)
In-Reply-To: <1239800444.9071.5.camel@johannes.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin@alsa-project.org, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Herrenschmidt <benh@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Apr 2009 15:00:44 +0200, Johannes Berg wrote:
> On Wed, 2009-04-15 at 14:22 +0200, Jean Delvare wrote:
> > The legacy i2c binding model is going away soon, so convert the AOA
> > codec drivers to the new model or they'll break.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Tested-by: Andreas Schwab <schwab@linux-m68k.org>
> > ---
> > Johannes, this is a reworked patch which assumes that the onyx codec
> > probing can fail. It's not exactly clean but that's the easiest
> > approach for now. Can you please give it a try? Thanks.
> 
> This works.
> Tested-by: Johannes Berg <johannes@sipsolutions.net> [quad G5]

Excellent, thanks for the testing!

-- 
Jean Delvare
