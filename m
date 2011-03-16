From: errordeveloper@gmail.com
Subject: aseqnet ipv6 and embedded clients
Date: Wed, 16 Mar 2011 14:20:51 +0000
Message-ID: <20110316142051.GA13684@00110101.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E5F6C2440E
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 15:20:56 +0100 (CET)
Received: by wyj26 with SMTP id 26so1544102wyj.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 07:20:55 -0700 (PDT)
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

Hi,

I am looking at implementing wireless MIDI
network using Contiki OS. I would run it
on relativelly powerfull microcontroller
(Freescale MC13224).

I looked at sourcode of aseqnet command
and it does look fairly small. Contiki
has uIP 6loWPAN for networking and it
connects to linux using SLIP-like 'tun'
virtual userspace interface.

I wonder if there could be any potential
issues in terms of IPv6 compatibility,
would aseqnet on Linux work with IPv6
or I will certainly need a tunnel ?

Would be greate to hear _ANY_ concerns,
of course I do imagine there will be a
latency (hopefully not too huge) and
I hope to work on this further.

I also though of MIDI RTP, but that
seems quite a bit bigger thing ..
Could anyone give a little insight
on what aseqnet really does?
I would imagine it is quite plain,
am I wrong ?

Well, I could perhaps implement
some very simplistic netcat/telnet
kind of data dumping, but would be
greate to get working smothly end-
to-end, i.e. all the way from my
wireless node (which will have
a MIDI din5 connector) to an app
on Linux, even amidi --dump ..hm
Also would be greate to get some
idea how clocking works w/ aseqnet.

Cheers,
-- 
Ilya 
