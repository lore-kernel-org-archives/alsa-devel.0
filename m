From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 27 Oct 2015 00:18:37 +0900
Message-ID: <562E444D.5070400@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant> <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp> <20151013161516.27cb80cc@kant>
 <5624FA84.70208@sakamocchi.jp> <20151019233640.GB8953@marvin.atrad.com.au>
 <56258FE6.9000304@sakamocchi.jp> <20151020093907.033831d3@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EF8C2606E0
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 16:18:44 +0100 (CET)
In-Reply-To: <20151020093907.033831d3@kant>
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

On Oct 20 2015 16:39, Stefan Richter wrote:
> On Oct 20 Takashi Sakamoto wrote:
>> When using polkit correctly, I guess users doesn't need to join in
>> 'audio' group, so as PulseAudio achieved with polkit.

(PulseAudio did remove usage of polkit at 2008. Currently, its access to
sound character devices is granted according to permissions added by ACL.)

> With regard to access to /dev/fw* files, this is true with the existing
> FFADO rules too.  60-ffado.rules sets ENV{ID_FFADO}="1", and
> consolekit's 70-udev-acl.rules recognizes ID_FFADO and runs udev-acl on
> the device.
> 
> (I.e. the current "console" owner is granted access to the character
> device file via access control list (ACL), which is a mechanism in
> parallel to Unix permission flags.)

In systemd era, consolekit is obsoleted by systemd-logind, and udevd
calls a functionality of systemd-logind to add enough ACL for uaccess entry.

> The console owner policy and ACL mechanism are not a complete replacement
> for the group mechanism though:
>   - There may be headless systems and other occasions at which the audio
>     user is not console owner.

I think usual user doesn't use such systems. Here, I imagine the user
works with major Linux discribution such as Ubuntu.

>   - Processes involved in capture or playback, i.e. applications beyond
>     mixers, may require realtime scheduling class privilege and memlocking
>     privilege, which are traditionally configured for Unix groups and
>     users (typically for a group).  Not sure whether a mechanism exists
>     which can implement a console owner policy for realtime and memlock
>     privileges.

Hm. About such applications which changes scheduling attributes of
tasks, the user intentionally run for his or her purpose. I think this
is not so usual cases which the system should support as a default.

I think it better to continue discussion about enough ACL, regardless of
'audio' group. In short, when connecting audio and music units on IEEE
1394 bus, login users have enough permission to corresponding firewire
character devices, then they can execute any I/O operatins to the
devices. This is not achieved yet.

For example, in this developing period, I added new module to support
TASCAM FW1082/1884. When connecting these models, currently, login users
are not grant. Root user is just granted.

There's another issue. In this time, I also added TASCAM FireOne support
to ALSA OXFW driver. Any login users are granted to access the
corresponding character device, while the device node belongs to 'video'
user. I think this line causes this issue:
https://github.com/systemd/systemd/blob/c379f143a5ccdbc94a87cfca0174e7f21fa05f26/rules/50-udev-default.rules#L43

The model has 0x00a02d for 'specifier_id' in its unit directory of
CONFIG ROM. This may match the line.


Well, I think this is a better start point for this discussion:
 * Any login users should be granted to access firewire character
   devices for audio and music units on IEEE 1394 bus, with helps of
   consolekit or systemd-logind. The users can run any apprications
   to execute IO operation to these devices without additional
   configurations.
 * When users want to start applications requiring special privillege,
   the users should add configurations, i.e. for PAM. In this case,
   typically, users join in 'audio' group and add the configurations to
   'audio' group.



Thanks

Takashi Sakamoto
