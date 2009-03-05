From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 0/9] S3C24XX/S3C64XX updates
Date: Thu, 5 Mar 2009 10:31:12 +0000
Message-ID: <20090305103111.GA2416@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304202952.GA10731@sirena.org.uk>
	<s5hvdqofn6a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 58AFA103852
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 11:31:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvdqofn6a.wl%tiwai@suse.de>
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
Cc: Ben Dooks <ben-alsa@fluff.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 08:23:25AM +0100, Takashi Iwai wrote:

> Me too :)  I wouldn't take this for 2.6.29 as long as it builds now,
> but this particular change should go through ARM tree, so it's rather
> Russell's call.  Could you forward this one?

> The others are applied fine to sound tree as 2.6.30 changes.

Ordinarily it should go through the ARM tree but due to the addition of
the S3C64xx support it would create merge issues to separate it out -
most of the other patches in the series depend on this in one way or
another.  Ben is the maintainer for the general Samsung processor
support and this header move is part of a general reorgansation of ARM
headers from include/asm-arm into arch/arm so it was expected and should
be entirely uncontrovesial.

I could separate it out and push a separate branch via Russell as well
but that'd make more work for him and he's been having some very bad
network problems in addition to all the stuff he normally has to do so
I'm not sure he'd welcome more work right now.
