From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 27 Oct 2015 02:38:57 +0100
Message-ID: <20151027023857.1bd708b8@kant>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp> <20151013161516.27cb80cc@kant>
 <5624FA84.70208@sakamocchi.jp>
 <20151019233640.GB8953@marvin.atrad.com.au>
 <56258FE6.9000304@sakamocchi.jp> <20151020093907.033831d3@kant>
 <562E444D.5070400@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EC3D2651A5
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 02:38:59 +0100 (CET)
In-Reply-To: <562E444D.5070400@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 27 Takashi Sakamoto wrote:
> On Oct 20 2015 16:39, Stefan Richter wrote:
> > The console owner policy and ACL mechanism are not a complete replacement
> > for the group mechanism though:
> >   - There may be headless systems and other occasions at which the audio
> >     user is not console owner.
> 
> I think usual user doesn't use such systems. Here, I imagine the user
> works with major Linux discribution such as Ubuntu.
> 
> >   - Processes involved in capture or playback, i.e. applications beyond
> >     mixers, may require realtime scheduling class privilege and memlocking
> >     privilege, which are traditionally configured for Unix groups and
> >     users (typically for a group).  Not sure whether a mechanism exists
> >     which can implement a console owner policy for realtime and memlock
> >     privileges.
> 
> Hm. About such applications which changes scheduling attributes of
> tasks, the user intentionally run for his or her purpose. I think this
> is not so usual cases which the system should support as a default.

I mentioned the two points mostly as an illustration for pros and cons of
Unix groups mechanism/ policy in comparison to ACL mechanism/ console
owner policy.

If one of us submits new rules for inclusion into mainline systemd git, I
assume that the udev rules maintainers of the systemd project will direct
us as necessary, so that good default mechanisms and policies are
implemented.

[...]
> There's another issue. In this time, I also added TASCAM FireOne support
> to ALSA OXFW driver. Any login users are granted to access the
> corresponding character device, while the device node belongs to 'video'
> user. I think this line causes this issue:
> https://github.com/systemd/systemd/blob/c379f143a5ccdbc94a87cfca0174e7f21fa05f26/rules/50-udev-default.rules#L43
> 
> The model has 0x00a02d for 'specifier_id' in its unit directory of
> CONFIG ROM. This may match the line.

In earlier times, some or all of these lines had comments that explained
what is what. The comments were removed eventually.  Here is what each
Specifier and Version (i.e. protocol) identifiers means (see also bottom of
http://1394ta.org/1394-test-resources/):

SUBSYSTEM=="firewire", ATTR{units}=="*0x00a02d:0x00010*", GROUP="video"
	specifier: 1394 TA
	protocol: IIDC (Instrumentation & Industrial Digital Camera)

SUBSYSTEM=="firewire", ATTR{units}=="*0x00b09d:0x00010*", GROUP="video"
	specifier: Point Grey Research, Inc.
	protocol: IIDC
	(actually plain IIDC as specified by 1394 TA, but AFAIK the
	nonstandard specifier ID is there to get the vendor's driver
	loaded on other OSs)

SUBSYSTEM=="firewire", ATTR{units}=="*0x00a02d:0x010001*", GROUP="video"
	specifier: 1394 TA
	protocol: AV/C

SUBSYSTEM=="firewire", ATTR{units}=="*0x00a02d:0x014001*", GROUP="video"
	specifier: 1394 TA
	protocol: AV/C and vendor-unique

Note, the "*" asterisks in these patterns serve two purposes:  First, a
node with several units will expose a space-separated list of
specifier:version tuples in the units attribute.  Second, the version ID
is always 24 bits wide, but we may want to match just the uppermost 20 or
fewer bits of the version.

BTW, the "units" attribute and the others are described in
Documentation/ABI/stable/sysfs-bus-firewire.  But here is an example from
a device with four units:
$ cat /sys/bus/firewire/devices/fw13/*{name,units}
iSight
Apple Computer, Inc.
0x00a02d:0x000102 0x000a27:0x000010 0x000a27:0x000011 0x000a27:0x000012
(IIDC v1.30, iSight audio, iSight factory, iSight iris units)

As you know, firewire-core merely discovers nodes and units (including AV/C
units), but not subdevices below them, such as SBP logical units or AV/C
subunits.  Consequently, firewire-core does not expose a sysfs attribute
which describes the AV/C subunit type (monitor, audio, disc, tape, tuner,
camera, music, and more).  The first udev rules for FireWire devices were
written in times when camcorders and other DV devices were considered more
numerous in use than audio AV/C devices.  Hence the choice of GROUP="video"
which has been carried over from that time.  In addition, many
distributions
at the time added new user accounts to a "video" group by default, but
fewer distributions did the same with an "audio" group.

Do we need to add AV/C subunit discovery to firewire-core, in order to add
AV/C subunit type attributes to sysfs?  Perhaps not, if we can come up with
udev rules for audio devices which work off existing attributes like those
which the audio kernel drivers themselves match by their mod-alias.  We
need to restrict ourselves to "node device attributes"
in /sys/bus/firewire/devices/fw[0-9]+/ though.  The "unit device
attributes" in /sys/bus/firewire/devices/fw[0-9]+[.][0-9]+/ cannot be used
because they are populated in later uevents than the one which
triggers creation of the /dev/fw* file.
-- 
Stefan Richter
-=====-===== =-=- ==-==
http://arcgraph.de/sr/
