From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: hardware-dependent features
Date: Tue, 13 Nov 2007 11:28:12 +1300
Message-ID: <4738D37C.7070304@audioscience.com>
References: <20071112131350.GA25885@buzzloop.caiaq.de>
	<1194888368.31578.1220875067@webmail.messagingengine.com>
	<30B53B6F-F339-429A-9957-7B130DF0BD4F@caiaq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id B4D102454A
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 23:28:23 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JRE00GJMZR35Q00@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 13 Nov 2007 11:28:16 +1300 (NZDT)
In-reply-to: <30B53B6F-F339-429A-9957-7B130DF0BD4F@caiaq.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I would also advocate using controls...

Daniel Mack wrote:
> Hi Clemens,
> 
> On Nov 12, 2007, at 6:26 PM, Clemens Ladisch wrote:
> 
>> I've used three 'mixer' controls for the three LEDs of the SB Audigy 2
>> NX.  Whether this is a good idea depends on how many LEDs there  
>> are, and
>> how one might want to use them.  Are there LED displays, i.e.,  
>> multiple
>> LEDs in a row?
> 
> Depends. There is one device which has 4 user-assignable LEDs, 

4 boolean controls

$ amixer cset 'Led 3' on

some
> others have up to >35 LEDs which can be dimmed in 64 steps, yet

Is that 64 steps each, or all together?
(i.e one dim control + 35 booleans, or 35 dim controls)


> another one has 7-segment LED displays.

integer or enumerated control.

> What I would like to achieve is a conventient way of accessing them,
> probably from the command line via some procfs or sysfs manner so
> users can even use scripts to switch them on and off if they like.
> 
>> I think the displays could by controlled by mixer controls of type
>> "bytes".  Usual mixer applications can't handle those, but this is
>> quite hardware dependent anway ...
> 
> But is that really where it belongs to? I would think that LEDs and
> input functions are not related to audio and thus should be handled
> by some other, more appropriate or maybe even proprietary subsystem.


> There are some features which have influcence on the audio
> behaviour since they affect the way the signal is processed, but
> LEDs are certainly not, are they?

I would think of them as "controls" on the device rather than "mixer".
you have options of enumerated, integer, boolean, (or bytes)

In addition you can specify an index as well as a name.

"Led", index=23
or "Led 23"

I'm not sure if you can add controls to an "interface" other than
"MIXER" (ie. "CARD")
Other ALSA devs please answer...


--
Eliot
