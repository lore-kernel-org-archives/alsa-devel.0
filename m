From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Fri, 04 May 2012 18:42:49 -0400
Message-ID: <4FA45B69.5010608@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
	<4F9CB0D7.5060401@rauros.net>
	<CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
	<4F9D4291.6060803@rauros.net>
	<CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
	<4FA19CAC.7070704@rauros.net>
	<CAFz=ag624FsOhyRSKY=cO5+fZtLhCKMsox4_HhFooor_B5OQ8g@mail.gmail.com>
	<4FA36114.2030305@rauros.net>
	<CAFz=ag5iwFf7DtfE8sucZWSNq14DZM7enwER5m_M=9=9Do9J7w@mail.gmail.com>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173017pub.verizon.net (vms173017pub.verizon.net
	[206.46.173.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F88F103F3B
	for <alsa-devel@alsa-project.org>;
	Sat,  5 May 2012 00:43:33 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173017.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M3I005F5SFEAIC1@vms173017.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Fri, 04 May 2012 17:42:51 -0500 (CDT)
In-reply-to: <CAFz=ag5iwFf7DtfE8sucZWSNq14DZM7enwER5m_M=9=9Do9J7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

No change. According to usbmon looks like no matter what channel I 
adjust, the clock ctl is always being adjusted as if the wrong wIndex 
gets selected. The clock wIndex is 0x8001 but the mixer volume is 
0x4001. The wValue looks correct (first mixer, according to my docs, 
should be 0x0100). I'm going to trace down the rabbit hole to learn how 
wValue/wIndex is derived from the mixer controls.

I'll keep tinkering. At some point I should probably just buy you a 
C400, probably easier.
