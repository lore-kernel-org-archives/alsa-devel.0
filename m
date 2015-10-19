From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Mon, 19 Oct 2015 23:13:24 +0900
Message-ID: <5624FA84.70208@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant> <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp> <20151013161516.27cb80cc@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id CC0EE265831
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 16:13:29 +0200 (CEST)
In-Reply-To: <20151013161516.27cb80cc@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

Sorry to be late for reply, but I have some works to ALSA firewire
stack. Furthermore, it takes me a bit time to write messages because I
always start to write after enough consideration, investigation and
arrangement about the point of issues.

On Oct 13 2015 23:15, Stefan Richter wrote:
> I was just generally wondering what the extent of protocol similarities
> are.  Personally I don't own a Digidesign, TASCAM, RME or MOTU at this
> time.  Thanks to you and to Jonathan for explaining.

These protocols use different format of data block, while I guess that
the number of data blocks transferred per second and the number of data
blocks in packets follow to IEC 61883-6. In this developing period, I
re-design AMDTP functionality in firewire-lib according to this assumption.

>> When the status and control messages are handled by the drivers, 
>> consumers are userspace applications. Userspace applications perform 
>> some reactions against the status and control messages. Most of the 
>> reactions are archieved via fw character devices.
>>
>> (Of cource, I know there're some requirements for drivers to perform 
>> such responsibilities, instead of userspace applications. But it's a 
>> rare case, I think.)
>>
>> When considering about userspace applications, permissions of fw 
>> character devices are important. Thus, 'udevd' in systemd project has 
>> enough rules for userspace applications to handle IEEE 1394 units for 
>> audio and sound.
> 
> Many of the udev rules which concern audio devices are actually maintained
> in the FFADO project and thus installed by the FFADO package (or by
> installing FFADO from source), in contrast to the usual way of keeping
> udev rules in the udev/systemd project and installing them via an udev
> package.
>
> FFADO is of course not unique in this regard.  As an example, the following
> packages are providing files in /lib/udev/rules.d/ on my current desktop
> installation:  alsa-utils, consolekit, fuse, kino, libffado, libgphoto2,
> libwacom, lvm2, media-player-info, netifrc, ntfs3g, sane-backends, udev,
> udisks, upower-pm-utils.  And of course I have site-specific rules in
> /etc/udev/rules.d/ too.

It's just for units supported by FFADO project, while udev has its rule
for ALSA sound cards.

https://github.com/systemd/systemd/blob/master/rules/78-sound-card.rules

When considering about the requirement of permissions for fw character
devices for the units, adding more rules for them is valuable. At least,
it's good to discuss about it, I think.

>> In the series of the patchset, I committed for some models which 
>> Digidesign and TASCAM produced. Unfortunately, there're no rules for 
>> these models. Userspace applications are disabled to access these units. 
>> I believe this issue is prior to handling status and control messages.
>>
>> Besides, I think this is a main issue which Damien Zammit faced in this 
>> post:
>>
>> [alsa-devel] firewire mixer interface -- was Re: [PATCH 11/11] ALSA: 
>> digi00x: apply double-oh-three algorism to multiplex PCM samples
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/089381.html
> 
> A developer of a mixer program which requires access to /dev/fw* has a few
> options:
>   - During early development, he could ask his testers to put a tentative
>     rule into /etc/udev/rules.d/ themselves.
>   - If the program is being developed as part of the FFADO project,
>     necessary rules should obviously be added to 60-ffado.rules.
>   - Otherwise the rules could be maintained and packaged together with the
>     mixer program.
>   - Or the rules could be submitted to the udev/systemd project.
> 
> Going the mainline udev route will naturally ensure that the rules conform
> to standard practice, and that may make the lives of distributors, admins,
> or users easier.

I'll continue to have cooperative relationship to FFADO project, while,
to tell the truth, I'm not willing to add my mixer/control programs to
the project anymore for several reasons:

 * code base is too old.
  * Especially for python3 support. Many distributions start to suppress
    python2 supports and near future ffado packages may be grouped
    as 'deprecated'.
 * over-specification
  * For most of mixer/control applications, it's just enough to
    send/receive asynchronous transactions. On the other hand, FFADO
    framework force developers to implement more codes unrelated to it.
    For example, D-Bus programming.
  * Libffado also includes streaming functionality and this is used to
    jackd. It's not so easy to modify without regressions, especially
    discover routine.
 * defectives as service application for IEEE 1394 bus
  * Libffado cannot handle bus-reset correctly, thus libffado cannot
    handle device hot-plugging. Although, ffado-dbus-server performs as
    system service. This is due to wrong usage of libraw1394 API.

But this is in my case. In this thread, it's better to continue to
discuss with ignoring it.

>> If possible, I'd like to add enough rules to udevd, including RME and 
>> MOTU models before working for them.
> 
> For those RME and MOTU models whose mixer program continues to be
> developed in the FFADO project, the FFADO-maintained ruleset is obviously
> sufficient.

As long as mixer/controls programs are developed by FFADO project only.

Here, I don't mean that I will do it. But it's disadvantage to persons
who like simpler applications. For such users, FFADO stuffs are not
always needed, especially for no-GUI users. I've got several messages
from such users and reccomend to use 'firewire-request' in
linux-firewire-tools package. For such users, it's better to add the
rules for fw character devices.

>> Well, for udevd, current ALSA firewire stack has another issue. It's 
>> 'device database' for IEEE 1394 units.
>>
>> Currently, the database has entries with vendor/model name of OHCI 1394 
>> host controller for any IEEE 1394 units. It's preferrable to use 
>> vendor/model name of each units, at least for audio and sound.
>>
>> PulseAudio includes a patch for this issue. It has additional conditions 
>> to select correct strings for IEEE 1394 units.
>> http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=3ac73598c67cb59a318c8baaf33fe97eed1e0b3e
>>
>> If possible, I'd like to remove this ugly patch by working in udevd 
>> upstream.
> 
> I saw the message which David Henningsson copied to linux1394-devel on
> February 16 but did not react---and have not noticed the issue before---,
> as I don't have pulseaudio installed on my own PCs yet.  It's probably
> the wrong place to ask, but:  Why do they generally prefer
> ID_{VENDOR,MODEL}_FROM_DATABASE over ID_{VENDOR,MODEL}?  I guess the
> former is more reliable or nicer on some other buses.

Yep. I also have the same opinion about PulseAudio implementation. I
guess there're some reasons shared to PulseAudio/udev/systemd
developers, not to us.

> I will have a look at the libudev sources whether the _FROM_DATABASE
> results can be improved for firewire.

Which lines?


Thanks

Takashi Sakamoto
