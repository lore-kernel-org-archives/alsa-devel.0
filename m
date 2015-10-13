From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 13 Oct 2015 16:15:16 +0200
Message-ID: <20151013161516.27cb80cc@kant>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id AF167265AB3
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 16:15:20 +0200 (CEST)
In-Reply-To: <561CD0A0.6000708@sakamocchi.jp>
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

On Oct 13 Takashi Sakamoto wrote:
> HI,
> 
> On Oct 13 2015 07:20, Jonathan Woithe wrote:
> > On Mon, Oct 12, 2015 at 02:48:16PM +0200, Stefan Richter wrote:
> >> On Oct 12 Takashi Sakamoto wrote:
> >>> Although TASCAM FireWire series has physical controls, this patchset
> >>> doesn't support them. I think some facilities are required to enable this
> >>> functionality:
> >>>   * handling MIDI messages on virtual MIDI ports by this driver
> >>>   * handling status and control messages in isochronous packet by this
> >>>     driver
> >>
> >> As a side note, AFAIR, RME devices encapsulate status in their isochronous
> >> stream too... or was it MOTU?
> >
> > Both do, but in completely different ways for different purposes.  In the
> > case of RME devices the information communicated can be used to help control
> > and monitor the streaming system but it is not essential: there are other
> > arguably easier ways to maintain the streaming rates, and these alternatives
> > are what we use in FFADO now.
> >
> > In MOTU devices the information relates mainly to device control changes
> > which are made via the front panel controls.  This is used to keep software
> > mixer/control programs in sync with the hardware when changes are made on
> > the hardware while the software control application is running.  It sounds
> > like this is close to what the Tascam units do based on Takashi's comments
> > (although obviously with a very different protocol).
> 
> (In this message, I mention about the other issues because of its 
> priority, sorry.)
> 
> I don't know the reason that you're interested in it, while I'm not 
> currently interested in it.

I was just generally wondering what the extent of protocol similarities
are.  Personally I don't own a Digidesign, TASCAM, RME or MOTU at this
time.  Thanks to you and to Jonathan for explaining.

> When the status and control messages are handled by the drivers, 
> consumers are userspace applications. Userspace applications perform 
> some reactions against the status and control messages. Most of the 
> reactions are archieved via fw character devices.
> 
> (Of cource, I know there're some requirements for drivers to perform 
> such responsibilities, instead of userspace applications. But it's a 
> rare case, I think.)
> 
> When considering about userspace applications, permissions of fw 
> character devices are important. Thus, 'udevd' in systemd project has 
> enough rules for userspace applications to handle IEEE 1394 units for 
> audio and sound.

Many of the udev rules which concern audio devices are actually maintained
in the FFADO project and thus installed by the FFADO package (or by
installing FFADO from source), in contrast to the usual way of keeping
udev rules in the udev/systemd project and installing them via an udev
package.

FFADO is of course not unique in this regard.  As an example, the following
packages are providing files in /lib/udev/rules.d/ on my current desktop
installation:  alsa-utils, consolekit, fuse, kino, libffado, libgphoto2,
libwacom, lvm2, media-player-info, netifrc, ntfs3g, sane-backends, udev,
udisks, upower-pm-utils.  And of course I have site-specific rules in
/etc/udev/rules.d/ too.

> In the series of the patchset, I committed for some models which 
> Digidesign and TASCAM produced. Unfortunately, there're no rules for 
> these models. Userspace applications are disabled to access these units. 
> I believe this issue is prior to handling status and control messages.
> 
> Besides, I think this is a main issue which Damien Zammit faced in this 
> post:
> 
> [alsa-devel] firewire mixer interface -- was Re: [PATCH 11/11] ALSA: 
> digi00x: apply double-oh-three algorism to multiplex PCM samples
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/089381.html

A developer of a mixer program which requires access to /dev/fw* has a few
options:
  - During early development, he could ask his testers to put a tentative
    rule into /etc/udev/rules.d/ themselves.
  - If the program is being developed as part of the FFADO project,
    necessary rules should obviously be added to 60-ffado.rules.
  - Otherwise the rules could be maintained and packaged together with the
    mixer program.
  - Or the rules could be submitted to the udev/systemd project.

Going the mainline udev route will naturally ensure that the rules conform
to standard practice, and that may make the lives of distributors, admins,
or users easier.

> If possible, I'd like to add enough rules to udevd, including RME and 
> MOTU models before working for them.

For those RME and MOTU models whose mixer program continues to be
developed in the FFADO project, the FFADO-maintained ruleset is obviously
sufficient.

> Well, for udevd, current ALSA firewire stack has another issue. It's 
> 'device database' for IEEE 1394 units.
> 
> Currently, the database has entries with vendor/model name of OHCI 1394 
> host controller for any IEEE 1394 units. It's preferrable to use 
> vendor/model name of each units, at least for audio and sound.
> 
> PulseAudio includes a patch for this issue. It has additional conditions 
> to select correct strings for IEEE 1394 units.
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=3ac73598c67cb59a318c8baaf33fe97eed1e0b3e
> 
> If possible, I'd like to remove this ugly patch by working in udevd 
> upstream.

I saw the message which David Henningsson copied to linux1394-devel on
February 16 but did not react---and have not noticed the issue before---,
as I don't have pulseaudio installed on my own PCs yet.  It's probably
the wrong place to ask, but:  Why do they generally prefer
ID_{VENDOR,MODEL}_FROM_DATABASE over ID_{VENDOR,MODEL}?  I guess the
former is more reliable or nicer on some other buses.

I will have a look at the libudev sources whether the _FROM_DATABASE
results can be improved for firewire.
-- 
Stefan Richter
-=====-===== =-=- -==-=
http://arcgraph.de/sr/
