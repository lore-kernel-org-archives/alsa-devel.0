From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 14:21:51 +0100
Message-ID: <49007A6F.8080305@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>
	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<5501535d0810230607p1a255f93ye15700d96bee7618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217]) by alsa0.perex.cz (Postfix) with ESMTP id A288524508
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 15:22:00 +0200 (CEST)
Received: from quad.jasonline.co.uk (quad.jasonline.co.uk [192.168.0.13])
	by homer.jasonline.co.uk (Postfix) with ESMTP id CF3ADB682A7
	for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2008 14:21:49 +0100 (BST)
In-Reply-To: <5501535d0810230607p1a255f93ye15700d96bee7618@mail.gmail.com>
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

Bjoern Olausson wrote:
> Did you capture the Oops via a serial cabel?
> I had one attached too, but I never could capture an output... either
> the system rebooted or died without a message on the serial console...
>
> Anything special you did to capture the oops?
>   
Yes, just a simple serial cable, no handshaking lines.
Just added "console=ttyS0,57600n8 3" to the command line to stop enable 
the console and stop X
I set the bitrate to 57600 to make things a bit faster.
Using CuteCom to capture the output.
Not had any instant reboots yet on the Intel based machine I am now 
using to test.
On my dual Opteron machine it does reboot, I doubt there is enough time 
to squirt out an oops.

Regards, Jason
