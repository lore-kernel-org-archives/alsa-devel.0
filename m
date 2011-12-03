From: Peter Dunker <pdunker@gracenote.com>
Subject: snd-usb-audio - NI Traktor 10 - phono settings
Date: Fri, 2 Dec 2011 20:02:15 -0800
Message-ID: <46ECA1EC0460234BAE43D054B3738BDA068BDDE53B@GNMAILBOX.gracenote.gracenote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gracenote.com (pat.gracenote.com [209.10.41.94])
	by alsa0.perex.cz (Postfix) with ESMTP id A56A2103892
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 05:02:18 +0100 (CET)
Received: from [10.3.8.55] (helo=SCCAS02.gracenote.gracenote.com)
	by mail.gracenote.com with esmtp (Exim 4.42) id 1RWgnp-0001H2-2X
	for alsa-devel@alsa-project.org; Fri, 02 Dec 2011 20:02:17 -0800
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
I am new to this list, so please excuse if my questions are not at the right target group.
First of all, awesome work of the alsa developer to provide these system and modules!

I am using since a couple days the NI Traktor 10 USB audio sound card that has 10 channels.
I use Ubuntu 11.10. and I was able to capture with arecord from the device out of the box all 10 channels and I was able to make an asoundrc to make 10 devices each 1 channel of it too.

My problem is now that this device enables by default 4 of the 10 channels as phono level input, which leads to clipping and corrupt audio on these channels when I feed line level.
NI provides an config app for Mac and Windows to set phono or non phono to the channels that you like.
Unfortunately, these settings do not stay as you set under win or mac.

My question, is there anything in this snd-usb-audio driver module that could help me set this phono on/off values or can you guys think of any other Linux tool that I could use to set these fields? I also noticed that some channels actually changed the phono setting while connecting to win and back to linux.
So if you guys have an idea how to set these values so that they might stay even when connect to Linux, this would be helpful too.

Thanks in advance for reading,
Peter
