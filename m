From: randall <rlrathbun@roadrunner.com>
Subject: Nvida HDA MCP61 - Realtek ALC622 question
Date: Mon, 16 Jun 2008 09:23:40 -0700
Message-ID: <200806160923.40663.rlrathbun@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta9.adelphia.net (mta9.adelphia.net [68.168.78.199])
	by alsa0.perex.cz (Postfix) with ESMTP id E0507243B3
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 18:23:45 +0200 (CEST)
Received: from [192.168.1.100] (really [76.176.117.148]) by mta9.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
	id <20080616162754.MSAX4520.mta9.adelphia.net@[192.168.1.100]>
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 12:27:54 -0400
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

Andy:

Who works on the snd-hda-intel sound module?  I have been unable to get the 
codec working on my Athlon 64 3200+ processor (64 bit libs) despite gradually 
working my way up from Alsa 1.0.14 to 1.0.17.git and fighting YaST2 issues 
with Suse 10.3

Since I do software development, I'd like to add my $0.02 worth of coding to 
get the Alsa code working for my ECS EliteGroup motherboard as I have seen 
others posting to the web frustrated by the same problem (indeed openSuse has 
a web site devoted to soundcard issues, but no one has yet fixed this 
problem)

I did a dump using the alsa-info.sh to pastebin, but probably have to run that 
again.  http://pastebin.ca/1048637 is the latest dump of my board.

Randall
