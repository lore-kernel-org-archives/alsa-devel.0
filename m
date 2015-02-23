From: Dang Sananikone <dang.sananikone@gmail.com>
Subject: No sound and systemd journal filling when inserting
	headphones when power-saving is enabled
Date: Mon, 23 Feb 2015 20:00:35 +0000 (UTC)
Message-ID: <loom.20150223T205312-191@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D0752260687
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 21:05:07 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1YPzFY-0006SZ-6k
 for alsa-devel@alsa-project.org; Mon, 23 Feb 2015 21:05:04 +0100
Received: from bcdc3846.skybroadband.com ([188.220.56.70])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 21:05:04 +0100
Received: from dang.sananikone by bcdc3846.skybroadband.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 21:05:04 +0100
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

Hi,

I previously posted in alsa user mailing list about a problem I was facing 
with having no sound and the systemd journal filling when using headphones:

    http://article.gmane.org/gmane.linux.alsa.user/38948

I subsequently realised that I had enabled power-saving a few weeks ago and 
it was this power-saving that was causing the problem. My response to myself 
is here:

    http://article.gmane.org/gmane.linux.alsa.user/38953

I am now satisfied that disabling power-saving has resolved my issue, but 
there has been a suggestion that I report this issue, so here it is. 
Apologies if this is the wrong place (this is my first time on the alsa 
mailing list).

Let me know if you want me to create a bug ticket and where it 
should be created (the bug tracker URL link in the alsa project page is not 
working).
