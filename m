From: Susan Cragin <susancragin@earthlink.net>
Subject: Re: Should my Creative X-fi card be
	loading	the	snd-hda-intel module
Date: Fri, 26 Jun 2009 07:18:52 -0400 (GMT-04:00)
Message-ID: <31637759.1246015132518.JavaMail.root@elwamui-chisos.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by alsa0.perex.cz (Postfix) with ESMTP id B90132483A
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 13:18:53 +0200 (CEST)
Received: from [209.86.224.31] (helo=elwamui-chisos.atl.sa.earthlink.net)
	by elasmtp-scoter.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1MK9SG-0004ku-Gf
	for alsa-devel@alsa-project.org; Fri, 26 Jun 2009 07:18:52 -0400
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

>> Shouldn't it be loading snd-hda-codec-ca0110 instead?
>
>snd-hda-codec-ca0110 is a slave module loaded by snd-hda-intel.
>
>Takashi

The problem is, my Creative X-fi isn't being recognized any more, even though the modules are there and have been loaded. 

My onboard card is an hda-intel. And my utilities and programs don't find the Creative card. They only find the onboard card. 

I have added asoundconf to my alsa-utils, and asoundconf list shows only:
Intel
system (my usb card) 

winecfg shows the same. 

My goal is to get the card running again under wine.

Susan
