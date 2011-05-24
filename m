From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA - HDA - Add period time constraint to
	hda-intel
Date: Tue, 24 May 2011 12:15:05 +0800
Message-ID: <BANLkTimy_SFEFfTx55wFNdQmNPbDiguFdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151747bddc3156d204a3fdd5db
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 045FC103821
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 06:15:06 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4919709fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2011 21:15:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--00151747bddc3156d204a3fdd5db
Content-Type: text/plain; charset=ISO-8859-1

As there is a 10 seconds schedule_timeout in alsa-kernel

The following error occur when aplay/arecord using a period time
longer than 10 seconds for for those hda codec which support rate
lower than 32000 when prealloc = 4096

ALSA hda_intel.c:1680: azx_pcm_prepare: bufsize=0x1aeb00, format=0x4111
...
ALSA pcm_native.c:1531: playback drain error (DMA or IRQ trouble?)


aplay -v -Dhw:1 --period-time=10001000 22050.wav
Playing WAVE '22050.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 22050
  exact rate   : 22050 (22050/1)
  msbits       : 16
  buffer_size  : 441024
  period_size  : 220512
  period_time  : 10000544
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 220512
  period_event : 0
  start_threshold  : 441024
  stop_threshold   : 441024
  silence_threshold: 0
  silence_size : 0
  boundary     : 1806434304
  appl_ptr     : 0
  hw_ptr       : 0


ALSA hda_intel.c:1680: azx_pcm_prepare: bufsize=0x9c500, format=0x511
ALSA hda_codec.c:1295: hda_codec_setup_stream: NID=0x8, stream=0x1,
channel=0, format=0x511
ALSA pcm_lib.c:1789: capture write error (DMA or IRQ trouble?)

arecord -Dhw:1  -v --period-time=10005000 -r 8000 -c2 -f S16_LE /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 160064
  period_size  : 80032
  period_time  : 10004000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 80032
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 160064
  silence_threshold: 0
  silence_size : 0
  boundary     : 1311244288
  appl_ptr     : 0
  hw_ptr       : 0
arecord: pcm_read:1773: read error: Input/output error

--00151747bddc3156d204a3fdd5db
Content-Type: application/octet-stream;
	name="0001-Add-period-time-constraint-to-hda-intel.patch"
Content-Disposition: attachment;
	filename="0001-Add-period-time-constraint-to-hda-intel.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_go2bodkk0

