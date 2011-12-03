From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb-audio - NI Traktor 10 - phono settings
Date: Sat, 03 Dec 2011 17:37:05 +0100
Message-ID: <4EDA5031.1050502@gmail.com>
References: <46ECA1EC0460234BAE43D054B3738BDA068BDDE53B@GNMAILBOX.gracenote.gracenote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1F1AE2473E
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 17:37:14 +0100 (CET)
Received: by bkcjk13 with SMTP id jk13so2620232bkc.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Dec 2011 08:37:11 -0800 (PST)
In-Reply-To: <46ECA1EC0460234BAE43D054B3738BDA068BDDE53B@GNMAILBOX.gracenote.gracenote.com>
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

On 12/03/2011 05:02 AM, Peter Dunker wrote:
> Hi, I am new to this list, so please excuse if my questions are not
> at the right target group.

No, this is the perfectly right place for asking such questions :) For
the record, please make sure you send your follow-ups to the list as well.

> I am using since a couple days the NI Traktor 10 USB audio sound card
> that has 10 channels. I use Ubuntu 11.10. and I was able to capture
> with arecord from the device out of the box all 10 channels and I was
> able to make an asoundrc to make 10 devices each 1 channel of it
> too.
> 
> My problem is now that this device enables by default 4 of the 10
> channels as phono level input, which leads to clipping and corrupt
> audio on these channels when I feed line level. NI provides an config
> app for Mac and Windows to set phono or non phono to the channels
> that you like. Unfortunately, these settings do not stay as you set
> under win or mac.

There is no such tool, but controls for all 4 analog stereo pairs to
configure the "direct thru" modes and the phono pre-amps should be
exported as generic amixer controls.

> My question, is there anything in this snd-usb-audio driver module
> that could help me set this phono on/off values or can you guys think
> of any other Linux tool that I could use to set these fields? I also
> noticed that some channels actually changed the phono setting while
> connecting to win and back to linux. So if you guys have an idea how
> to set these values so that they might stay even when connect to
> Linux, this would be helpful too.

Post the output of "amixer controls", please. If there is more than one
card connected and the TA10 is not your default, you might need to pass
the "-D" option to amixer as well. See the output of "cat
/proc/asound/cards" for the right value to pass. With this output, it
should be easy to find the correct ALSA control to use with "amixer cset".


Daniel
