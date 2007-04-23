From: "Ben DiDonc" <ben.didonc@gmail.com>
Subject: Re: Fwd: No sound with ATI SB450
Date: Mon, 23 Apr 2007 13:41:27 +1000
Message-ID: <feca60390704222041m15a04b5cj418152756ce5dd67@mail.gmail.com>
References: <feca60390704202156h5a34ef0ao975d8c398dee9473@mail.gmail.com>
	<1177134516.21521.143.camel@razman.gruemaster.com>
	<feca60390704202300hd987409nd6fc8b2ee316c771@mail.gmail.com>
	<1177135815.21521.145.camel@razman.gruemaster.com>
	<feca60390704210129v2180efefl4c94e2e9c80fcaa@mail.gmail.com>
	<feca60390704210327qa3e355di9c07b1f191025345@mail.gmail.com>
	<1177172786.21521.163.camel@razman.gruemaster.com>
	<feca60390704220245o1cd98dd3od5d4bb999f25c71@mail.gmail.com>
	<1177261620.9698.18.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id A855E24347
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 05:41:30 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so1575134anc
	for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2007 20:41:29 -0700 (PDT)
In-Reply-To: <1177261620.9698.18.camel@razman.gruemaster.com>
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
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin,
Some encouraging news when I tried 1.0.14rc2:
This release probes and detects the codec successfully, two lines are added
to syslog after modprob'ing snd-hda-intel:
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
codec_mask = 0x9
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:1764:
hda_codec: model 'toshiba' is selected for config 1179:ff10 (Toshiba)

AND the microphone works. I ran 'arecord test.wav' and played it back
successfully on another machine. However, playback is still not working on
the ATI SB450...
alsa-info.sh output for the rc2 test is at http://pastebin.ca/453663

Not sure whether it helps or not, but here are the lines added to syslog
when I ran arecord (shortened a bit):

//Start of arecord
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x11


//End of a record
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x8, stream=0x0, channel=0, format=0x0

And these are the ones for "aplay test.wav"

//start of aplay
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x11
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11

//End of aplay
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x6, stream=0x0, channel=0, format=0x0
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
ALSA /media/sda3/gilles_files/download/drivers/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0


Is hda_codec_setup_stream meant to be called different times with 4
different nids ?
