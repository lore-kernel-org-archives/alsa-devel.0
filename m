From: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: [PATCH] Sample generation on big endian platforms
	was broken.
Date: Fri, 03 Jul 2009 16:51:35 +0200
Message-ID: <1246632695.7922.34.camel@localhost.localdomain>
References: <1246630771.7922.25.camel@localhost.localdomain>
	<s5hab3lj0fb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 84D6F248E4
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 16:51:47 +0200 (CEST)
In-Reply-To: <s5hab3lj0fb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-07-03 at 16:39 +0200, Takashi Iwai wrote:
> At Fri, 03 Jul 2009 16:19:31 +0200,
> Kenneth Johansson wrote:
> > 
> > Has not worked since commit 3d1fa924906996463ac33cba5b5143f762d913cf
> > 
> > Signed-off-by: Kenneth Johansson <kenneth@southpole.se>
> 
> Hrm, sorry, but your version is also broken as doing type-punning.
> The code has to be rewritten completely...
> 
> 
> Takashi

hmm I think you have to explain this. now it works on both little/big
endian without any explicit byte moves.

It did not understand what problem you see.
