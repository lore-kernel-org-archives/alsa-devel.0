From: Travis Place <wishie@wishie.net>
Subject: EMU10K1 Problem. Im stumped.
Date: Sat, 05 Jul 2008 03:32:30 +1000
Message-ID: <1215192750.9160.6.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-135.dial.usertools.net
	[202.137.100.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D13E24839
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 19:32:03 +0200 (CEST)
Received: from [192.168.0.4] (unknown [192.168.0.200])
	by www.wishie.net (Postfix) with ESMTP id CB7395080
	for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2008 17:54:18 +1000 (EST)
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

Just had a user on #alsa with an EMU10K1 problem.

To summarize, the card shows up in linux (but doesnt work), yet the card
works perfectly in windows. The correct modules are loading, but ALSA
doesnt see the card.

It had the user unload/reload snd-emu10k1 and check dmesg output, and
the relevant result is as follows.

EMU10K1_Audigy: probe of 0000:00:0a.0 failed with error -16

There complete alsa-info.sh output can be found at
http://pastebin.ca/1062377

I have had the user run this both with and without the onboard AC97 card
enabled (just to be sure).

What seems odd to me, is that the card is at 00:0a.0 and the SB Live
revision is showing as (rev 0a). Just doesnt look right to me.. 

The card is an Creative SBLive! 'SB0220'. I have one of these exact
cards here, if its needed for testing, but its never caused me any
issues.

Anyway, any help would be appreciated.

Thanks,
Travis Place (wishie)
