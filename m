From: carlo beccaria <becks@stepdev.org>
Subject: roland synth sh-201
Date: Thu, 28 Jun 2007 09:36:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706280925250.11146@debian>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2123443277-1182965650=:11146"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rubycon.it (rubycon.it [69.60.121.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BA3F243AD
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 10:52:26 +0200 (CEST)
Received: from localhost (becks@debian [127.0.0.1])
	by rubycon.it (8.13.8/8.13.8/Debian-2) with ESMTP id l5S7a9S0012379
	for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2007 09:36:09 +0200
Content-ID: <Pine.LNX.4.64.0706271950391.11146@debian>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2123443277-1182965650=:11146
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.64.0706271950392.11146@debian>



hi all, 
with this change in usbquirks.h , i can use my synth roland sh-201

{
   /* Roland SH-201 */
   USB_DEVICE(0x0582, 0x00ad),
   .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
     .vendor_name = "Roland",
     .product_name = "SH-201",
     .ifnum = QUIRK_ANY_INTERFACE,
     .type = QUIRK_COMPOSITE,
     .data = (const struct snd_usb_audio_quirk[]) {
       {
         .ifnum = 0,
         .type = QUIRK_AUDIO_FIXED_ENDPOINT,
         .data = & (const struct audioformat) {
           .format = SNDRV_PCM_FORMAT_S24_3LE,
           .channels = 2,
           .iface = 0,
           .altsetting = 1,
           .altset_idx = 1,
           .attributes = 0,
           .endpoint = 0x01,
           .ep_attr = 0x01,
           .rates = SNDRV_PCM_RATE_CONTINUOUS,
           .rate_min = 44100,
           .rate_max = 44100,
         }
       },
       {
         .ifnum = 1,
         .type = QUIRK_AUDIO_FIXED_ENDPOINT,
         .data = & (const struct audioformat) {
           .format = SNDRV_PCM_FORMAT_S24_3LE,
           .channels = 2,
           .iface = 1,
           .altsetting = 1,
           .altset_idx = 1,
           .attributes = 0,
           .endpoint = 0x81,
           .ep_attr = 0x01,
           .rates = SNDRV_PCM_RATE_CONTINUOUS,
           .rate_min = 44100,
           .rate_max = 44100,
         }
       },
       {
         .ifnum = 2,
         .type = QUIRK_MIDI_FIXED_ENDPOINT,
         .data = & (const struct snd_usb_midi_endpoint_info) {
           .out_cables = 0x0007,
           .in_cables  = 0x0007
         }
       },
       {
         .ifnum = -1
       }
     }
   }
},


my kernel is 2.6.21.5-rt17, (plus preempt patch) and i use debian testing
the hardware seem to be very similar to Roland SC-D70 (windows .inf file 
are very similar)

this is the device id
Bus 001 Device 003: ID 0582:00ad Roland Corp.

in attach you can see the lsusb (verbose) output

becks@vaix:~$ amidi -l
Dir Device    Name
IO  hw:1,0,0  SH-201 MIDI 1
IO  hw:1,0,1  SH-201 MIDI 2
IO  hw:1,0,2  SH-201 MIDI 3

muse works fine with jack and midi output

becks@vaix:~$ aseqdump -p 20:0
Waiting for data. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__
  20:0   Note on                 1  52  17
  20:0   Note off                1  52  55

also midi-in works

becks@vaix:~$ cat /proc/asound/cards
  0 [A5451          ]: ALI5451 - ALI 5451
                       ALI 5451 at 0x8400, irq 9
  1 [SH201          ]: USB-Audio - SH-201
                       Roland SH-201 at usb-0000:00:0c.0-1, full speed

when i use my synth like a sound card, it don't work, i don't know exactly why
(if is a patch problem, or rate/format)

becks@vaix:~$ aplay  -D hw:1,0 /usr/share/sounds/KDE_Window_UnSticky.wav
Playing WAVE '/usr/share/sounds/KDE_Window_UnSticky.wav' : Signed 16 bit Little 
Endian, Rate 22050 Hz, Mono
aplay: set_params:904: Sample format non available

