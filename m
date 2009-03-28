From: Susan Cragin <susancragin@earthlink.net>
Subject: Regression? Default card no longer shows up
Date: Sat, 28 Mar 2009 10:04:38 -0400 (GMT-04:00)
Message-ID: <26844765.1238249078383.JavaMail.root@elwamui-royal.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net
	(elasmtp-kukur.atl.sa.earthlink.net [209.86.89.65])
	by alsa0.perex.cz (Postfix) with ESMTP id A77F51037E3
	for <alsa-devel@alsa-project.org>; Sat, 28 Mar 2009 15:04:39 +0100 (CET)
Received: from [209.86.224.46] (helo=elwamui-royal.atl.sa.earthlink.net)
	by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1LnZ9K-0000Rk-Bj
	for alsa-devel@alsa-project.org; Sat, 28 Mar 2009 10:04:38 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have been compiling the development alsa-drivers because I use an X-fi card. They have worked great up until today. 
I use Ubuntu Studio. I installed it clean this morning, with default options. 
Then I purged pulseaudio (because pulseaudio does not work with wine) 
re-booted. 
compiled and installed alsa-driver
re-booted
set-default-card to Generic

asoundconf list shows the following
Names of available sound cards:
Intel
Generic (this of course is my X-fi card)

tried to run Audacity. 
Audacity only recognizes the Intel card. 

Installed wine. 
Wine shows the following:

alsa-driver
MIDI Out Devices: Midi Through Port-0
MIDI In Devices: Midi Through Port-0
Mixer Devices: 
     HDA Intel
     HDA-Audio Generic

This may be a Ubuntu bug, but I wanted to run it by you first. 

Susan Cragin
