From: "Kogan, Dan D" <dan.d.kogan@intel.com>
Subject: RE: Announcing Linux driver for High-definition (aka Azalia) audio
Date: Thu, 8 Jul 2004 10:57:40 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <B80241C0CEF2E948AEB4C7EBC775282F075EB26D@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Greetings all,

I would like to announce the initial posting of a driver for Intel's
High-Definition audio (formerly known as Azalia) to the ALSA community.

The driver implements a limited set of features and is intended to be a
starting point into which additional functionality can be incorporated.
Specifically, the following are implemented:

*	Stereo playback=20
*	Line in stereo capture
*	Mixer control for stereo output: master left, master right and
mute
*	Mixer control for line in: setting stereo record level and mute
*	2 channel, 16 bit, 44/48 kHz native frequency,=20
	  other frequencies through SW rate conversion=20
	  from ALSA middle layer
*	1 stream

The design is intended to support all codecs compliant with the
High-Definition Audio architecture.  At initialization, the driver
enumerates the codecs in a board and then discovers the codecs' internal
topology when playing or capturing an audio stream.  This work is still
in progress and we plan to add more features as we progress.

The following software configurations have been tested:

*	Distributions: Red Hat 9.0, Suse 9.1
*	Kernels: 2.6.3, 2.6.4, 2.6.6, & 2.6.7
*	ALSA: 1.0.3, 1.0.5rc1

The driver has been tested with the following codecs:

*	Realtek ALC860-414S
*	Realtek ALC880-414E
*	Realtek ALC260-403
*	Realtek ALC880

Known issues relating to this drop include: =20

*	Sound artifacts experienced whenever OSS emulation=20
	based applications are used.
*	Artifacts are also present when volume level approaches maximum.
*	The driver does not currently restrict playback or capture to=20
	a specific jack.  As a result, input or output may be=20
	passing through an untraditional jack color,=20
	i.e. capture entering through green jack and capture exiting=20
	through pink jack.

Instructions for building and installing the driver are included in the
tar ball, in the BUILD-CONFIG text file.  The readme.txt file (also in
the tarball) provides a brief overview of the code structure.

Please find the tarball at=20
ftp://ftp.alsa-project.org/pub/tests/azx-alsa-idbo-driver-1.1.2a.tgz
http://www.alsa-project.org/alsa/ftp/tests/azx-alsa-idbo-driver-1.1.2a.t
gz

I should point out that none of the team members are ALSA experts, so
it's quite possible that the design and implementation of the driver do
not take best advantage of the ALSA architecture and infrastructure.  In
that respect, we look to the community to help us identify such
shortcomings.

Best regards,

Dan Kogan
Intel Corp.
Desktop Products Group
Hillsboro, OR=20



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
