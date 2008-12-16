From: "Mark Jenks" <mjenks1968@gmail.com>
Subject: HDMI problem, more info.
Date: Mon, 15 Dec 2008 18:46:54 -0600
Message-ID: <e5df86c90812151646q4953063cud03e10f5536f883c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id A6D661037F2
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 01:46:56 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so1195689ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 16:46:55 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

More info about the M3n78 Pro motherboard that I am having problems with it
showing properly in 'aplay -L'.

I turned on ./configure -with-debug=verbose

ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x8
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x8
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x2
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x3
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x4
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x5
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x6
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x2
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x3
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x4
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x5
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_intel.c:1469:
azx_pcm_prepare: bufsize=0x4400, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:874:
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x2
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x3
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x4
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x5
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x6
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x2
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x3
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x4
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x5
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x8
ALSA /data2/installs/alsa/temp/alsa-driver/pci/hda/hda_codec.c:887:
hda_codec_cleanup_stream: NID=0x8

# cat /proc/asound/card0/codec#3
Codec: Generic 10de NVIDIA MCP78 HDMI
Address: 3
Vendor Id: 0x10de0002
Subsystem Id: 0x10de0101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x05 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x18560110: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x04
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x07 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560121: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x06
Node 0x08 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x09 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560122: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x2
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x08
Node 0x0a [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x0b [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560123: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x3
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0a
Node 0x0c [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x0d [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560124: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x4
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0c
