From: "Santosh" <santosh@faith.co.jp>
Subject: RE: Alsa-devel digest, Vol 1 #4542 - 10 msgs
Date: Wed, 11 Jan 2006 20:56:42 +0900
Message-ID: <PDEJLBANHPDLFCIDCEDIIEENCAAA.santosh@faith.co.jp>
References: <20060111101002.09F0089A04@sc8-sf-spam1.sourceforge.net>
Reply-To: <santosh@faith.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060111101002.09F0089A04@sc8-sf-spam1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all!!!
   iam a new bie to ALSA group. Currently i need some information related to
ALSA.I have the following question:

   Whether ALSA supports real time mode?

   In real time mode the player send the MIDI events directly to the
synthesizer that are contained in the current frame. There is no time
information in the events
   and there is no bufferization

Thanks in advance..

Santosh




-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of
alsa-devel-request@lists.sourceforge.net
Sent: Wednesday, January 11, 2006 7:09 PM
To: alsa-devel@lists.sourceforge.net
Subject: Alsa-devel digest, Vol 1 #4542 - 10 msgs


Send Alsa-devel mailing list submissions to
	alsa-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/alsa-devel
or, via email, send a message with subject or body 'help' to
	alsa-devel-request@lists.sourceforge.net

You can reach the person managing the list at
	alsa-devel-admin@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Alsa-devel digest..."


Today's Topics:

   1. [ALSA - driver 0001732]: Support for Intel D945Pvs Board
(bugtrack@alsa-project.org)
   2. [ALSA - driver 0001733]: Intel HDA Modem ? (bugtrack@alsa-project.org)
   3. [ALSA - driver 0001733]: Intel HDA Modem ? (bugtrack@alsa-project.org)
   4. Re: Hercules PC DJ Console (Windows Edition) information (Eric
Shattow)
   5. Re: Hercules PC DJ Console (Windows Edition)
       information (Lee Revell)
   6. [ALSA - driver 0001734]: Multiple cards not working with jack
(bugtrack@alsa-project.org)
   7. [ALSA - driver 0001734]: Multiple cards not working with jack
(bugtrack@alsa-project.org)
   8. [ALSA - driver 0001735]: OSS emulation 4-channel mode rear channels
not working (bugtrack@alsa-project.org)
   9. [ALSA - driver 0001735]: OSS emulation 4-channel mode rear channels
not working (bugtrack@alsa-project.org)

--__--__--

Message: 1
Date: Wed, 11 Jan 2006 05:04:34 +0100
To: alsa-devel@alsa-project.org
From: bugtrack@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001732]: Support for Intel D945Pvs
Board


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1732>
======================================================================
Reported By:                timtt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1732
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               FC4
Kernel Version:             2.6.14-1656
======================================================================
Date Submitted:             01-11-2006 04:53 CET
Last Modified:              01-11-2006 05:04 CET
======================================================================
Summary:                    Support for Intel D945Pvs Board
Description:
Alsa is only able to output regular 2-channel audio via the headphone jack
at the back of this motherboard. This motherboard has an SPDIF connection
available that is currently not supported, but should be.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-11-06 05:04
----------------------------------------------------------------------
Did you try the various "model" options for hda-intel which are documented
in ALSA-Configuration.txt?

Issue History
Date Modified  Username       Field                    Change
======================================================================
01-11-06 04:53 timtt          New Issue
01-11-06 04:53 timtt          Distribution              => FC4
01-11-06 04:53 timtt          Kernel Version            => 2.6.14-1656
01-11-06 05:04 rlrevell       Note Added: 0007558
======================================================================




--__--__--

Message: 2
Date: Wed, 11 Jan 2006 07:23:37 +0100
To: alsa-devel@alsa-project.org
From: bugtrack@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001733]: Intel HDA Modem ?


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1733>
======================================================================
Reported By:                chrmue
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1733
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE Linux 10.0
Kernel Version:             2.6.13-15
======================================================================
Date Submitted:             01-11-2006 07:23 CET
Last Modified:              01-11-2006 07:23 CET
======================================================================
Summary:                    Intel HDA Modem ?
Description:
I want to use my HDA Softmodem in Linux, is there any development on a HDA
Modem Module ?

cat /proc/asound/card0/codec#1 gives me:
Codec: Generic 11c1 ID 3026
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x70500

In Windows it is called "Agere Systems HDA Modem" (Conexant ?)

If there is development on this i would like to participate to get it
going, because i dont't want to have a windows-installation on my Notebook
(Acer TravelMate 8104) just for getting my mails at my parents house,
where there is only analog telephone.
======================================================================

