From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [PATCH] alsa-utils 1.0.27.1 still ships
 90-alsa-restore.rules
Date: Thu, 30 May 2013 17:06:31 +0200
Message-ID: <20130530150631.GA20416@galadriel.home.lxtec.de>
References: <20130530130813.GA25784@galadriel.home.lxtec.de>
 <51A75A5B.8090000@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D5E2610AE
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 17:06:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51A75A5B.8090000@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, pkg-alsa-devel@lists.alioth.debian.org
List-Id: alsa-devel@alsa-project.org

* Jaroslav Kysela <perex@perex.cz> [2013-05-30 15:55 +0200]:

> Date 30.5.2013 15:08, Elimar Riesebieter wrote:
> > 
> > Hi all,
> > 
> > [0] tells:
> > alsactl: remove 90-alsa-restore.rules from the tar ball
> > 
> > but it still ships 90-alsa-restore.rules.in and installs the file as
> > 90-alsa-restore.rules
> 
> It's correct. The rules file should be generated after configure/make
> with correct paths.
> 
> It's not a complete removal of this feature. You probably miss this fix:
> 
> http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=c0f70a0b8e340d6ee903ff226886bb6f969d46a1

Well, it is useless when EPREFIX (i.e /usr) isn't mounted while udev runs?
It should be better to restore mixer settings by an initscript.

Elimar
-- 
  On the keyboard of life you have always
  to keep a finger at the escape key;-)
