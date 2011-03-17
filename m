From: =?UTF-8?B?0JzQsNC60YHQuNC8?= <subjucha@gmail.com>
Subject: Destruction of the sound after prolonged output
Date: Thu, 17 Mar 2011 20:59:46 +0300
Message-ID: <AANLkTiktZRu8zeRiSCcOxLtJCa-vQUb0jy40PPc+hHfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c1c10a21641049eb16ff9
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F8AD103815
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 19:00:30 +0100 (CET)
Received: by ewy28 with SMTP id 28so659774ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 11:00:26 -0700 (PDT)
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

--0015174c1c10a21641049eb16ff9
Content-Type: text/plain; charset=ISO-8859-1

Hi,
My name is Max. I've got some problems using ALSA, a certain type of
destruction of sound appears after a prolonged sound output. The destruction
is like "bit crush", stutterings, interruptions, etc. Once started, it no
longer stops. It starts almost always but only after a prolonged sound
output, nearby 24 hours. To reproduce it shurely I use my test wav file and
standard speaker-test utility with following options:
speaker-test -t wav -w test.wav -r 16000
I've attached test.wav to this mail.

To reproduce this I use a fresh minimal installation of Ubuntu 10.10,
command line only, with standard Ubuntu 2.6.35 generic kernel. Minimal
installation is made by installing Ubuntu from an "alternate" version of the
installation CD. It provide option "command line minimal install" that allow
install only base system with command line. So there isn't any desktop
applications like Gnome, Pulseaudio, etc. I've used standard Ubuntu package
of ALSA with version 1.0.23, and also with compiled 1.0.24.

I've tried to reproduce this behavior on Centos and Fedora (both in single
mode, command line only) with Intel HDA chipset, and on Ubuntu with a
Realtek chipset. The results was the same, sound destruction after a day of
sound output.

Above is the output of speaker-test with parameters:
speaker-test -d -c 2 -t wav
Before this command my sound test was used during about 6 hours to reproduce
the sound destruction:
speaker-test -t wav -w test.wav -r 16000



Plug PCM: Linear conversion PCM (S32_LE)
Its setup is:
  stream : PLAYBACK
  access : RW_INTERLEAVED
  format : S16_LE
  subformat : STD
  channels : 2
  rate : 48000
  exact rate : 48000 (48000/1)
  msbits : 16
  buffer_size : 16384
  period_size : 1024
  period_time : 21333
  tstamp_mode : NONE
  period_step : 1
  avail_min : 1024
  period_event : 0
  start_threshold : 16384
  stop_threshold : 16384
  silence_threshold: 0
  silence_size : 0
  boundary : 1073741824
Slave: Soft volume PCM
Control: PCM Playback Volume
min_dB: -51
max_dB: 0
resolution: 256
Its setup is:
  stream : PLAYBACK
  access : MMAP_INTERLEAVED
  format : S32_LE
  subformat : STD
  channels : 2
  rate : 48000
  exact rate : 48000 (48000/1)
  msbits : 32
  buffer_size : 16384
  period_size : 1024
  period_time : 21333
  tstamp_mode : NONE
  period_step : 1
  avail_min : 1024
  period_event : 0
  start_threshold : 16384
  stop_threshold : 16384
  silence_threshold: 0
  silence_size : 0
  boundary : 1073741824
Slave: Direct Stream Mixing PCM
Its setup is:
  stream : PLAYBACK
  access : MMAP_INTERLEAVED
  format : S32_LE
  subformat : STD
  channels : 2
  rate : 48000
  exact rate : 48000 (48000/1)
  msbits : 32
  buffer_size : 16384
  period_size : 1024
  period_time : 21333
  tstamp_mode : NONE
  period_step : 1
  avail_min : 1024
  period_event : 0
  start_threshold : 16384
  stop_threshold : 16384
  silence_threshold: 0
  silence_size : 0
  boundary : 1073741824
Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream : PLAYBACK
  access : MMAP_INTERLEAVED
  format : S32_LE
  subformat : STD
  channels : 2
  rate : 48000
  exact rate : 48000 (48000/1)
  msbits : 32
  buffer_size : 16384
  period_size : 1024
  period_time : 21333
  tstamp_mode : ENABLE
  period_step : 1
  avail_min : 1024
  period_event : 0
  start_threshold : 1
  stop_threshold : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary : 1073741824
  appl_ptr : 0
  hw_ptr : 926558209

