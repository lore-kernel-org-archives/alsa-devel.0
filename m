From: Chris Howells <chris+alsa@chrishowells.co.uk>
Subject: Bug report,
	multichannel LPCM over nvidia HDMI not working
Date: Mon, 05 Oct 2009 20:12:06 +0100
Message-ID: <4ACA4506.1070103@chrishowells.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.devrandom.org.uk (frodo.devrandom.org.uk [77.240.13.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D5D1A103801
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 21:12:16 +0200 (CEST)
Received: from [192.168.0.37] (78-86-201-129.zone2.bethere.co.uk
	[78.86.201.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.devrandom.org.uk (Postfix) with ESMTP id E6A861803F
	for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2009 20:12:08 +0100 (BST)
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

I am trying to get multi-channel LPCM working over HDMI, from an Acer 
Revo (Nvidia Ion) to a Sony STR-DH800 amp. 2 channel LPCM is working 
perfectly, as is bitstreaming AC3 and DTS (with xbmc). The latest I've 
tried is with kernel 2.6.31.1.

I am testing with speaker-test. I have found that:

'speaker-test -D hdmi -c2' works perfect. The amp lights up show 2 
channel LPCM. Sound is from the front left and front right.
http://chrishowells.co.uk/speakertest2ch.jpg

'speaker-test -D hdmi -c6' or (-c8) does not work. The amp realises that 
there is some PCM sounds, but the amp does not seem to recognise the 
stream properly, *however*, sound does come out of the left and right.
http://chrishowells.co.uk/speakertest6ch.jpg

The version of speaker-test is from Alsa 1.0.20.

Here's the results of running alsa-info.sh

http://www.alsa-project.org/db/?f=d90ca1ce07bf20af3241114b11fb31f79ed63fec

The 'Misc = NO_PRESENCE' struck me as being a bit odd.

The Revo has been upgraded to the A2 bios (didn't work with A1 either), 
and the Nvidia drivers are 190.32. I've spent quite a few days trying to 
get this work, including alsa 1.0.20 and 1.0.21 on ubuntu 9.04 with and 
without the 8ch patch, Ubuntu karmic beta standard, as well as patching 
alsa 1.0.20 it with the 8ch patch.

Most grateful for any help.
