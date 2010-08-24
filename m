From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 24 Aug 2010 10:09:48 +0100
Message-ID: <1282640988.3053.43.camel@odin>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 647E824663
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 11:09:52 +0200 (CEST)
Received: by wwb17 with SMTP id 17so1384968wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 02:09:52 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-23 at 19:47 +0200, Jaroslav Kysela wrote:
> On Mon, 23 Aug 2010, Liam Girdwood wrote:
> 
> > This patch series follows on from the RFC and adds sound card hardware Use Case
> > Management support to alsa-lib.
> 
> Liam, can you give a URL for anonymous GIT repository with these patches?
> 

There is also a testing tool called alsaucm in the ucm-upstream branch
of the alsa-utils git repo here :-

git://git.slimlogic.co.uk/alsa-utils.git

This will probably be useful if you are testing your ideas.

There are also some initial configuration files here :-

git://git.slimlogic.co.uk/alsa-ucm-conf.git

> Unfortunately, I have many ideas to improve the API before I can approve 
> or recommend the inclusion to the alsa-lib's tree.
> 

I wish you had shared your API ideas with us at the time of the RFC. A
lot of time and effort has since went into UCM development :-/

Can you share your ideas atm, or do you have some patches planned ?

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