Issue History
Date Modified  Username       Field                    Change
======================================================================
01-11-06 07:23 chrmue         New Issue
01-11-06 07:23 chrmue         Distribution              => SuSE Linux 10.0
01-11-06 07:23 chrmue         Kernel Version            => 2.6.13-15
======================================================================




--__--__--

Message: 3
Date: Wed, 11 Jan 2006 07:42:39 +0100
To: alsa-devel@alsa-project.org
From: bugtrack@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001733]: Intel HDA Modem ?


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1733>
======================================================================
Reported By:                chrmue
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1733
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE Linux 10.0
Kernel Version:             2.6.13-15
======================================================================
Date Submitted:             01-11-2006 07:23 CET
Last Modified:              01-11-2006 07:42 CET
======================================================================
Summary:                    Intel HDA Modem ?
Description:
I want to use my HDA Softmodem in Linux, is there any development on a HDA
Modem Module ?

cat /proc/asound/card0/codec#1 gives me:
Codec: Generic 11c1 ID 3026
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x70500

In Windows it is called "Agere Systems HDA Modem" (Conexant ?)

If there is development on this i would like to participate to get it
going, because i dont't want to have a windows-installation on my Notebook
(Acer TravelMate 8104) just for getting my mails at my parents house,
where there is only analog telephone.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-11-06 07:42
----------------------------------------------------------------------
You could try the Linuxant soft modem but it's not free...

Issue History
Date Modified  Username       Field                    Change
======================================================================
01-11-06 07:23 chrmue         New Issue
01-11-06 07:23 chrmue         Distribution              => SuSE Linux 10.0
01-11-06 07:23 chrmue         Kernel Version            => 2.6.13-15
01-11-06 07:42 rlrevell       Note Added: 0007559
======================================================================




--__--__--

Message: 4
Date: Wed, 11 Jan 2006 01:30:53 -0600
From: Eric Shattow <lucent@gmail.com>
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Hercules PC DJ Console (Windows Edition)
information

On 10/19/05, Eric Shattow <lucent@gmail.com> wrote:
> On 10/19/05, Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > They make a DIFFERENT DEVICE with a DIFFERENT CHIPSET for Mac and
> > Windows?!?  WTF?
> >
> > Lee
> >
>
> Alexander Schussler owns both the Windows and Mac editions of the DJ
> Console hardware. According to his correspondence with
> Hercules/Guillemot representatives, the hardware is identical except
> for improved audio function on the Mac edition. My guess is that the
> Windows edition is first revision, and Mac edition is second revision.
> The firmware is of course completely different between the two
> editions.
>

Anyways, update for everyone.  The ALSA 1.0.10 release doesn't appear
to work with Hercules PC DJ Console (Windows Edition) device. I have
not been able to make it output or record sound.

jnc@baker:~$ arecord -D hw:3 -f S16_LE -c 2 -r 48000 /tmp/test.wav
Recording WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Stereo
arecord: xrun:1077: read/write error, state =3D PREPARED

Something like that.  Suggestions, anyone?

 Eric


--__--__--

Message: 5
Subject: Re: [Alsa-devel] Hercules PC DJ Console (Windows Edition)
	information
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
Date: Wed, 11 Jan 2006 02:34:21 -0500

On Wed, 2006-01-11 at 01:30 -0600, Eric Shattow wrote:
> On 10/19/05, Eric Shattow <lucent@gmail.com> wrote:
> > On 10/19/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > They make a DIFFERENT DEVICE with a DIFFERENT CHIPSET for Mac and
> > > Windows?!?  WTF?
> > >
> > > Lee
> > >
> >
> > Alexander Schussler owns both the Windows and Mac editions of the DJ
> > Console hardware. According to his correspondence with
> > Hercules/Guillemot representatives, the hardware is identical except
> > for improved audio function on the Mac edition. My guess is that the
> > Windows edition is first revision, and Mac edition is second revision.
> > The firmware is of course completely different between the two
> > editions.
> >
>
> Anyways, update for everyone.  The ALSA 1.0.10 release doesn't appear
> to work with Hercules PC DJ Console (Windows Edition) device. I have
> not been able to make it output or record sound.
>
> jnc@baker:~$ arecord -D hw:3 -f S16_LE -c 2 -r 48000 /tmp/test.wav
> Recording WAVE '/tmp/test.wav' : Signed 16 bit Little Endian, Rate
> 48000 Hz, Stereo
> arecord: xrun:1077: read/write error, state = PREPARED
>
> Something like that.  Suggestions, anyone?