--0015174c1c10a21641049eb16ff9
Content-Type: audio/x-wav; name="test.wav"
Content-Disposition: attachment; filename="test.wav"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gldzfhso0

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
dgFXAdkAgAAhANb/KgBDAGEAIgHOAML/GACHAb8B0gC4AN4A/f+y/oP+iP8SAOj/EAAeAOb/d/+x
/nT+mP5N/vr9RP6f/hz/WwDiAKcApQFmAl0B5wDUARAC2AD1/4UAEwHFAFoAmgC9ANH/t/5U/rb+
Gv8j/2L/t/+a/xL/sf6//uP+cf/q/4b/y/+HAEIAFAABAcEBFQEhAEUA8QAJAe4AQAFRAaMA5/+K
/2T/q/+a/zX/Gv++/pb+0/5H/+3/owAAAUYAsv/I/0L/rf4k/18A9gBuALkAEwIcAuIAcQCNAOP/
K//k/sX+Ev8J/8r+v/++AKQAdAA2ALH/Dv/v/kz/kv+fAGsB8ACqACIBUgFaAHz/+/9iAHX/yv5t
/wYAPwBlADcAXgB4AKL/Vv+y/3H/Av+p/nj+xP58//7/BQCqAKIB8wDF/3wAcwHeADcAwgBJAbwA
/v/W/8//ff88/xn/Ov+I/3z/vv8eAN7/v/+y/33/u/8zAIEAawAjADoAQwDT/9z/qAC2ANv/f//Q
/wcAEwCIABoBLQG5APX/V/80/w3/5v5Q/3P/S/9j/3L/9P+WALoAmwBlAEwAOQDs/9j/jQAAAWkA
NgDfABEBfQAMAAkAoP/p/qT+qf4N/4f/sf8nAIoAPADa/3v/Qv9e/3D/s//i/yoABQEmAYkAywBw
Ae8ANwCLAOsAiQC3/3D/4v/y/7T/uf/i//j/ef/v/hb/N/8x/0X/eP++/7z/p/+P/4L/KwC6ADYA
OwAYAQYBeQDGAEsBMAGvAEQAUABVAO//t/+c/4b/gv94/5f/kP9z/2H/CP/s/lD/1/83AE4AowD9
AE8Ag//s/ywAcv88/8n/MgA7AFsACwGJARIBZQACAKj/lP+e/8j/DwDS/2j/Uv+Q/+z/OQBhACUA
2/+p/1j/Ov/x//MADAHJAPIA7gBSAH7/T/+T/0T/5v7o/vb+cP/0/xkAiwDZAG8AEAABAPv/AAAQ
AO7/8v+XAMoAPQBMAO4AtQDF/6v/SAB2AA0A4P9mAGAAlv9B/yz/M/9i/zL/M/96/1j/Uf+y/97/
4v8hABYA4P9+AEEB/wCZAO8AHwGMACUAogD9AIkA7f+v/7L/gP9n/57/5v8rAO3/fP9E/9/+p/7I
/vT+VP/p/z8AXQDQACUBvwAnADAAnABeANf/IgCkAGAAIgCoAA4BzABLANn/V//5/u7+Hf+k//D/
5f/5/+L/sv/B/8b/gf+I/9f/rv9t/7r/rgBfAQUB4wBpAR0BJwDs/zkABwCF/xj/5P4q/3P/gv/3
/3gALgCT/1L/af+o//r/RQCCANUAygAWAJb/8v93ABYAtP9QAKwARwAlAGgAhgA5AMn/lf/B/wAA
4f/C/67/Z/9C/zv/U/+L/7f/q/9X/4H/YgDFAJAABgHBAU8BLAAKAHAABACb/8H/4//n/8f/wf8F
AC8AEAD9//T/tf+d/7H/tf/Y//n/DQAhACwAUQBWAAcA1f/1/+//rP/A/zEAZABbAHoAhABNAPn/
oP99/4P/hv+b/87/9/8TABwAAAAHABsAFAAUABcAMgA3AOP/u/8gAHcAVgA+AH4AgQD9/5v/wP/k
/8T/sf/A/8v/tf+U/57/yf/m/9v/wf/K/+L/9v80AF4AaACaAHYACQAlAIcAcQApADEAVAA3APL/
6P8VAAoAvv+G/3z/ov/C/9H/9P8IAPP/rP93/3n/dP+M/6v/vf8gAHgAVgCAAPsA3gBmAD0AXABi
ADIAHwA7ACEAzv+z/8r/4//v/+L/zf+O/07/XP97/6z//v9HAGcAPQAhACAAzP+N/9j/EwDg/8P/
DQB0AH4AbACmAKkASQD9/+L/0v/T/8f/vv/o//T/3v/W/9z/5v/W/8P/w//o/yQAFQD3/0EAfABD
APz/BQA5ACAAxP/J/wMA2v/D/+L/1P/Y/9//yf/v/zAALwAXAP7/4v/p/wEAEAAqAGUAYwDq/7r/
FwBEABsALQCGAJ0ALgDJ/87/wf+E/3b/h/+t/9j/1//8/y8AEQDi/8P/rv+z/9r/8v/7/ysAZQBd
AEkAkwDCAG8AEwAKABcA7f/a/xYAOwAfAAUA5v/C/7b/lf+F/5L/b/9o/4r/n//v/1kAcQBjAGgA
YQArAPP/BwBQADMAzf/j/0QASAAqAGYAiAAvAMP/lf+X/63/zf/z/ysAIADP/6X/h/+I/7n/1P/a
//j/JQA1ACIAMgCBAJcARQAoAHoAiQAqAPr/BgDt/7j/oP+g/7D/tP+S/4r/wv/x//v/BAAbADkA
KAD0/+n/AAAUAPH/wv8IAF0AMwAiAIsAuQBsAB0AAwD+/+j/xf/G/93/2//S/+L/9P/n/9D/qP92
/2L/eP+k/8z/EgB8ALMAeABfAI4ASQDR/9X/HAAYAPX/DQA/AFAAJAD+/wEA9//W/9L/9v8AAPb/
+f/3//r/AQADAAQABAADAP//+v/5/wEABQABAAEABgAFAP////8DAAMA/v/6//r/+v/7/wAAAwAD
AAIA///7//z///8BAAEAAAACAAMA///+/w==
--0015174c1c10a21641049eb16ff9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174c1c10a21641049eb16ff9--
