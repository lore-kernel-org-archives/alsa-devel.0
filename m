From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 13 Oct 2015 18:36:32 +0900
Message-ID: <561CD0A0.6000708@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant> <20151012222019.GB16052@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8957F2654D7
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 11:36:35 +0200 (CEST)
In-Reply-To: <20151012222019.GB16052@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>, Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

HI,

On Oct 13 2015 07:20, Jonathan Woithe wrote:
> On Mon, Oct 12, 2015 at 02:48:16PM +0200, Stefan Richter wrote:
>> On Oct 12 Takashi Sakamoto wrote:
>>> Although TASCAM FireWire series has physical controls, this patchset
>>> doesn't support them. I think some facilities are required to enable this
>>> functionality:
>>>   * handling MIDI messages on virtual MIDI ports by this driver
>>>   * handling status and control messages in isochronous packet by this
>>>     driver
>>
>> As a side note, AFAIR, RME devices encapsulate status in their isochronous
>> stream too... or was it MOTU?
>
> Both do, but in completely different ways for different purposes.  In the
> case of RME devices the information communicated can be used to help control
> and monitor the streaming system but it is not essential: there are other
> arguably easier ways to maintain the streaming rates, and these alternatives
> are what we use in FFADO now.
>
> In MOTU devices the information relates mainly to device control changes
> which are made via the front panel controls.  This is used to keep software
> mixer/control programs in sync with the hardware when changes are made on
> the hardware while the software control application is running.  It sounds
> like this is close to what the Tascam units do based on Takashi's comments
> (although obviously with a very different protocol).

(In this message, I mention about the other issues because of its 
priority, sorry.)

I don't know the reason that you're interested in it, while I'm not 
currently interested in it.

When the status and control messages are handled by the drivers, 
consumers are userspace applications. Userspace applications perform 
some reactions against the status and control messages. Most of the 
reactions are archieved via fw character devices.

(Of cource, I know there're some requirements for drivers to perform 
such responsibilities, instead of userspace applications. But it's a 
rare case, I think.)

When considering about userspace applications, permissions of fw 
character devices are important. Thus, 'udevd' in systemd project has 
enough rules for userspace applications to handle IEEE 1394 units for 
audio and sound.

In the series of the patchset, I committed for some models which 
Digidesign and TASCAM produced. Unfortunately, there're no rules for 
these models. Userspace applications are disabled to access these units. 
I believe this issue is prior to handling status and control messages.

Besides, I think this is a main issue which Damien Zammit faced in this 
post:

[alsa-devel] firewire mixer interface -- was Re: [PATCH 11/11] ALSA: 
digi00x: apply double-oh-three algorism to multiplex PCM samples
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/089381.html

If possible, I'd like to add enough rules to udevd, including RME and 
MOTU models before working for them.


Well, for udevd, current ALSA firewire stack has another issue. It's 
'device database' for IEEE 1394 units.

Currently, the database has entries with vendor/model name of OHCI 1394 
host controller for any IEEE 1394 units. It's preferrable to use 
vendor/model name of each units, at least for audio and sound.

PulseAudio includes a patch for this issue. It has additional conditions 
to select correct strings for IEEE 1394 units.
http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=3ac73598c67cb59a318c8baaf33fe97eed1e0b3e

If possible, I'd like to remove this ugly patch by working in udevd 
upstream.



I'm glad to get your help for these issues, Stefan and Jonathan.


Regards

Takashi Sakamoto