Assuming this worked with previous versions, the problem may be that USB
audio has been broken since kernel 2.6.14 (ALSA 1.0.10rcsomething).

Try the patch attached to this bug report.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585

Lee



--__--__--

Message: 6
Date: Wed, 11 Jan 2006 10:33:22 +0100
To: alsa-devel@alsa-project.org
From: bugtrack@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001734]: Multiple cards not working
with jack


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1734>
======================================================================
Reported By:                danhien_cz
Assigned To:
======================================================================
Project:                    ALSA - driver
Issue ID:                   1734
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               GENTOO
Kernel Version:             2.6.12-r9
======================================================================
Date Submitted:             01-11-2006 10:33 CET
Last Modified:              01-11-2006 10:33 CET
======================================================================
Summary:                    Multiple cards not working with jack
Description:
I've got two sound cards in my system and I'm using both of them.
After upgrading alsa-driver 1.0.8 up to 1.0.10 and upgrading
jack-audion-connection-kit from 0.99.0 to version 0.100.7 my multiple card
configuration stop working.
When I try start jack on surround51 this error message appears:
--------------------------------------------------------------
ALSA: poll time out, polled for 31973583 usecs
DRIVER NT: could not run driver cycle
--------------------------------------------------------------
When I try start jack on my multiple devices, jack crashes with
segmentation fault. Everything was working with the older versions.
This is my asound.conf file:
--------------------------------------------------------------
pcm.jack_playback {
        type multi
        slaves.a.pcm "surround51"
        slaves.a.channels 6
        slaves.b.pcm "hw:1,0"
        slaves.b.channels 2
        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave a
        bindings.2.channel 2
        bindings.3.slave a
        bindings.3.channel 3
        bindings.4.slave a
        bindings.4.channel 4
        bindings.5.slave a
        bindings.5.channel 5
        bindings.6.slave b
        bindings.6.channel 0
        bindings.7.slave b
        bindings.7.channel 1
}

pcm.jack_capture {
        type multi
        slaves.a.pcm "hw:0,0"
        slaves.a.channels 2
        slaves.b.pcm "hw:1,0"
        slaves.b.channels 2
        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave b
        bindings.2.channel 0
        bindings.3.slave b
        bindings.3.channel 1
}

pcm.jack12 {
        type asym
        playback.pcm {
                type route
                slave.pcm "surround51"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
                ttable.4.4 1
                ttable.5.5 1
                ttable.6.6 1
                ttable.7.7 1
        }
        capture.pcm {
                type route
                slave.pcm "jack_capture"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
        }
}

ctl.jack12 {
        type hw
        card 0
}
--------------------------------------------------------------
======================================================================

Issue History
Date Modified  Username       Field                    Change
======================================================================
01-11-06 10:33 danhien_cz     New Issue
01-11-06 10:33 danhien_cz     Distribution              => GENTOO
01-11-06 10:33 danhien_cz     Kernel Version            => 2.6.12-r9
======================================================================




--__--__--

Message: 7
Date: Wed, 11 Jan 2006 10:35:04 +0100
To: alsa-devel@alsa-project.org
From: bugtrack@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001734]: Multiple cards not working
with jack


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1734>
======================================================================
Reported By:                danhien_cz
Assigned To:
======================================================================
Project:                    ALSA - driver
Issue ID:                   1734
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               GENTOO
Kernel Version:             2.6.12-r9
======================================================================
Date Submitted:             01-11-2006 10:33 CET
Last Modified:              01-11-2006 10:35 CET
======================================================================
Summary:                    Multiple cards not working with jack
Description:
I've got two sound cards in my system and I'm using both of them.
After upgrading alsa-driver 1.0.8 up to 1.0.10 and upgrading
jack-audion-connection-kit from 0.99.0 to version 0.100.7 my multiple card
configuration stop working.
When I try start jack on surround51 this error message appears:
--------------------------------------------------------------
ALSA: poll time out, polled for 31973583 usecs
DRIVER NT: could not run driver cycle
--------------------------------------------------------------
When I try start jack on my multiple devices, jack crashes with
segmentation fault. Everything was working with the older versions.
This is my asound.conf file:
--------------------------------------------------------------
pcm.jack_playback {
        type multi
        slaves.a.pcm "surround51"
        slaves.a.channels 6
        slaves.b.pcm "hw:1,0"
        slaves.b.channels 2
        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave a
        bindings.2.channel 2
        bindings.3.slave a
        bindings.3.channel 3
        bindings.4.slave a
        bindings.4.channel 4
        bindings.5.slave a
        bindings.5.channel 5
        bindings.6.slave b
        bindings.6.channel 0
        bindings.7.slave b
        bindings.7.channel 1
}

