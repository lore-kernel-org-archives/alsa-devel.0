From: Peter Rosin <peda@axentia.se>
Subject: Wrong email in author-tag.
Date: Wed, 16 Mar 2011 12:17:59 +0000
Message-ID: <1A8E9E536193714ABE6BB019B9514BE110D66F@MAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL.axentia.se (axentia.se [87.96.186.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 5506C24343
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 13:18:02 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This is not really important to /me/, on /this/ occation. But I
thought I'd ask anyway as it seems strange that the author tag
ended up wrong. If it is a symptom of more errors, others may
care more. Personally I'm mainly wondering how it could happen, and
would like for it to not happen again (especially if I ever send
more substantial patches).

The commit e2e9566230 ALSA: AT73C213: Rectify misleading comment.
was first sent as a git patch [1] and then again amended with a
pair of other (seemingly) trivial comment fixes [2] (the amended
fixes were not commited for some reason).

Both patches were sent from my axentia account and both carried
signed-off-by tags using the axentia account. Yet the commit is made
naming my lysator account as author (the sign-off is still intact).

The patch that seems to have ended up being commited is [1], and
what I think has happened is that I used the lysator account
in the discussion following the 2nd patch, but I fail to understand
how the sender of that one message (or was it a few?) could "leak"
into the author tag.

I'm assuming it was just a silly mistake, I'm mearly pointing out
the mishap and understand that there is little one can do to fix
this buglet this late.

Cheers,
Peter

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033550.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033645.html
