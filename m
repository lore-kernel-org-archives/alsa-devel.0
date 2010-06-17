From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/5] ALSA: usb-audio: unify UAC macros and
	struct names
Date: Thu, 17 Jun 2010 17:26:26 +0200
Message-ID: <20100617152626.GL17833@buzzloop.caiaq.de>
References: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
	<1276703851-22199-3-git-send-email-daniel@caiaq.de>
	<s5hr5k6nao6.wl%tiwai@suse.de>
	<20100616174044.GA17833@buzzloop.caiaq.de>
	<s5hljaen2yq.wl%tiwai@suse.de>
	<6E4AF70D-1E90-48FF-9EBB-0882C6ABAF34@gmail.com>
	<20100617120752.GH17833@buzzloop.caiaq.de>
	<AANLkTimtpdMFSDTEiDNLI0HzMPdRwJmsvyG0AuWGKv1r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2432B24494
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 17:26:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimtpdMFSDTEiDNLI0HzMPdRwJmsvyG0AuWGKv1r@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Lee <alexlee188@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "clemens@ladisch.de" <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

(hint, hint: don't top-post :))

On Thu, Jun 17, 2010 at 08:21:22AM -0700, Alex Lee wrote:
> It will not help existing codes, I agree.  But it may make writing new UAC2
> specific code easier?

Not as long as most of the code stays hybrid for both versions. If there
were versions of these enum values for both UAC1 and UAC2, you would
need to choose one of them in the parser codes. Which one you go for
doesn't actually make any difference as they're both the same, but the
code would read as if it was specific to any version.

I'd say this would add more to the confusion, and not ease any.


Daniel
