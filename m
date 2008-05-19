From: Travis Place <wishie@wishie.net>
Subject: Re: Incorrect model selection for HDA Intel based card.
Date: Tue, 20 May 2008 01:12:37 +1000
Message-ID: <200805200112.37719.wishie@wishie.net>
References: <200805190419.14316.wishie@wishie.net>
	<s5h8wy6cx7n.wl%tiwai@suse.de>
	<200805200058.47467.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-101.dial.usertools.net
	[202.137.100.101])
	by alsa0.perex.cz (Postfix) with ESMTP id CE3AA2463F
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 17:13:12 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id E1D2F31C54
	for <alsa-devel@alsa-project.org>; Mon, 19 May 2008 15:34:08 +1000 (EST)
In-Reply-To: <200805200058.47467.wishie@wishie.net>
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

Just noticed something very interesting in HG checkout..


SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST)

yet, the user states he has a P5GD1 but had the IDs 0x1043, 0x814e

in any event, it seems that 0x1043, 0x814e required ALC880_6ST_DIG

not sure what is going on here.

Travis Place.

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
