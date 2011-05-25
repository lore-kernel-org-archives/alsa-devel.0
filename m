From: Stephen Warren <swarren@nvidia.com>
Subject: EDID-like data for audio: Port correlation between
	ALSA and X
Date: Wed, 25 May 2011 14:16:27 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A4855E@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 30FDE1037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 23:16:35 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "xorg@lists.freedesktop.org" <xorg@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pulseaudio-discuss@mail.0pointer.de" <pulseaudio-discuss@mail.0>
Cc: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "pl bossart (bossart.nospam@gmail.com)" <bossart.nospam@gmail.com>, "David Henningsson
	(david.henningsson@canonical.com)" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

(starting a new cross-mailing-list thread following some small
discussion on this topic on alsa-devel)

Background:

Many recent graphics cards support sending an audio stream over HDMI or
DisplayPort. This is supported by an HD-audio controller built into the
graphics card.

It'd be nice if configuration tools could easily determine which ALSA
devices correspond to which X displays.

Current implementation details:

The X driver reads the EDID from the display, reformats it as an ELD
("EDID-Like Data"), as specified by the Intel HD-audio specification,
and somehow communicates this into the HD-audio controller that's
embedded into the graphics card, using a card-specific mechanism.

The HD-audio controller then communicates the ELD to the driver in a
standard-specified manner: The HW triggers an "unsolicited response" to
notify the ALSA driver of a change in the data, and then the ALSA driver
reads the ELD data using HD-audio commands (verbs).

Finally, the eventual idea is that user-space applications will be able
to read the ELD data from the ALSA driver for each PCM.

In the HD-audio controller, there is a "pin widget" for each video output
(HDMI port, DP port). ELD data is associated with a specific pin widget.
ALSA creates a single "PCM" or audio device per pin widget.

New discussion:

We need some way of tying pin widgets or ALSA PCMs to the X display path
that the audio data will be merged into.

Option A:

We can pass some X-specific data in the ELD.

The ELD contains an 8-byte Port_ID field for this purpose. The display
driver is supposed to fill this with some meaningful data, and ALSA (or
an application) is supposed to interpret the field. Some possibilities
for this field are:

A1) An XRandR property, such as ConnectorNumber or Output.

To me, this seems the simplest option overall; the X driver already has
access to this information, so it should be fairly easy to place it into
the ELD.

The only downside here is that the NVIDIA binary driver doesn't currently
implement recent XRandR versions, so we probably couldn't do this right
now.

A2) NVIDIA's graphics driver fills this field with an internal "display
ID" value, which I believe is usable without our NV-CTRL X extension.

This obviously isn't ideal for applications interpreting this data,
since the format isn't cross-vendor. Applications don't want to interpret
the ELD in N different ways.

Option B:

We can invent some X/XRandR property that refers to some ALSA HW or
SW property. Applications can then enumerate this X/XRandR property for
all outputs, and use that data to access the appropriate ALSA device.
That data could be:

B1) ALSA PCM name (e.g. "hw:1,3").

While perhaps technically feasible, it'd be pretty painful to determine
this from the X driver. Sysfs parsing of ALSA-related data would probably
work, but this kind of thing would be better done elsewhere than the X
driver, especially if the ELD handoff is implemented in the kernel by a
KMS driver.

B2) HD-audio controller pin widget ID.

This requires the X driver to know the internal architecture of the
HD-audio controller. While technically perhaps not too hard, it'd most
likely mean maintaining tables of audio-related data in the X driver,
which is probably not something we'd want to do.

Equally, the pin widget ID might not be the most useful thing to an
application. AFAIK, ALSA doesn't have an API for exposing this
information at present, except through user-oriented debug files in
/proc.


Does anyone see any other options? Do people agree that option A1 is the best?


Related issues:

There are issues correlating ALSA and X data such as XRandR connector
numbers in the face of multiple X servers, remote X servers, VT-switching,
etc. However, I believe most of these issues need to be solved outside the
context of this discussion anyway, and hence probably don't affect this
discussion much. Probably, PulseAudio already interfaces with DeviceKit
or SomethingKit to solve some of these issues?

Thanks for reading!

-- 
nvpublic
