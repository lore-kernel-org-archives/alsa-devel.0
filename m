From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Standard mixer control names
Date: Tue, 24 Feb 2009 13:05:28 +0100
Message-ID: <49A3E288.8040007@insite.cz>
References: <20090221233629.GA3748@tango.0pointer.de>	<s5hzlgd34c3.wl%tiwai@suse.de>	<20090223164700.GD22083@tango.0pointer.de>
	<s5hiqn084kh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C5DBA103803
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 13:05:29 +0100 (CET)
In-Reply-To: <s5hiqn084kh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> I feel we need another meta data to manage / group the mixer elements.
> It'll be likely based on the per-driver database, or implemented as a
> module.  We have already a framework for mixer module, so it's
> feasible.  Where it's the best choice is another question, though.
> 
> But, as now, it's still a vaporware.  So, let's assume to solve in
> PA.

Great to hear about the planned progress in this area. Many cards define 
rather unintuitive but important mixer controls. Perhaps somehow we 
could provide control elements with optional textual descriptions. If it 
  was somewhere in alsa-lib configs, it would even allow for translation 
via locales. GUI mixers could display the (localized) descriptions in 
many creative ways.

Pavel.
