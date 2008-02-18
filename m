From: Travis Place <wishie@wishie.net>
Subject: Problem with DELL XPS M1530
Date: Tue, 19 Feb 2008 02:42:07 +1000
Message-ID: <200802190242.07423.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id D5864244F5
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 17:42:33 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id 464FF58A22
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 17:03:30 +1000 (EST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

Been helping a user on #alsa for a day or two now, with issues regarding 
recording from Mic on his Dell XPS M1530 laptop. He originally had 
alsa-driver 1.0.14, so i had him upgrade to 1.0.16. Now, his Mic works for 
recording, but he has lost playback on one of his HP jacks (the right one), 
and Internal laptop speakers. I had a brief look at the code in 
patch_sigmatel.c, to see what was going on.. But since im no code guru, i 
wasnt much help..

The output of alsa-info.sh is located at http://pastebin.ca/908579

I did notice some comments in the code about correcting HP and Mic jacks for 
certain models (atleast thats what I read it as).

Any ideas would be appreciated.

Travis (wishie).



-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
