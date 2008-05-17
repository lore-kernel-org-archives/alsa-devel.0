From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch] snd-pcsp: depend on CONFIG_EXPERIMENTAL
Date: Sat, 17 May 2008 18:01:33 +0200
Message-ID: <482F015D.8030504@keyaccess.nl>
References: <482E0734.7080003@aknet.ru>	<20080517090517.GB3284@cs181133002.pp.htv.fi>
	<482EB747.6040103@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B9E61037EF
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 18:00:21 +0200 (CEST)
In-Reply-To: <482EB747.6040103@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17-05-08 12:45, Stas Sergeev wrote:

>> No objections against your patch, but considering that virtually 
>> everyone has EXPERIMENTAL enabled in his kernel it won't bring
>> you out of any troubles...

> So do you think it should depend
> on CONFIG_BROKEN?

No, I wouldn't do that. It isn't all that broken it would seem (assuming 
  it will work for me after applying the patch you posted that should 
make it work with older alsa-lib; haven't checked yet).

> The other possibilities, like hardcoding
> the index value as Andreas Mohr suggested,
> are also interesting. Can someone please
> comment if this is acceptable?

Generally I'd say totally unacceptable but this might in fact be a 
special case due to it being generic PC hardware and expected to be 
present therefore -- it might actually make some sense to reserve a
#define SND_INDEX_PCSP MAXINT or some such so that this thing gets a 
stable index (and make sure people know to select it through its name 
like in "default:pcsp" and the like). I'd ask Takashi for comment on that...

Rene.
