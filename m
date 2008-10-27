From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Only one element for multichannel mixer controls
 please!
Date: Mon, 27 Oct 2008 10:20:48 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810271017350.12044@tm8103.perex-int.cz>
References: <20081024234932.GA17812@tango.0pointer.de>
	<s5hiqrezbyr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0810270923280.12044@tm8103.perex-int.cz>
	<s5hr662qu9n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E9C02246AF
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:20:48 +0100 (CET)
In-Reply-To: <s5hr662qu9n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Oct 2008, Takashi Iwai wrote:

> IMHO, a big part of the problem is its overly complex layers and

I agree. Some layers should be merged and simplified.

> old-style mixer API (in addition to complete lack of documentation).

I don't understand what you mean old-style API. API inside alsa-lib or 
smixer API for applications? If it's the second case, what you imagine as 
right mixer API for apps?

> The plugin solution doesn't work well because you are tring to graft
> orange and apple.

Please, explain.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
