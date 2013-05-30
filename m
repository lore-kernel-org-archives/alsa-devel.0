From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-utils 1.0.27.1 still ships
	90-alsa-restore.rules
Date: Thu, 30 May 2013 15:55:39 +0200
Message-ID: <51A75A5B.8090000@perex.cz>
References: <20130530130813.GA25784@galadriel.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id CA65A2651C5
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 15:55:39 +0200 (CEST)
In-Reply-To: <20130530130813.GA25784@galadriel.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, pkg-alsa-devel@lists.alioth.debian.org
List-Id: alsa-devel@alsa-project.org

Date 30.5.2013 15:08, Elimar Riesebieter wrote:
> 
> Hi all,
> 
> [0] tells:
> alsactl: remove 90-alsa-restore.rules from the tar ball
> 
> but it still ships 90-alsa-restore.rules.in and installs the file as
> 90-alsa-restore.rules

It's correct. The rules file should be generated after configure/make
with correct paths.

It's not a complete removal of this feature. You probably miss this fix:

http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=c0f70a0b8e340d6ee903ff226886bb6f969d46a1

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
