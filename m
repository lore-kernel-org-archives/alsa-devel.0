From: Joshua Schmidlkofer <kernel@pacrimopen.com>
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
Date: Sat, 27 Dec 2003 21:06:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1072587986.32719.10.camel@menion.home>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>
	 <2060000.107248  <8240000.1072511437@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <8240000.1072511437@[10.10.2.4]>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net, azarah@nosferatu.za.org, Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>, Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>, Stan Bubrouski <stan@ccs.neu.edu>, swidmer@caowash.org
List-Id: alsa-devel@alsa-project.org

> If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
> I'll get some wierd effect for a few seconds, either static, or the track
> will mysteriously speed up or slow down. Then all is back to normal for
> another couple of minutes.

We had this problem with an Intel 8x0 sound chipset, turned out to be
that the chipset requires a fixed bit rate.  I can't remember what we
did to fix it, but I will ask my friend who has the system.


js


-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.
