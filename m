From: "Keith A. Milner" <maillist@superlative.org>
Subject: Advice requested for developing C01U support via
	snd-usb-audio
Date: Sat, 22 Nov 2008 19:20:23 +0000
Message-ID: <200811221920.23616.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from virtuser.com (unknown [77.92.93.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 141B524368
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 20:20:27 +0100 (CET)
Received: from [82.152.152.239] (helo=asmodeus.superlative.org)
	by apollo.safeukdns.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <maillist@superlative.org>)
	id 1L3y1p-0005yX-IV
	for alsa-devel@alsa-project.org; Sat, 22 Nov 2008 19:20:25 +0000
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
New to this mailing list so please go easy on me. I've been reading through 
the Alsa docs, wiki, and still not sure of the best approach, so looking for 
advice from the experts.

I'm looking to develop support for the Samson C01U USB studio microphone.

http://www.samsontech.com/products/productpage.cfm?prodID=1810

This currently does work via the snd-usb-audio alsa driver, but not in a way 
that is particularly usable (to the extent that many users have been 
reporting it as "not working". I thought I might attempt to remedy this.

The problem is that, internally, the device contains two digitally controlled 
amplifiers. Both of these gain controls are exposed via the USB interface 
(and, hence, by snd-usb-audio) and you can even access the audio stream which 
is output from each amp. The problem is the raw gain controls are not meant 
to be accessed directly in this way.

The output of one of the amps is fed into the input of the other. With the 
Windows and Mac OSX drivers, only one gain control is presented. When this is 
is altered, the driver adjusts the gain of both amplifiers in order to get 
the correct output level but with minimum noise.

In effect, there is a "virtual gain control" which is used to adjust the real 
gain controls in a predefined way.

By careful "twiddling" of the controls it's possible to get the microphone 
working properly, but it is, quite frankly, a very poor way to handle the 
problem and is really beyond what should be expected of most users.

I would like to do something about this if I can.

My aim is to develop something which presents a single gain control to users 
which controls the internal amp gains in a sensible way.

The question is, what is the best way to approach this?

Looking at it, I believe there are three possible approaches. In order of my 
preference they are:

1) Develop at alsa driver level to get a driver which presents a single mixer 
control to users
2) Develop a new plugin for alsa which can be patched in via asoundrc to 
provide a generic "Virtual gain control"
3) Provide a user-space tool, a bit like envy24control, which provides this 
capability

My question to the alsa-devel community is which path should I take? As I said 
my preference is to do something at the driver level simply because it would 
be most transparent to users and applications: it would simply work. It may 
also require less code.

If this is the correct path to take, this then presents some sub-options 
(again in order of preference):

a) Patch the existing snd-usb-audio driver with some vendor-specific code for 
this devices (and others which will be similar, like the C03U)
b) Fork the snd-usb-driver into a new vendor-specific version and modify as 
before

I prefer a) again because it is transparent to the users, whilst b) will 
require modprobe or udev configuration, but there may be reasons why it is 
undesirable to "bloat" the code of snd-usb-audio with vendor-specific tweaks.

Bear in mind at this stage I haven't even looked at any of the code yet. Once 
I do I'm sure to have more questions.

But at the moment my question is simply: which is the best way to approach 
this to be compatible with the aims and philosophy of Alsa?

Many thanks,

-- 
Keith A. Milner
