From: "Gerard Bras" <gerard@akorri.com>
Subject: RE: [Alsa-user] [RFC] Zero-conf ALSA
Date: Mon, 28 Nov 2005 13:47:57 -0500
Message-ID: <82203B41DB693143BF87B02410185DA625096D@kauri.akorri.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



-----Original Message-----
From: alsa-user-admin@lists.sourceforge.net
[mailto:alsa-user-admin@lists.sourceforge.net] On Behalf Of Lee Revell
Sent: Wednesday, November 23, 2005 11:04 PM
To: alsa-devel
Cc: ALSA user list
Subject: [Alsa-user] [RFC] Zero-conf ALSA

I would like to gather a list of the work remaining to be done to
achieve "zero-conf" ALSA.  With the increasing maturity of dmix and
softvol we are very close to this goal, and should be able to provide
basic soundcard functionality that users expect (mixing, volume control,
and OSS emulation) without requiring them to delve into cryptic config
files.

I propose to open a tracking bug in the ALSA BTS to gather all reports
of end users having to modify the config to get a working setup.  AFAICT
the remaining problems are:

  1. Devices which require dmix and/or softvol but are lacking the
required=20
     entries in the /usr/share/alsa/cards/ file.
  2. User-space OSS emulation over dmix requires period and the buffer
sizes=20
     to be set to powers of two.

#1 can only be solved by gathering user reports.

Can #2 be solved by having dmix prefer power of two period/buffer sizes
for the slave hw PCM by default?  AFAICT this should work unless an ALSA
app has opened the device first and set an incompatible buffer size.

Are there currently any other cases where an end user would have to
create a custom ALSA config to enable basic functionality?

Greetings Lee,

In the first category, support for iCE1724 boards is barely functional.
I know they are oddballs with no master gain control, They have some
other oddities/capabilities too, but that's another issue.  I've yet to
see a release of alsa or applications based on it work right with this
board.  Even in the brand, spanny, new SuSE 10.0 it give me errors when
I try to start alsa, though it seems to work just the same. In prior
releases I had to chuck and just use OSS, in spite of all its
limitations, jeust to be able to listen to all those CPs I ripped one by
one.

If there is anything I can do to help straighten this situation out, I'd
be more than happy to do so, but I prorbely need a poiter in the right
direction.  I'm a professional programmer, but sork so many hours these
days that I really haven't had the time  (or the urge) to go diving into
the alsacode by nyself.  And yet I'd rather light a candle than curse
the darkness.

Cheers,
Gerard



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
