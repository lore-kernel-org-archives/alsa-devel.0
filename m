From: mazarick@bellsouth.net
Subject: Any alsa cards with PLD/FPGA? (similar to Gadget Labs)
Date: Wed, 09 Jan 2008 18:40:04 +0000
Message-ID: <010920081840.12262.47851504000BA8C800002FE622218801869B0A02D2089B9A019C04040A0DBF050C079D0E960E03@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmailhost01.isp.att.net (fmailhost01.isp.att.net
	[207.115.11.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5151A24333
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 19:40:07 +0100 (CET)
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

First, I wanted to report that there is good progress being made on developing an alsa linux driver for the Gadget Labs card.   It's not 'done yet' but there is steady progress being made.  As was mentioned earlier, any interested developers, testers, or other parties are welcomed to join in the discussions or coding, however the mailing list will go 'private' in the next week (to eliminate the fear of spam and email address havesting).   The archive is busted right now; not sure if/when it will be fixed.   We're using the mailing list for any interested parties, and are making project members of people who would like to contribute to the effort.

http://sourceforge.net/projects/wavepro-driver/

Since the small team has a variety of experience and familiarity with writing drivers, an experimental 'branch' of the SVN repo has been set up to place reference material (like existing, known good alsa drivers, known good windows code, etc) and eventually, the skeleton of what is to be done next.   The 'good stuff' lives in the trunk and there will be a merge at an appropriate time in the future (when 'soups done').

The heart of the Gadget Labs card is an Altera PLD, and it has a bus interface chip PLX9052 (and some on-board memory, DAC/ADC, etc).   We are planning on putting the alsa code for the Delta 1010 in the branch because it is the most similar from a user perspective.   However, it uses a vlsi ICE chip to do the job, and it doesn't have to have the PLD/FPGA code downloaded each time it is initialized.

If there is a known good driver that can/should have it's code used as a reference, please let us know via this list.  A good technical reference to us would be cards that have to download PLD/FPGA as part of initialization and/or cards that use the PLX9052.    There are a couple of wireless modem cards, etc with linux drivers that fit the description, but it is unknown if there is already an alsa driver for an existing card that would be good reference code.

As you are aware, this effort is not what repos are normally used for, but it was felt that having this would allow people at a variety of different skill levels to quickly pick up on what is trying to be accomplished without having to hunt all over the net, read a bunch of different emails, etc in order to make a contribution.

-Mike Mazarick
