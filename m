From: Tanu Kaskinen <tanuk@iki.fi>
Subject: How to redefine "default" to be equivalent to
	"sysdefault"?
Date: Wed, 13 Jun 2012 10:57:34 +0300
Message-ID: <1339574254.2909.15.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1BC542442B
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 09:57:37 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id ADDB320E05
	for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2012 03:57:36 -0400 (EDT)
Received: from [91.153.206.55] (unknown [91.153.206.55])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2506A8E01AF
	for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2012 03:57:36 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a file with the following contents:



# This file an alsa configuration file, used by pasuspender to make the
# "default" Alsa device work while PulseAudio is in suspended state.

# Include the system configuration first. Is there any easier way to do this?
# 14 lines for including one file is a bit much...
@hooks [
        {
                func load
                files [
                        {
                                @func concat
                                strings [
                                        { @func datadir }
                                        "/alsa.conf"
                                ]
                        }
                ]
        }
]

# Redefine "default" to be the same as "sysdefault". On most systems
# "sysdefault" is configured to use dmix.
pcm.!default sysdefault



That doesn't do what I want it to do. When I run

    ALSA_CONFIG_PATH=/path/to/file.conf aplay -Ddefault ~/test.wav

aplay still uses pulseaudio. Using "-Dsysdefault" instead of "-Ddefault"
doesn't use pulseaudio, so "sysdefault" does what it's supposed to do.
The problem is then: why doesn't "default" behave the same way as
"sysdefault"?

What error did I make?

Below is "aplay -L" output with and without setting the environment
variable. When the environment variable is set, "default" is listed
twice, and "null" and "pulse" are included in the list while they are
not included in the list when running aplay without the environment
variable. What causes those differences?



> ALSA_CONFIG_PATH=/path/to/file.conf aplay -L
default
    Playback/recording through the PulseAudio sound server
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    Playback/recording through the PulseAudio sound server
default
    Playback/recording through the PulseAudio sound server
sysdefault:CARD=Intel
    HDA Intel, AD198x Analog
    Default Audio Device
front:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    Front speakers
surround40:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Intel,DEV=0
    HDA Intel, AD198x Digital
    IEC958 (S/PDIF) Digital Audio Output



> aplay -L
default
    Playback/recording through the PulseAudio sound server
sysdefault:CARD=Intel
    HDA Intel, AD198x Analog
    Default Audio Device
front:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    Front speakers
surround40:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Intel,DEV=0
    HDA Intel, AD198x Digital
    IEC958 (S/PDIF) Digital Audio Output

-- 
Tanu
