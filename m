From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: ANNOUNCE: NVIDIA HDMI audio documentation
Date: Sat, 05 Feb 2011 22:05:15 +0200
Message-ID: <4D4DAD7B.20406@iki.fi>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8EA6D@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id D35771037E3
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2011 21:05:22 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8EA6D@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04.02.2011 00:37, Stephen Warren wrote:
> I have written a document re: how to understand and trouble-shoot issues
> with audio-over-HDMI on NVIDIA GPUs. It's available at:
> =

> ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.=
html
> =

> The intent is to provide all the support information I've given various
> people on support forums in a centralized place.
> =

> Hope this helps!

A nice document, thanks :)

A couple of comments:

> Early chipsets (ION an earlier) do not support PD or ELD information. In
> this case, the ALSA driver assumes that a monitor is always attached,
> and supports "basic audio=94 (stereo 16-bit PCM only).

The ALSA driver actually assumes that the monitor supports everything.

> 10.3. Under-Enumeration of Logical Devices

This section misses one patch:
http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dcommitdiff;h=3De6d5dcf1f6=
25984605d362338d71162de45a6c60

> 12.4. Verify Your ELD Is Valid

This section has "44100 48000 88200" multiple times. Maybe one should
mention that those are currently shown incorrectly (as per "[alsa-devel]
HDA - hdmi_show_short_audio_desc puts wrong rates in eld#N"). Maybe also
in chapter 10, though it is a very minor issue (it just affects the
display, not the actual used values).

-- =

Anssi Hannula
