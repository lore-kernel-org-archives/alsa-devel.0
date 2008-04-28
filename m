From: "Jan Anders" <angreifen@gmail.com>
Subject: [snd-bt87x] Prolink PixelView PlayTV
Date: Mon, 28 Apr 2008 02:46:34 +0200
Message-ID: <27da43c40804271746h3992cea5rd4626ec6b8776ec3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 756DB244AF
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 02:46:37 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id l27so4270055fgb.44
	for <alsa-devel@alsa-project.org>; Sun, 27 Apr 2008 17:46:35 -0700 (PDT)
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

Hi,

I'd like to report a working device:

 Name: Prolink PixelView PlayTV
 Kernel: 2.6.23
 ID: 0x878-0x00:0x00
 Digital Rate: 128000 (I think)

I can record mono fine with arecord:

 % arecord -D hw:2,1 -f S16_LE -t wav test.wav
 Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
 Warning: rate is not accurate (requested = 8000Hz, got = 119466Hz)
        please, try the plug plugin
 Aborted by signal Interrupt...

When I try to load the module with another sample rate (sudo modprobe
snd- bt87x load_all=1 digital_rate=44100) it still reports "...using
default rate 32000".

Also, I cannot record via the OSS-Layer: zapping hangs when I select
the /dev/dsp device, and
 streamer -C /dev/dsp2 -p 4 -t 0:03 -r 24 -q -o test.avi -j 90 -f
mjpeg -F mono16
only gives an error, but no sound:
 oss: read: Input/output error

Can you give me some hints on how to record video+audio and
determining the correct sample rate?

As I am not subscribed to alsa-devel, I would appreciate a CC of any answers.

Thanks in advance
-Jan
