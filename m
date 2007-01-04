From: Paul Abrahams <abrahams@acm.org>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Thu, 4 Jan 2007 14:21:34 -0500
Message-ID: <200701041421.35153.abrahams@acm.org>
References: <200701041332.46215.abrahams@acm.org>
	<1167936731.4321.2.camel@localhost.localdomain>
Reply-To: abrahams@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from alnrmhc14.comcast.net (alnrmhc14.comcast.net [206.18.177.54])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 78A09234
	for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2007 20:21:59 +0100 (MET)
In-Reply-To: <1167936731.4321.2.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Peter Zubaj <pzubaj@gaya.sk>
Cc: alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thursday 04 January 2007 1:52 pm, Peter Zubaj wrote:

> Try to modprobe driver manually and then use dmesg - it will tell you
> what is wrong.

modprobe snd_via82xx produces no output

lsmod produces output containing the line

  snd_via82xx            32920  0

dmesg contains the lines

PCI quirk: region 4000-407f claimed by vt8235 PM
PCI quirk: region 5000-500f claimed by vt8235 SMB

and also the lines

pnp: 00:02: ioport range 0x4000-0x407f could not be reserved
pnp: 00:02: ioport range 0x5000-0x500f has been reserved

> Also check /proc/asound/cards file if there is listed your card -
> sometimes is modem first card.

the output is

0 [V8235          ]: VIA8233 - VIA 8235
                      VIA 8235 with VIA1612A at 0xdc00, irq 217

Paul

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
