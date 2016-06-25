From: Bob Copeland <me@bobcopeland.com>
Subject: Re: UBSAN bug in hda_generic.c
Date: Sat, 25 Jun 2016 07:52:40 -0400
Message-ID: <20160625115240.GA15917@localhost>
References: <20160625110802.GA14579@localhost> <s5hh9chse2n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id EA41E2650FA
 for <alsa-devel@alsa-project.org>; Sat, 25 Jun 2016 13:52:47 +0200 (CEST)
Received: by mail-it0-f53.google.com with SMTP id a5so34293571ita.1
 for <alsa-devel@alsa-project.org>; Sat, 25 Jun 2016 04:52:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hh9chse2n.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 25, 2016 at 01:28:00PM +0200, Takashi Iwai wrote:
> On Sat, 25 Jun 2016 13:08:02 +0200,
> Bob Copeland wrote:
> > 
> > Hi,
> > 
> > I have UBSAN reporting an out-of-bounds array access (see below) on my
> > machine.  The following patch fixes the warning for me, but not sure if
> > that is just papering over some other bug.  Thanks in advance for looking!
> 
> A better check would be to put
> 	if (!path->depth)
> 		continue;
> before both path->path[0] and path->path[path->depth - 1]
> evaluations.  path->depth=1 cannot exist, but path->depth=0 might be.
> 
> Could you resubmit with that fix?

Sure, patch to follow in a separate mail so that patchwork can pick it up.

-- 
Bob Copeland %% http://bobcopeland.com/
