From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Fri, 30 Nov 2007 18:19:26 +0100
Message-ID: <4750461E.2040104@keyaccess.nl>
References: <474E1189.9030701@keyaccess.nl> <s5hsl2pf8lf.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0711301050540.10769@tm8103.perex-int.cz>
	<s5hy7cgdmcx.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0711301317240.10769@tm8103.perex-int.cz>
	<s5htzn3ewmx.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0711301428241.10769@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 12A902448E
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 18:20:16 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0711301428241.10769@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "yakui.zhao" <yakui.zhao@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On 30-11-07 14:32, Jaroslav Kysela wrote:

> Anyway, it's true that ISA PnP stuff is quite obsolete current days. If
> manual settings is supported and described, I've no objections to reduce
> code, too.

Okay. I've just submitted a further upadet to ALSA-Configuration.txt and 
I'll look into being a bit more verbose about how to set resources in 
Documentation/pnp.txt and possibly defer users from ALSA-Configuration.txt 
there.

Thomas Renninger is making some haste with the deprecation of the removed 
functions by the way -- I just saw a patch of his entering my mailbox where 
he says he'd in fact like them deprecated in 2.6.24 already. The ALSA 
removal would not seem likely to be scheduled to go to 2.6.24 yet, so I 
guess that won't do?

I have no opinion on the schedule -- but Thomas, if you do, I guess you'd 
need to convince Jaroslav to withstand The Wrath Of Linus and ask him to 
push it. We can't have it deprecated (on the "spew warnings" level) with 
ALSA still using them in 2.6.24.

Rene.
