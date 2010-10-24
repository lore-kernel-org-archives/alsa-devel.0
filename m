From: Jani Frilander <j.frilander@gmail.com>
Subject: Zoom R16 (USB) again
Date: Sun, 24 Oct 2010 18:56:08 +0300
Message-ID: <AANLkTinaFd7D+O8ALiLPCM5xw8yiuurOMjY5WSLSn=TW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30025852f9b07304935ee9ec
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	by alsa0.perex.cz (Postfix) with ESMTP id E489224381
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Oct 2010 17:56:12 +0200 (CEST)
Received: by wwe15 with SMTP id 15so2636892wwe.25
	for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2010 08:56:08 -0700 (PDT)
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

--20cf30025852f9b07304935ee9ec
Content-Type: text/plain; charset=ISO-8859-1

Hello all,

I've been trying to make Zoom R16 multi track recorder / audio interface /
control surface working with Linux without any success. I've tried this quirk,
but it usually just hang the unit:

{
        /* ZOOM R16 in USB 2.0 mode */
        USB_DEVICE(0x1686, 0x00dd),
        .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_COMPOSITE,
                .data = (const struct snd_usb_audio_quirk[]) {
                        {
                                .ifnum = 0,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = 1,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = 2,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = 3,
                                .type = QUIRK_MIDI_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = -1
                        },
                }
        }
},

This one doesn't freeze it, but it neither works. No sound with playback.

{
        /* ZOOM R16 in USB 2.0 mode */
        USB_DEVICE(0x1686, 0x00dd),
        .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_COMPOSITE,
                .data = (const struct snd_usb_audio_quirk[]) {
                        {
                                .ifnum = 0,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE,
                        },
                        {
                                .ifnum = 1,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = &(const struct audioformat) {
                                        .formats = SNDRV_PCM_FMTBIT_S24_3LE,
                                        .channels = 2,
                                        .iface = 1,
                                        .altsetting = 1,
                                        .altset_idx = 1,
                                        .attributes =
UAC_EP_CS_ATTR_SAMPLE_RATE,
                                        .endpoint = 0x03,
                                        .ep_attr = 0x01,
                                        .maxpacksize = 0x6c,
                                        .rates = SNDRV_PCM_RATE_44100 |
                                                 SNDRV_PCM_RATE_48000 |
                                                 SNDRV_PCM_RATE_88200 |
                                                 SNDRV_PCM_RATE_96000,
                                        .rate_min = 44100,
                                        .rate_max = 96000,
                                        .nr_rates = 4,
                                        .rate_table = (unsigned int[]) {
                                                44100, 48000, 88200, 96000
                                        }
                                }
                        },
                        {
                                .ifnum = 2,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = 3,
                                .type = QUIRK_MIDI_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = -1
                        },
                }
        }
},

I attached the lsusb -v output. There are couple usb snoop logs.

1) The other, not so great OS plays new device found sound @ 96 kHz:
https://sites.google.com/site/zoomr16linux/technical-information/usbsnoop.log.bz2?attredirects=0

2) Short (0.15 sec) .wav @ 44.1 kHz:
https://sites.google.com/site/zoomr16linux/technical-information/usbsnoop2.log.bz2?attredirects=0
https://sites.google.com/site/zoomr16linux/technical-information/short.wav?attredirects=0&d=1

It would be fun to get this device working with Linux. I'd appreciate a lot
if someone could help me out.

Regards,
Jani

--20cf30025852f9b07304935ee9ec
Content-Type: application/octet-stream; name=lsusb
Content-Disposition: attachment; filename=lsusb
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfo3hb210

