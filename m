From: TJ Olaes <contact@olaes.net>
Subject: Stupid question #1 of many -- unit test harness?
Date: Mon, 15 Apr 2013 00:44:29 +0000 (UTC)
Message-ID: <loom.20130415T023733-422@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC5A265015
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 02:44:42 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1URXXF-00084q-Gj
 for alsa-devel@alsa-project.org; Mon, 15 Apr 2013 02:44:41 +0200
Received: from 108.87.31.237 ([108.87.31.237])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 02:44:41 +0200
Received: from contact by 108.87.31.237 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 02:44:41 +0200
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

Hi.

So, I'm attempting to write the driver for the eClaro card for a couple of 
reasons, one of which is that I currently don't have sound on mine.

So... is there some kind of test harness framework for new drivers?  I have 
no prior idea how to move forward to build this thing, so I'm snooping around 
in the oxygen source files and trying to copy things that look like they make 
sense.  For instance, I noted that there's mention of an "AK4396" related to 
output.  I assume this is some kind of chip, and I saw in the Claro code that 
something called "ak4396_init(...)" is called, so I just copied that line and 
pasted it into the eclaro_init(...) function I'm writing.

I have no idea how I'm going to test this short of just compiling the kernel 
and booting into it.  I feel like that's the brute-force, non-smart way to do 
it, and that you guys who've been doing this for a while might have ideas and 
recommendations on how to better test my code so I'm not rebooting my machine 
each time I change a line and recompile.

I'd appreciate your guidance, community.  Thanks.

-TJ
