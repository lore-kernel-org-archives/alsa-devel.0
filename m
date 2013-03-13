From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Re: [Alsa-user] Master volume control
Date: Wed, 13 Mar 2013 11:39:47 -0700
Message-ID: <99B4285FC8D644619A2FC6F4D0ABBF5C@PAULD>
References: <B3AC1EE66F1142FF99DDC145B8669DDD@PAULD>
 <512F0AF5.3050502@googlemail.com> <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
 <5140B33D.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net
 (elasmtp-galgo.atl.sa.earthlink.net [209.86.89.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 546E3265E27
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 19:40:10 +0100 (CET)
In-Reply-To: <5140B33D.4030406@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Daniel Mack' <zonque@gmail.com>
Cc: 'Alsa-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> From: Daniel Mack [mailto:zonque@gmail.com] 
> 
> So why are you doing this from your sound thread then?

I'm not. I'm doing it from another thread, but somehow it's causing
underruns in my two sound threads (on a dual-core Atom). I'm speculating
that it's hogging one CPU by sitting in the kernel.

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com