RnJvbSA3ZGI4OGFiMDhjOTY5MGY5MmEyZmUwM2ExZTNjOTc3NjdlNzRmMTdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDI0IE1heSAyMDExIDEwOjIwOjE3ICswODAwClN1YmplY3Q6IFtQQVRD
SCBBTFNBIC0gSERBIC0gQWRkIHBlcmlvZCB0aW1lIGNvbnN0cmFpbnQgdG8gaGRhLWludGVsCgpB
cyB0aGVyZSBpcyBhIDEwIHNlY29uZHMgc2NoZWR1bGVfdGltZW91dCBpbiBhbHNhLWtlcm5lbAoK
QUxTQSBoZGFfaW50ZWwuYzoxNjgwOiBhenhfcGNtX3ByZXBhcmU6IGJ1ZnNpemU9MHgxYWViMDAs
IGZvcm1hdD0weDQxMTEKLi4uCkFMU0EgcGNtX25hdGl2ZS5jOjE1MzE6IHBsYXliYWNrIGRyYWlu
IGVycm9yIChETUEgb3IgSVJRIHRyb3VibGU/KQoKb2NjdXIgd2hlbiBhcHBsaWNhdGlvbiB1c2lu
ZyBhIHBlcmlvZCB0aW1lIGxvbmdlciB0aGFuIDEwIHNlY29uZHMgZm9yIGZvciB0aG9zZSBoZGEg
Y29kZWMgd2hpY2ggc3VwcG9ydCByYXRlIGxvd2VyIHRoYW4gMzIwMDAgd2hlbiBwcmVhbGxvYyA9
IDQwOTYKCmFwbGF5IC12IC1EaHc6MSAtLXBlcmlvZC10aW1lPTEwMDAxMDAwIDIyMDUwLndhdgpQ
bGF5aW5nIFdBVkUgJzIyMDUwLndhdicgOiBTaWduZWQgMTYgYml0IExpdHRsZSBFbmRpYW4sIFJh
dGUgMjIwNTAgSHosIFN0ZXJlbwpIYXJkd2FyZSBQQ00gY2FyZCAxICdIREEgSW50ZWwnIGRldmlj
ZSAwIHN1YmRldmljZSAwCkl0cyBzZXR1cCBpczoKICBzdHJlYW0gICAgICAgOiBQTEFZQkFDSwog
IGFjY2VzcyAgICAgICA6IFJXX0lOVEVSTEVBVkVECiAgZm9ybWF0ICAgICAgIDogUzE2X0xFCiAg
c3ViZm9ybWF0ICAgIDogU1RECiAgY2hhbm5lbHMgICAgIDogMgogIHJhdGUgICAgICAgICA6IDIy
MDUwCiAgZXhhY3QgcmF0ZSAgIDogMjIwNTAgKDIyMDUwLzEpCiAgbXNiaXRzICAgICAgIDogMTYK
ICBidWZmZXJfc2l6ZSAgOiA0NDEwMjQKICBwZXJpb2Rfc2l6ZSAgOiAyMjA1MTIKICBwZXJpb2Rf
dGltZSAgOiAxMDAwMDU0NAogIHRzdGFtcF9tb2RlICA6IE5PTkUKICBwZXJpb2Rfc3RlcCAgOiAx
CiAgYXZhaWxfbWluICAgIDogMjIwNTEyCiAgcGVyaW9kX2V2ZW50IDogMAogIHN0YXJ0X3RocmVz
aG9sZCAgOiA0NDEwMjQKICBzdG9wX3RocmVzaG9sZCAgIDogNDQxMDI0CiAgc2lsZW5jZV90aHJl
c2hvbGQ6IDAKICBzaWxlbmNlX3NpemUgOiAwCiAgYm91bmRhcnkgICAgIDogMTgwNjQzNDMwNAog
IGFwcGxfcHRyICAgICA6IDAKICBod19wdHIgICAgICAgOiAwCgoKQUxTQSBoZGFfaW50ZWwuYzox
NjgwOiBhenhfcGNtX3ByZXBhcmU6IGJ1ZnNpemU9MHg5YzUwMCwgZm9ybWF0PTB4NTExCkFMU0Eg
aGRhX2NvZGVjLmM6MTI5NTogaGRhX2NvZGVjX3NldHVwX3N0cmVhbTogTklEPTB4OCwgc3RyZWFt
PTB4MSwgY2hhbm5lbD0wLCBmb3JtYXQ9MHg1MTEKQUxTQSBwY21fbGliLmM6MTc4OTogY2FwdHVy
ZSB3cml0ZSBlcnJvciAoRE1BIG9yIElSUSB0cm91YmxlPykKCmFyZWNvcmQgLURodzoxICAtdiAt
LXBlcmlvZC10aW1lPTEwMDA1MDAwIC1yIDgwMDAgLWMyIC1mIFMxNl9MRSAvZGV2L251bGwKUmVj
b3JkaW5nIFdBVkUgJy9kZXYvbnVsbCcgOiBTaWduZWQgMTYgYml0IExpdHRsZSBFbmRpYW4sIFJh
dGUgODAwMCBIeiwgU3RlcmVvCkhhcmR3YXJlIFBDTSBjYXJkIDEgJ0hEQSBJbnRlbCcgZGV2aWNl
IDAgc3ViZGV2aWNlIDAKSXRzIHNldHVwIGlzOgogIHN0cmVhbSAgICAgICA6IENBUFRVUkUKICBh
Y2Nlc3MgICAgICAgOiBSV19JTlRFUkxFQVZFRAogIGZvcm1hdCAgICAgICA6IFMxNl9MRQogIHN1
YmZvcm1hdCAgICA6IFNURAogIGNoYW5uZWxzICAgICA6IDIKICByYXRlICAgICAgICAgOiA4MDAw
CiAgZXhhY3QgcmF0ZSAgIDogODAwMCAoODAwMC8xKQogIG1zYml0cyAgICAgICA6IDE2CiAgYnVm
ZmVyX3NpemUgIDogMTYwMDY0CiAgcGVyaW9kX3NpemUgIDogODAwMzIKICBwZXJpb2RfdGltZSAg
OiAxMDAwNDAwMAogIHRzdGFtcF9tb2RlICA6IE5PTkUKICBwZXJpb2Rfc3RlcCAgOiAxCiAgYXZh
aWxfbWluICAgIDogODAwMzIKICBwZXJpb2RfZXZlbnQgOiAwCiAgc3RhcnRfdGhyZXNob2xkICA6
IDEKICBzdG9wX3RocmVzaG9sZCAgIDogMTYwMDY0CiAgc2lsZW5jZV90aHJlc2hvbGQ6IDAKICBz
aWxlbmNlX3NpemUgOiAwCiAgYm91bmRhcnkgICAgIDogMTMxMTI0NDI4OAogIGFwcGxfcHRyICAg
ICA6IDAKICBod19wdHIgICAgICAgOiAwCmFyZWNvcmQ6IHBjbV9yZWFkOjE3NzM6IHJlYWQgZXJy
b3I6IElucHV0L291dHB1dCBlcnJvcgoKCgpTaWduZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3Vw
ZXJxdWFkLnZvcnRleDJAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRh
X2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDQzYTAzNjcuLjc2ODJi
YzAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNp
L2hkYS9oZGFfaW50ZWwuYwpAQCAtMTU4Nyw2ICsxNTg3LDggQEAgc3RhdGljIGludCBhenhfcGNt
X29wZW4oc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pCiAJCQkJICAgMTI4KTsK
IAlzbmRfcGNtX2h3X2NvbnN0cmFpbnRfc3RlcChydW50aW1lLCAwLCBTTkRSVl9QQ01fSFdfUEFS
QU1fUEVSSU9EX0JZVEVTLAogCQkJCSAgIDEyOCk7CisJc25kX3BjbV9od19jb25zdHJhaW50X21p
bm1heAorCQkocnVudGltZSwgU05EUlZfUENNX0hXX1BBUkFNX1BFUklPRF9USU1FLCAxNjYsIDEw
MDAwMDAwKTsKIAlzbmRfaGRhX3Bvd2VyX3VwKGFwY20tPmNvZGVjKTsKIAllcnIgPSBoaW5mby0+
b3BzLm9wZW4oaGluZm8sIGFwY20tPmNvZGVjLCBzdWJzdHJlYW0pOwogCWlmIChlcnIgPCAwKSB7
Ci0tIAoxLjYuMC42Cgo=
--00151747bddc3156d204a3fdd5db
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00151747bddc3156d204a3fdd5db--
