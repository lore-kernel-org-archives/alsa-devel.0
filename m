From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: snd_pcm_avail_delay() returned strange values:
 delay 0 is less than avail 4.
Date: Sat, 27 Jun 2015 19:04:51 +1000
Message-ID: <20150627190451.07e6bad8@korath.teln.shikadi.net>
References: <20150627173617.1ade4161@korath.teln.shikadi.net>
 <s5htwtto93t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C95261629
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 11:04:58 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Z8m2i-0006en-UA
 for alsa-devel@alsa-project.org; Sat, 27 Jun 2015 11:04:57 +0200
Received: from 58.7.45.51 ([58.7.45.51])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 11:04:56 +0200
Received: from a.nielsen by 58.7.45.51 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 11:04:56 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > E: [alsa-source-ALC892 Analog] alsa-util.c: snd_pcm_avail_delay()
> > returned strange values: delay 0 is less than avail 4.  
> 
> Try the latest alsa-lib git.  This should have been already fixed.  

Oh right!  Indeed it has.  My apologies, I should have tried this
first.  Many thanks for the quick response.

Cheers,
Adam.
