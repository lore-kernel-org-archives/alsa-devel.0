From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Realtek alc269 questions
Date: Mon, 26 Jul 2010 13:03:41 +0200
Message-ID: <4C4D6B8D.5040909@canonical.com>
References: <4C4D5D0E.6050900@canonical.com> <s5h7hkiwn7u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 347DE24710
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 13:03:43 +0200 (CEST)
In-Reply-To: <s5h7hkiwn7u.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010-07-26 12:29, Takashi Iwai skrev:
> At Mon, 26 Jul 2010 12:01:50 +0200,
> David Henningsson wrote:
>>
>> I'm trying to fix the sound on some Dell Optiplex machines, which are
>> running the ALC269 chip. I can "fix" them with some hda-verb commands,
>> but that won't get me auto-mute, so I'll have to make a model (or
>> possibly more than one) for them.
> 
> What is actually a problem?

It varies between the different models, but most problems I think come
from that pin NIDs aren't the same as the auto-parser (or any of the
models) assume.

This causes playback, recording, auto-mute etc to fail.

In addition, a minor issue is that one of the models are being
mislabeled as ALC259.

>> Anyway, I have a pair of questions:
>>
>> 1) In dmesg, there is a "SKU not ready" message at startup. What is SKU,
>> and is it a problem that it is not ready?
> 
> Realtek codecs suppose that the device PCI SSID is set up for
> indicating hardware functionalities.  This is Realtek-specific, and
> most vendors don't follow.  The driver spews some messages when the
> SSID isn't compliant.
> 
>> 2) There are two DACs, and all models so far seem to use NID 0x03 for
>> headphones and NID 0x02 for everything else. But is there a single
>> stream going through the controller and then splitted into two on the
>> codec side, or is just one of the DACs activated at a time, depending on
>> the jack sensing state?
> 
> Both DACs use the same single stream at the same time.

Thanks for your answers!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
