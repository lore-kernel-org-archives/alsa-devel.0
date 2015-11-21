From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/8] ALSA: dice: constrain PCM
 substreams to current sampling transfer frequency
Date: Sat, 21 Nov 2015 09:29:24 +0900
Message-ID: <564FBAE4.9070203@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8qbe6pm.wl-tiwai@suse.de> <564D4360.8050503@sakamocchi.jp>
 <s5hziyab8ak.wl-tiwai@suse.de> <564E9D6C.7060408@sakamocchi.jp>
 <s5hy4dt9g5h.wl-tiwai@suse.de> <564F01D0.20603@sakamocchi.jp>
 <s5hegfk9aey.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AD4C2614FD
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 01:29:29 +0100 (CET)
In-Reply-To: <s5hegfk9aey.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 20 2015 20:29, Takashi Iwai wrote:
>> Dice framework gives no ways for drivers to get supported combination
>> between rate/channels. We cannot change this design, of cource.
>>
>> Current ALSA dice driver manage to change the state of clock to generate
>> the supported combinations. But this does not always work well with some
>> technical reasons. Additionally, this is not preferrable for some users
>> who set their configurations to actual device in advance because the
>> state of clock is changed unexpectedly.
>>
>> This is a reason for patch 01-05.
> 
> Well, it's still not clear what you're changing.  With this change,
> what will be fixed, what will be broken and what will keep working at
> all?  Please explain them concisely.

Current ALSA dice driver fails to handle some Dice-based models. This
certainly occurs on the models. On the models, the driver fails to probe
or fails to start packet streaming.

This patchset manage to fix this issue. This patchset guarantees the
driver to probe models and start packet streaming to them. Instead, the
driver disallows userspace applications to request an arbitrary sampling
rate except for current sampling rate set to the device, because Dice
framwork doesn't allow drivers to get all of supported combinations
between rate/channels and drivers can't give enough information to
userspace applications.

> It's pretty common that a single clock and setup is used for multiple
> streams.  Such a restriction is found on many drivers.  What I don't
> understand is what makes this so special.

I don't correctly understand what you explain here. It includes some
ambiguous representation.

But if you meant 'Actually, when handling multiple substreams, for
example PCM substreams or MIDI substreams, common sound device works in
the same state of clock (rate, source , etc.), thus these drivers have a
restriction from the design. (end of the first paragraph, this paragraph
may be for our information.)
I wonder what happens on Dice-based models. Why ALSA dice driver must
lose its capability to react userspace request about sampling rate?'
(the end of your question),
I answer 'the renew ALSA dice driver doesn't lose it, but the driver
gives one PCM rule between rate/channels and enforce applications to use
it. As a result, the applications can request single rate which the PCM
rule indicate. If users hope to use different sampling rates except for
current rate configured to an actual device, they need to set it by the
other ways except for ALSA PCM interface.'

> In your original statement:
>> As a result, userspace applications can request PCM substreams at current
>> sampling transfer frequency. Therefore, when users want to start PCM
>> substreams at different rate, they should set the rate in advance by the
>> other ways (i.e. ffado-dbus-server/ffado-mixer).
> 
> So, an application cannot change the PCM rate other than the value
> currently set by another tool.  Is it correct?

Correct.


Next paragraph is my consideration about the design of Dice framework,
so it's not related to your question directly.

About the reason Dice framework has such a design, I guess that the
designer (TC Applied Technology) paies enough attention to cases in
which the formation of data channel in a data block of AMDTP packet is
not decided only at rate, but also at the other parameters such as the
data format of digital interface (S/PDIF or ADAT).

Actually, M-Audio Firewire 1814 or ProjectMix I/O has such a quirk and
ALSA BeBoB driver has a table to handle the quirk.
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/bebob/bebob_maudio.c#n224

When based on this assumption, the design of current ALSA dice driver is
not better, because it generates channel cache just according to rate.
This is one of my reason (but not certain) to restrict PCM rules at
current sampling transfer frequency. There may be Dice-based models with
such a quirk, perhaps.


Regards

Takashi Sakamoto