CkJ1cyAwMDEgRGV2aWNlIDAwODogSUQgMTY4NjowMGRkIFpPT00gQ29ycG9yYXRpb24gCkRldmlj
ZSBEZXNjcmlwdG9yOgogIGJMZW5ndGggICAgICAgICAgICAgICAgMTgKICBiRGVzY3JpcHRvclR5
cGUgICAgICAgICAxCiAgYmNkVVNCICAgICAgICAgICAgICAgMi4wMAogIGJEZXZpY2VDbGFzcyAg
ICAgICAgICAyNTUgVmVuZG9yIFNwZWNpZmljIENsYXNzCiAgYkRldmljZVN1YkNsYXNzICAgICAg
ICAgMCAKICBiRGV2aWNlUHJvdG9jb2wgICAgICAgMjU1IAogIGJNYXhQYWNrZXRTaXplMCAgICAg
ICAgNjQKICBpZFZlbmRvciAgICAgICAgICAgMHgxNjg2IFpPT00gQ29ycG9yYXRpb24KICBpZFBy
b2R1Y3QgICAgICAgICAgMHgwMGRkIAogIGJjZERldmljZSAgICAgICAgICAgIDAuMDIKICBpTWFu
dWZhY3R1cmVyICAgICAgICAgICAxIFpPT00gQ29ycG9yYXRpb24KICBpUHJvZHVjdCAgICAgICAg
ICAgICAgICAyIFIxNgogIGlTZXJpYWwgICAgICAgICAgICAgICAgIDMgMAogIGJOdW1Db25maWd1
cmF0aW9ucyAgICAgIDEKICBDb25maWd1cmF0aW9uIERlc2NyaXB0b3I6CiAgICBiTGVuZ3RoICAg
ICAgICAgICAgICAgICA5CiAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICAyCiAgICB3VG90YWxM
ZW5ndGggICAgICAgICAgMjU5CiAgICBiTnVtSW50ZXJmYWNlcyAgICAgICAgICA0CiAgICBiQ29u
ZmlndXJhdGlvblZhbHVlICAgICAxCiAgICBpQ29uZmlndXJhdGlvbiAgICAgICAgICAwIAogICAg
Ym1BdHRyaWJ1dGVzICAgICAgICAgMHg4MAogICAgICAoQnVzIFBvd2VyZWQpCiAgICBNYXhQb3dl
ciAgICAgICAgICAgICAgNDgwbUEKICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICBiTGVu
Z3RoICAgICAgICAgICAgICAgICA5CiAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAg
ICAgYkludGVyZmFjZU51bWJlciAgICAgICAgMAogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAg
ICAwCiAgICAgIGJOdW1FbmRwb2ludHMgICAgICAgICAgIDAKICAgICAgYkludGVyZmFjZUNsYXNz
ICAgICAgIDI1NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3MKICAgICAgYkludGVyZmFjZVN1YkNsYXNz
ICAgICAgMSAKICAgICAgYkludGVyZmFjZVByb3RvY29sICAgICAgMCAKICAgICAgaUludGVyZmFj
ZSAgICAgICAgICAgICAgMCAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMGIgMjQgMDEgMDAgMDEg
MzUgMDAgMDMgMDEgMDIgMDMKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMGMgMjQgMDIgMDUgMDEg
MDEgMDAgMDIgMDMgMDAgMDAgMDAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMDkgMjQgMDMgMDgg
MDEgMDMgMDAgMDUgMDAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMGMgMjQgMDIgMDkgMDEgMDIg
MDAgMDggMDAgMDAgMDAgMDAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMDkgMjQgMDMgMGMgMDEg
MDEgMDAgMDkgMDAKICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAg
ICAgICAgICAgICA5CiAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYkludGVy
ZmFjZU51bWJlciAgICAgICAgMQogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAwCiAgICAg
IGJOdW1FbmRwb2ludHMgICAgICAgICAgIDAKICAgICAgYkludGVyZmFjZUNsYXNzICAgICAgIDI1
NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3MKICAgICAgYkludGVyZmFjZVN1YkNsYXNzICAgICAgMiAK
ICAgICAgYkludGVyZmFjZVByb3RvY29sICAgICAgMCAKICAgICAgaUludGVyZmFjZSAgICAgICAg
ICAgICAgMCAKICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAgICAg
ICAgICAgICA5CiAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYkludGVyZmFj
ZU51bWJlciAgICAgICAgMQogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAxCiAgICAgIGJO
dW1FbmRwb2ludHMgICAgICAgICAgIDEKICAgICAgYkludGVyZmFjZUNsYXNzICAgICAgIDI1NSBW
ZW5kb3IgU3BlY2lmaWMgQ2xhc3MKICAgICAgYkludGVyZmFjZVN1YkNsYXNzICAgICAgMiAKICAg
ICAgYkludGVyZmFjZVByb3RvY29sICAgICAgMCAKICAgICAgaUludGVyZmFjZSAgICAgICAgICAg
ICAgMCAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMDcgMjQgMDEgMDUgMDEgMDEgMDAKICAgICAg
KiogVU5SRUNPR05JWkVEOiAgMTQgMjQgMDIgMDEgMDIgMDQgMTggMDQgNDQgYWMgMDAgODAgYmIg
MDAgODggNTggMDEgMDAgNzcgMDEKICAgICAgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICBi
TGVuZ3RoICAgICAgICAgICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAg
NQogICAgICAgIGJFbmRwb2ludEFkZHJlc3MgICAgIDB4MDMgIEVQIDMgT1VUCiAgICAgICAgYm1B
dHRyaWJ1dGVzICAgICAgICAgICAgOQogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAgICAg
IElzb2Nocm9ub3VzCiAgICAgICAgICBTeW5jaCBUeXBlICAgICAgICAgICAgICAgQWRhcHRpdmUK
ICAgICAgICAgIFVzYWdlIFR5cGUgICAgICAgICAgICAgICBEYXRhCiAgICAgICAgd01heFBhY2tl
dFNpemUgICAgIDB4MDA2YyAgMXggMTA4IGJ5dGVzCiAgICAgICAgYkludGVydmFsICAgICAgICAg
ICAgICAgMQogICAgSW50ZXJmYWNlIERlc2NyaXB0b3I6CiAgICAgIGJMZW5ndGggICAgICAgICAg
ICAgICAgIDkKICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNAogICAgICBiSW50ZXJmYWNl
TnVtYmVyICAgICAgICAyCiAgICAgIGJBbHRlcm5hdGVTZXR0aW5nICAgICAgIDAKICAgICAgYk51
bUVuZHBvaW50cyAgICAgICAgICAgMAogICAgICBiSW50ZXJmYWNlQ2xhc3MgICAgICAgMjU1IFZl
bmRvciBTcGVjaWZpYyBDbGFzcwogICAgICBiSW50ZXJmYWNlU3ViQ2xhc3MgICAgICAyIAogICAg
ICBiSW50ZXJmYWNlUHJvdG9jb2wgICAgICAwIAogICAgICBpSW50ZXJmYWNlICAgICAgICAgICAg
ICAwIAogICAgSW50ZXJmYWNlIERlc2NyaXB0b3I6CiAgICAgIGJMZW5ndGggICAgICAgICAgICAg
ICAgIDkKICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNAogICAgICBiSW50ZXJmYWNlTnVt
YmVyICAgICAgICAyCiAgICAgIGJBbHRlcm5hdGVTZXR0aW5nICAgICAgIDEKICAgICAgYk51bUVu
ZHBvaW50cyAgICAgICAgICAgMQogICAgICBiSW50ZXJmYWNlQ2xhc3MgICAgICAgMjU1IFZlbmRv
ciBTcGVjaWZpYyBDbGFzcwogICAgICBiSW50ZXJmYWNlU3ViQ2xhc3MgICAgICAyIAogICAgICBi
SW50ZXJmYWNlUHJvdG9jb2wgICAgICAwIAogICAgICBpSW50ZXJmYWNlICAgICAgICAgICAgICAw
IAogICAgICAqKiBVTlJFQ09HTklaRUQ6ICAwNyAyNCAwMSAwYyAwMSAwMSAwMAogICAgICAqKiBV
TlJFQ09HTklaRUQ6ICAxNCAyNCAwMiAwMSAwOCAwNCAxOCAwNCA0NCBhYyAwMCA4MCBiYiAwMCA4
OCA1OCAwMSAwMCA3NyAwMQogICAgICBFbmRwb2ludCBEZXNjcmlwdG9yOgogICAgICAgIGJMZW5n
dGggICAgICAgICAgICAgICAgIDcKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA1CiAg
ICAgICAgYkVuZHBvaW50QWRkcmVzcyAgICAgMHg4NCAgRVAgNCBJTgogICAgICAgIGJtQXR0cmli
dXRlcyAgICAgICAgICAgMTMKICAgICAgICAgIFRyYW5zZmVyIFR5cGUgICAgICAgICAgICBJc29j
aHJvbm91cwogICAgICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICAgIFN5bmNocm9ub3VzCiAg
ICAgICAgICBVc2FnZSBUeXBlICAgICAgICAgICAgICAgRGF0YQogICAgICAgIHdNYXhQYWNrZXRT
aXplICAgICAweDAxYTAgIDF4IDQxNiBieXRlcwogICAgICAgIGJJbnRlcnZhbCAgICAgICAgICAg
ICAgIDEKICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAgICAgICAg
ICAgICA5CiAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYkludGVyZmFjZU51
bWJlciAgICAgICAgMwogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAwCiAgICAgIGJOdW1F
bmRwb2ludHMgICAgICAgICAgIDIKICAgICAgYkludGVyZmFjZUNsYXNzICAgICAgIDI1NSBWZW5k
b3IgU3BlY2lmaWMgQ2xhc3MKICAgICAgYkludGVyZmFjZVN1YkNsYXNzICAgICAgMyAKICAgICAg
YkludGVyZmFjZVByb3RvY29sICAgICAgMCAKICAgICAgaUludGVyZmFjZSAgICAgICAgICAgICAg
MCAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMDcgMjQgMDEgMDAgMDEgNDEgMDAKICAgICAgKiog
VU5SRUNPR05JWkVEOiAgMDYgMjQgMDIgMDEgMDEgMDAKICAgICAgKiogVU5SRUNPR05JWkVEOiAg
MDYgMjQgMDIgMDIgMDIgMDAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMDkgMjQgMDMgMDEgMDMg
MDEgMDIgMDEgMDAKICAgICAgKiogVU5SRUNPR05JWkVEOiAgMDkgMjQgMDMgMDIgMDQgMDEgMDEg
MDEgMDAKICAgICAgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICBiTGVuZ3RoICAgICAgICAg
ICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNQogICAgICAgIGJFbmRw
b2ludEFkZHJlc3MgICAgIDB4MDEgIEVQIDEgT1VUCiAgICAgICAgYm1BdHRyaWJ1dGVzICAgICAg
ICAgICAgMgogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAgICAgIEJ1bGsKICAgICAgICAg
IFN5bmNoIFR5cGUgICAgICAgICAgICAgICBOb25lCiAgICAgICAgICBVc2FnZSBUeXBlICAgICAg
ICAgICAgICAgRGF0YQogICAgICAgIHdNYXhQYWNrZXRTaXplICAgICAweDAwNDAgIDF4IDY0IGJ5
dGVzCiAgICAgICAgYkludGVydmFsICAgICAgICAgICAgICAgMAogICAgICBFbmRwb2ludCBEZXNj
cmlwdG9yOgogICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDcKICAgICAgICBiRGVzY3Jp
cHRvclR5cGUgICAgICAgICA1CiAgICAgICAgYkVuZHBvaW50QWRkcmVzcyAgICAgMHg4MiAgRVAg
MiBJTgogICAgICAgIGJtQXR0cmlidXRlcyAgICAgICAgICAgIDIKICAgICAgICAgIFRyYW5zZmVy
IFR5cGUgICAgICAgICAgICBCdWxrCiAgICAgICAgICBTeW5jaCBUeXBlICAgICAgICAgICAgICAg
Tm9uZQogICAgICAgICAgVXNhZ2UgVHlwZSAgICAgICAgICAgICAgIERhdGEKICAgICAgICB3TWF4
UGFja2V0U2l6ZSAgICAgMHgwMDQwICAxeCA2NCBieXRlcwogICAgICAgIGJJbnRlcnZhbCAgICAg
ICAgICAgICAgIDAKRGV2aWNlIFF1YWxpZmllciAoZm9yIG90aGVyIGRldmljZSBzcGVlZCk6CiAg
Ykxlbmd0aCAgICAgICAgICAgICAgICAxMAogIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDYKICBi
Y2RVU0IgICAgICAgICAgICAgICAyLjAwCiAgYkRldmljZUNsYXNzICAgICAgICAgIDI1NSBWZW5k
b3IgU3BlY2lmaWMgQ2xhc3MKICBiRGV2aWNlU3ViQ2xhc3MgICAgICAgICAwIAogIGJEZXZpY2VQ
cm90b2NvbCAgICAgICAyNTUgCiAgYk1heFBhY2tldFNpemUwICAgICAgICA2NAogIGJOdW1Db25m
aWd1cmF0aW9ucyAgICAgIDEKRGV2aWNlIFN0YXR1czogICAgIDB4MDAwMQogIFNlbGYgUG93ZXJl
ZAo=
--20cf30025852f9b07304935ee9ec
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--20cf30025852f9b07304935ee9ec--
