From: John Westwood <westwood.1976@gmail.com>
Subject: Problem getting USB DAC to work
Date: Tue, 12 Jul 2016 10:27:40 +0100
Message-ID: <CAM4b-mT0K3N4NdmFCvJHCxb+vCSBb=eCaaNwXvKM0JORe+VrgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 02329265451
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2016 11:27:42 +0200 (CEST)
Received: by mail-lf0-f42.google.com with SMTP id h129so7363533lfh.1
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2016 02:27:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA Developers

I have a problem getting my obscure USB DAC (Starting Point Systems
DAC3) to work in Linux. I believe the problem may be similar to this
one, but am not sure:

https://groups.google.com/forum/#!topic/linux.debian.kernel/HwwkRkbL5aY

If I try to use aplay to play a wav I receive the following error:

aplay -D default test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
aplay: pcm_write:1939: write error: No such device


syslog shows the following:

Jul  9 15:38:31 atlas kernel: [ 4805.148059] usb 7-2: USB disconnect,
device number 19
Jul  9 15:38:32 atlas kernel: [ 4805.532022] usb 7-2: new full-speed
USB device number 20 using uhci_hcd
Jul  9 15:38:32 atlas kernel: [ 4805.725024] usb 7-2: New USB device
found, idVendor=2504, idProduct=0201
Jul  9 15:38:32 atlas kernel: [ 4805.725029] usb 7-2: New USB device
strings: Mfr=1, Product=2, SerialNumber=3
Jul  9 15:38:32 atlas kernel: [ 4805.725032] usb 7-2: Product: TDA
1543 DAC 3 v1.4
Jul  9 15:38:32 atlas kernel: [ 4805.725034] usb 7-2: Manufacturer:
STARTING POINT SYSTEMS
Jul  9 15:38:32 atlas kernel: [ 4805.725035] usb 7-2: SerialNumber:
Jul  9 15:38:32 atlas kernel: [ 4805.745018] usb 7-2: Warning!
Unlikely big volume range (=65535), cval->res is probably wrong.
Jul  9 15:38:32 atlas kernel: [ 4805.745023] usb 7-2: [2] FU [PCM
Playback Volume] ch = 1, val = -32768/32767/1
Jul  9 15:38:32 atlas mtp-probe: checking bus 7, device 20:
"/sys/devices/pci0000:00/0000:00:1d.1/usb7/7-2"
Jul  9 15:38:32 atlas mtp-probe: bus: 7, device: 20 was not an MTP device


I have another USB DAC that works fine, in syslog the working DAC has
the following lines which are not present with the non-working DAC:

Jul 11 19:56:35 atlas kernel: [83940.049124] input: Lakewest Audio
Audiolab M-DAC as
/devices/pci0000:00/0000:00:1d.1/usb7/7-2/7-2:1.0/0003:0451:ADAC.0002/input/input12
Jul 11 19:56:35 atlas kernel: [83940.104367] hid-generic
0003:0451:ADAC.0002:input,hiddev0,hidraw1: USB HID v1.11 Device
[Lakewest Audio Audiolab M-DAC] on usb-0000:00:1d.1-2/input0


With the non-working DAC I get these lines instead:

Jul 11 19:56:25 atlas kernel: [83930.079063] usb 7-2: Warning!
Unlikely big volume range (=65535), cval->res is probably wrong.
Jul 11 19:56:25 atlas kernel: [83930.079067] usb 7-2: [2] FU [PCM
Playback Volume] ch = 1, val = -32768/32767/1

I am using Linux Mint 17.3 64bit, kernel 3.19.0-32. I have also tried
kernel 4.4.0-28 but to no avail. The ALSA version is 1.0.27.2 .

Any help or suggestions would be greatly appreciated. Thanks very much.

Best regards

John Westwood