let me know if you need more info
thanks

--
carlo beccaria
--8323328-2123443277-1182965650=:11146
Content-Type: TEXT/plain; charset=US-ASCII; name=sh201.txt
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0706280936090.11146@debian>
Content-Description: 
Content-Disposition: attachment; filename=sh201.txt

QnVzIDAwMSBEZXZpY2UgMDAzOiBJRCAwNTgyOjAwYWQgUm9sYW5kIENvcnAu
IA0KRGV2aWNlIERlc2NyaXB0b3I6DQogIGJMZW5ndGggICAgICAgICAgICAg
ICAgMTgNCiAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgMQ0KICBiY2RVU0Ig
ICAgICAgICAgICAgICAxLjEwDQogIGJEZXZpY2VDbGFzcyAgICAgICAgICAy
NTUgVmVuZG9yIFNwZWNpZmljIENsYXNzDQogIGJEZXZpY2VTdWJDbGFzcyAg
ICAgICAgIDAgDQogIGJEZXZpY2VQcm90b2NvbCAgICAgICAyNTUgDQogIGJN
YXhQYWNrZXRTaXplMCAgICAgICAgIDgNCiAgaWRWZW5kb3IgICAgICAgICAg
IDB4MDU4MiBSb2xhbmQgQ29ycC4NCiAgaWRQcm9kdWN0ICAgICAgICAgIDB4
MDBhZCANCiAgYmNkRGV2aWNlICAgICAgICAgICAgMS4wMA0KICBpTWFudWZh
Y3R1cmVyICAgICAgICAgICAxIFJvbGFuZA0KICBpUHJvZHVjdCAgICAgICAg
ICAgICAgICAyIFNILTIwMQ0KICBpU2VyaWFsICAgICAgICAgICAgICAgICAw
IA0KICBiTnVtQ29uZmlndXJhdGlvbnMgICAgICAxDQogIENvbmZpZ3VyYXRp
b24gRGVzY3JpcHRvcjoNCiAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5
DQogICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgMg0KICAgIHdUb3RhbExl
bmd0aCAgICAgICAgICAxNjENCiAgICBiTnVtSW50ZXJmYWNlcyAgICAgICAg
ICAzDQogICAgYkNvbmZpZ3VyYXRpb25WYWx1ZSAgICAgMQ0KICAgIGlDb25m
aWd1cmF0aW9uICAgICAgICAgIDAgDQogICAgYm1BdHRyaWJ1dGVzICAgICAg
ICAgMHhjMA0KICAgICAgU2VsZiBQb3dlcmVkDQogICAgTWF4UG93ZXIgICAg
ICAgICAgICAgICAgMG1BDQogICAgSW50ZXJmYWNlIERlc2NyaXB0b3I6DQog
ICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5DQogICAgICBiRGVzY3Jp
cHRvclR5cGUgICAgICAgICA0DQogICAgICBiSW50ZXJmYWNlTnVtYmVyICAg
ICAgICAwDQogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAwDQogICAg
ICBiTnVtRW5kcG9pbnRzICAgICAgICAgICAwDQogICAgICBiSW50ZXJmYWNl
Q2xhc3MgICAgICAgMjU1IFZlbmRvciBTcGVjaWZpYyBDbGFzcw0KICAgICAg
YkludGVyZmFjZVN1YkNsYXNzICAgICAgMiANCiAgICAgIGJJbnRlcmZhY2VQ
cm90b2NvbCAgICAgIDIgDQogICAgICBpSW50ZXJmYWNlICAgICAgICAgICAg
ICAwIA0KICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOg0KICAgICAgYkxlbmd0
aCAgICAgICAgICAgICAgICAgOQ0KICAgICAgYkRlc2NyaXB0b3JUeXBlICAg
ICAgICAgNA0KICAgICAgYkludGVyZmFjZU51bWJlciAgICAgICAgMA0KICAg
ICAgYkFsdGVybmF0ZVNldHRpbmcgICAgICAgMQ0KICAgICAgYk51bUVuZHBv
aW50cyAgICAgICAgICAgMQ0KICAgICAgYkludGVyZmFjZUNsYXNzICAgICAg
IDI1NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3MNCiAgICAgIGJJbnRlcmZhY2VT
dWJDbGFzcyAgICAgIDIgDQogICAgICBiSW50ZXJmYWNlUHJvdG9jb2wgICAg
ICAyIA0KICAgICAgaUludGVyZmFjZSAgICAgICAgICAgICAgMCANCiAgICAg
IENsYXNzIHNwZWNpZmljIGludGVyZmFjZSBkZXNjcmlwdG9yIGZvciBjbGFz
cyAyNTUgaXMgdW5zdXBwb3J0ZWQNCiAgICAgIENsYXNzIHNwZWNpZmljIGlu
dGVyZmFjZSBkZXNjcmlwdG9yIGZvciBjbGFzcyAyNTUgaXMgdW5zdXBwb3J0
ZWQNCiAgICAgIEVuZHBvaW50IERlc2NyaXB0b3I6DQogICAgICAgIGJMZW5n
dGggICAgICAgICAgICAgICAgIDcNCiAgICAgICAgYkRlc2NyaXB0b3JUeXBl
ICAgICAgICAgNQ0KICAgICAgICBiRW5kcG9pbnRBZGRyZXNzICAgICAweDAx
ICBFUCAxIE9VVA0KICAgICAgICBibUF0dHJpYnV0ZXMgICAgICAgICAgICA5
DQogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAgICAgIElzb2Nocm9u
b3VzDQogICAgICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICAgIEFkYXB0
aXZlDQogICAgICAgICAgVXNhZ2UgVHlwZSAgICAgICAgICAgICAgIERhdGEN
CiAgICAgICAgd01heFBhY2tldFNpemUgICAgIDB4MDEyMCAgMXggMjg4IGJ5
dGVzDQogICAgICAgIGJJbnRlcnZhbCAgICAgICAgICAgICAgIDENCiAgICBJ
bnRlcmZhY2UgRGVzY3JpcHRvcjoNCiAgICAgIGJMZW5ndGggICAgICAgICAg
ICAgICAgIDkNCiAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQNCiAg
ICAgIGJJbnRlcmZhY2VOdW1iZXIgICAgICAgIDENCiAgICAgIGJBbHRlcm5h
dGVTZXR0aW5nICAgICAgIDANCiAgICAgIGJOdW1FbmRwb2ludHMgICAgICAg
ICAgIDANCiAgICAgIGJJbnRlcmZhY2VDbGFzcyAgICAgICAyNTUgVmVuZG9y
IFNwZWNpZmljIENsYXNzDQogICAgICBiSW50ZXJmYWNlU3ViQ2xhc3MgICAg
ICAyIA0KICAgICAgYkludGVyZmFjZVByb3RvY29sICAgICAgMSANCiAgICAg
IGlJbnRlcmZhY2UgICAgICAgICAgICAgIDAgDQogICAgSW50ZXJmYWNlIERl
c2NyaXB0b3I6DQogICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5DQog
ICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA0DQogICAgICBiSW50ZXJm
YWNlTnVtYmVyICAgICAgICAxDQogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAg
ICAgICAxDQogICAgICBiTnVtRW5kcG9pbnRzICAgICAgICAgICAxDQogICAg
ICBiSW50ZXJmYWNlQ2xhc3MgICAgICAgMjU1IFZlbmRvciBTcGVjaWZpYyBD
bGFzcw0KICAgICAgYkludGVyZmFjZVN1YkNsYXNzICAgICAgMiANCiAgICAg
IGJJbnRlcmZhY2VQcm90b2NvbCAgICAgIDEgDQogICAgICBpSW50ZXJmYWNl
ICAgICAgICAgICAgICAwIA0KICAgICAgQ2xhc3Mgc3BlY2lmaWMgaW50ZXJm
YWNlIGRlc2NyaXB0b3IgZm9yIGNsYXNzIDI1NSBpcyB1bnN1cHBvcnRlZA0K
ICAgICAgQ2xhc3Mgc3BlY2lmaWMgaW50ZXJmYWNlIGRlc2NyaXB0b3IgZm9y
IGNsYXNzIDI1NSBpcyB1bnN1cHBvcnRlZA0KICAgICAgRW5kcG9pbnQgRGVz
Y3JpcHRvcjoNCiAgICAgICAgYkxlbmd0aCAgICAgICAgICAgICAgICAgNw0K
ICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA1DQogICAgICAgIGJF
bmRwb2ludEFkZHJlc3MgICAgIDB4ODIgIEVQIDIgSU4NCiAgICAgICAgYm1B
dHRyaWJ1dGVzICAgICAgICAgICAgNQ0KICAgICAgICAgIFRyYW5zZmVyIFR5
cGUgICAgICAgICAgICBJc29jaHJvbm91cw0KICAgICAgICAgIFN5bmNoIFR5
cGUgICAgICAgICAgICAgICBBc3luY2hyb25vdXMNCiAgICAgICAgICBVc2Fn
ZSBUeXBlICAgICAgICAgICAgICAgRGF0YQ0KICAgICAgICB3TWF4UGFja2V0
U2l6ZSAgICAgMHgwMTIwICAxeCAyODggYnl0ZXMNCiAgICAgICAgYkludGVy
dmFsICAgICAgICAgICAgICAgMQ0KICAgIEludGVyZmFjZSBEZXNjcmlwdG9y
Og0KICAgICAgYkxlbmd0aCAgICAgICAgICAgICAgICAgOQ0KICAgICAgYkRl
c2NyaXB0b3JUeXBlICAgICAgICAgNA0KICAgICAgYkludGVyZmFjZU51bWJl
ciAgICAgICAgMg0KICAgICAgYkFsdGVybmF0ZVNldHRpbmcgICAgICAgMA0K
ICAgICAgYk51bUVuZHBvaW50cyAgICAgICAgICAgMg0KICAgICAgYkludGVy
ZmFjZUNsYXNzICAgICAgIDI1NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3MNCiAg
ICAgIGJJbnRlcmZhY2VTdWJDbGFzcyAgICAgIDMgDQogICAgICBiSW50ZXJm
YWNlUHJvdG9jb2wgICAgICAwIA0KICAgICAgaUludGVyZmFjZSAgICAgICAg
ICAgICAgMCANCiAgICAgIENsYXNzIHNwZWNpZmljIGludGVyZmFjZSBkZXNj
cmlwdG9yIGZvciBjbGFzcyAyNTUgaXMgdW5zdXBwb3J0ZWQNCiAgICAgIEVu
ZHBvaW50IERlc2NyaXB0b3I6DQogICAgICAgIGJMZW5ndGggICAgICAgICAg
ICAgICAgIDcNCiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNQ0K
ICAgICAgICBiRW5kcG9pbnRBZGRyZXNzICAgICAweDAzICBFUCAzIE9VVA0K
ICAgICAgICBibUF0dHJpYnV0ZXMgICAgICAgICAgICAyDQogICAgICAgICAg
VHJhbnNmZXIgVHlwZSAgICAgICAgICAgIEJ1bGsNCiAgICAgICAgICBTeW5j
aCBUeXBlICAgICAgICAgICAgICAgTm9uZQ0KICAgICAgICAgIFVzYWdlIFR5
cGUgICAgICAgICAgICAgICBEYXRhDQogICAgICAgIHdNYXhQYWNrZXRTaXpl
ICAgICAweDAwMjAgIDF4IDMyIGJ5dGVzDQogICAgICAgIGJJbnRlcnZhbCAg
ICAgICAgICAgICAgIDANCiAgICAgIEVuZHBvaW50IERlc2NyaXB0b3I6DQog
ICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDcNCiAgICAgICAgYkRl
c2NyaXB0b3JUeXBlICAgICAgICAgNQ0KICAgICAgICBiRW5kcG9pbnRBZGRy
ZXNzICAgICAweDg0ICBFUCA0IElODQogICAgICAgIGJtQXR0cmlidXRlcyAg
ICAgICAgICAgIDINCiAgICAgICAgICBUcmFuc2ZlciBUeXBlICAgICAgICAg
ICAgQnVsaw0KICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBO
b25lDQogICAgICAgICAgVXNhZ2UgVHlwZSAgICAgICAgICAgICAgIERhdGEN
CiAgICAgICAgd01heFBhY2tldFNpemUgICAgIDB4MDAyMCAgMXggMzIgYnl0
ZXMNCiAgICAgICAgYkludGVydmFsICAgICAgICAgICAgICAgMA0KICAgIElu
dGVyZmFjZSBEZXNjcmlwdG9yOg0KICAgICAgYkxlbmd0aCAgICAgICAgICAg
ICAgICAgOQ0KICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNA0KICAg
ICAgYkludGVyZmFjZU51bWJlciAgICAgICAgMg0KICAgICAgYkFsdGVybmF0
ZVNldHRpbmcgICAgICAgMQ0KICAgICAgYk51bUVuZHBvaW50cyAgICAgICAg
ICAgMg0KICAgICAgYkludGVyZmFjZUNsYXNzICAgICAgIDI1NSBWZW5kb3Ig
U3BlY2lmaWMgQ2xhc3MNCiAgICAgIGJJbnRlcmZhY2VTdWJDbGFzcyAgICAg
IDMgDQogICAgICBiSW50ZXJmYWNlUHJvdG9jb2wgICAgICAwIA0KICAgICAg
aUludGVyZmFjZSAgICAgICAgICAgICAgMCANCiAgICAgIEVuZHBvaW50IERl
c2NyaXB0b3I6DQogICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDcN
CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNQ0KICAgICAgICBi
RW5kcG9pbnRBZGRyZXNzICAgICAweDAzICBFUCAzIE9VVA0KICAgICAgICBi
bUF0dHJpYnV0ZXMgICAgICAgICAgICAyDQogICAgICAgICAgVHJhbnNmZXIg
VHlwZSAgICAgICAgICAgIEJ1bGsNCiAgICAgICAgICBTeW5jaCBUeXBlICAg
ICAgICAgICAgICAgTm9uZQ0KICAgICAgICAgIFVzYWdlIFR5cGUgICAgICAg
ICAgICAgICBEYXRhDQogICAgICAgIHdNYXhQYWNrZXRTaXplICAgICAweDAw
MjAgIDF4IDMyIGJ5dGVzDQogICAgICAgIGJJbnRlcnZhbCAgICAgICAgICAg
ICAgIDENCiAgICAgIEVuZHBvaW50IERlc2NyaXB0b3I6DQogICAgICAgIGJM
ZW5ndGggICAgICAgICAgICAgICAgIDcNCiAgICAgICAgYkRlc2NyaXB0b3JU
eXBlICAgICAgICAgNQ0KICAgICAgICBiRW5kcG9pbnRBZGRyZXNzICAgICAw
eDg0ICBFUCA0IElODQogICAgICAgIGJtQXR0cmlidXRlcyAgICAgICAgICAg
IDMNCiAgICAgICAgICBUcmFuc2ZlciBUeXBlICAgICAgICAgICAgSW50ZXJy
dXB0DQogICAgICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICAgIE5vbmUN
CiAgICAgICAgICBVc2FnZSBUeXBlICAgICAgICAgICAgICAgRGF0YQ0KICAg
ICAgICB3TWF4UGFja2V0U2l6ZSAgICAgMHgwMDIwICAxeCAzMiBieXRlcw0K
ICAgICAgICBiSW50ZXJ2YWwgICAgICAgICAgICAgICAxDQpEZXZpY2UgU3Rh
dHVzOiAgICAgMHgwMDAwDQogIChCdXMgUG93ZXJlZCkNCg0K

--8323328-2123443277-1182965650=:11146
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323328-2123443277-1182965650=:11146--