pcm.jack_capture {
        type multi
        slaves.a.pcm "hw:0,0"
        slaves.a.channels 2
        slaves.b.pcm "hw:1,0"
        slaves.b.channels 2
        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave b
        bindings.2.channel 0
        bindings.3.slave b
        bindings.3.channel 1
}

pcm.jack12 {
        type asym
        playback.pcm {
                type route
                slave.pcm "surround51"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
                ttable.4.4 1
                ttable.5.5 1
                ttable.6.6 1
                ttable.7.7 1
        }
        capture.pcm {
                type route
                slave.pcm "jack_capture"
                ttable.0.0 1
                ttable.1.1 1
                ttable.2.2 1
                ttable.3.3 1
        }
}

ctl.jack12 {
        type hw
        card 0
}
--------------------------------------------------------------
======================================================================

----------------------------------------------------------------------
 danhien_cz - 01-11-06 10:35
----------------------------------------------------------------------
sound cards are:
hw0 pci soundblaster audigi 2
hw1 on board via chipset

Issue History
Date Modified  Username       Field                    Change
======================================================================
01-11-06 10:33 danhien_cz     New Issue
01-11-06 10:33 danhien_cz     Distribution              => GENTOO
01-11-06 10:33 danhien_cz     Kernel Version            => 2.6.12-r9
01-11-06 10:35 danhien_cz     Note Added: 0007560
======================================================================




--__--__--

Message: 8
Date: Wed, 11 Jan 2006 10:51:07 +0100
To: alsa-devel@alsa-project.org
From: bugtrack@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001735]: OSS emulation 4-channel mode
rear channels not working


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1735>
======================================================================
Reported By:                giorby
Assigned To:
======================================================================
Project:                    ALSA - driver
Issue ID:                   1735
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sarge 3.1
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-11-2006 10:51 CET
Last Modified:              01-11-2006 10:51 CET
======================================================================
Summary:                    OSS emulation 4-channel mode rear channels not
working
Description:
If I use the OSS emulation and try to play some 4-channel material, with
say mplayer or bplay, the rear channels are just a copy of the front
channels, whereas the same configuration and software worked perfectly
well with the native OSS driver. As the native OSS drivers are faded out
in favour of ALSA, I assumed that the emulation layer should be a sort of
drop-in replacement. Am I wrong?
Tested with Linux kernels 2.6.12/2.6.15.

======================================================================

Issue History
Date Modified  Username       Field                    Change
======================================================================
01-11-06 10:51 giorby         New Issue
01-11-06 10:51 giorby         Distribution              => Debian sarge 3.1
01-11-06 10:51 giorby         Kernel Version            => 2.6.15
======================================================================




--__--__--

Message: 9
Date: Wed, 11 Jan 2006 11:08:46 +0100
To: alsa-devel@alsa-project.org
From: bugtrack@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001735]: OSS emulation 4-channel mode
rear channels not working


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1735>
======================================================================
Reported By:                giorby
Assigned To:
======================================================================
Project:                    ALSA - driver
Issue ID:                   1735
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sarge 3.1
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-11-2006 10:51 CET
Last Modified:              01-11-2006 11:08 CET
======================================================================
Summary:                    OSS emulation 4-channel mode rear channels not
working
Description:
If I use the OSS emulation and try to play some 4-channel material, with
say mplayer or bplay, the rear channels are just a copy of the front
channels, whereas the same configuration and software worked perfectly
well with the native OSS driver. As the native OSS drivers are faded out
in favour of ALSA, I assumed that the emulation layer should be a sort of
drop-in replacement. Am I wrong?
Tested with Linux kernels 2.6.12/2.6.15.

======================================================================

----------------------------------------------------------------------
 giorby - 01-11-06 11:08
----------------------------------------------------------------------
Sorry, I forgot to identify my soundcard...
/proc/asound/devices lists:
0 [Live           ]: EMU10K1 - SBLive! Value [CT4832]
                     SBLive! Value [CT4832] (rev.6, serial:0x80271102) at
0xd400, irq 5

Issue History
Date Modified  Username       Field                    Change
======================================================================
01-11-06 10:51 giorby         New Issue
01-11-06 10:51 giorby         Distribution              => Debian sarge 3.1
01-11-06 10:51 giorby         Kernel Version            => 2.6.15
01-11-06 11:08 giorby         Note Added: 0007561
======================================================================





--__--__--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


End of Alsa-devel Digest



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
