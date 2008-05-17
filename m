From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] snd-pcsp: depend on CONFIG_EXPERIMENTAL
Date: Sat, 17 May 2008 14:45:27 +0400
Message-ID: <482EB747.6040103@aknet.ru>
References: <482E0734.7080003@aknet.ru>
	<20080517090517.GB3284@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id EF86524AC7
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 12:45:42 +0200 (CEST)
In-Reply-To: <20080517090517.GB3284@cs181133002.pp.htv.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

Adrian Bunk wrote:
> No objections against your patch, but considering that virtually 
> everyone has EXPERIMENTAL enabled in his kernel it won't bring
> you out of any troubles...
So do you think it should depend
on CONFIG_BROKEN?
The other possibilities, like hardcoding
the index value as Andreas Mohr suggested,
are also interesting. Can someone please
comment if this is acceptable?
