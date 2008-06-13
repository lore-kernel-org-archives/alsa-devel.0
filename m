From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 20:55:01 +0100
Message-ID: <4852D095.1000508@superbug.co.uk>
References: <20080609190225.GA4534@tango.0pointer.de>	<s5h1w333o7r.wl%tiwai@suse.de>	<20080612205225.GB20818@tango.0pointer.de>	<s5hd4mlhlau.wl%tiwai@suse.de>	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>	<s5hr6b1qrri.wl%tiwai@suse.de>	<Pine.LNX.4.61.0806131733180.1798@tm8103-a.perex-int.cz>	<s5hmylpqq9z.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131813150.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id BDF00244EE
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 21:55:03 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0806131813150.1798@tm8103-a.perex-int.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> If we remove period tied I/O operations and 
> assumptions in alsa-lib (thus we will do only byte-stream transfers), then 
> everything will be fine and possible.
>
>   
When will this "byte-stream" architecture be implemented?

James
