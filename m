From: "Ben DiDonc" <ben.didonc@gmail.com>
Subject: Re: Fwd: No sound with ATI SB450
Date: Tue, 24 Apr 2007 00:12:46 +1000
Message-ID: <feca60390704230712p57311d2fl3f8d710bf20b7684@mail.gmail.com>
References: <feca60390704202156h5a34ef0ao975d8c398dee9473@mail.gmail.com>
	<1177302518.9698.47.camel@razman.gruemaster.com>
	<feca60390704230350k29822175ge46b7f7c803b9423@mail.gmail.com>
	<s5h4pn7uzns.wl%tiwai@suse.de>
	<feca60390704230405y12d44483t4ce7561913cfbca5@mail.gmail.com>
	<s5h3b2ruysq.wl%tiwai@suse.de>
	<feca60390704230458h43404a8ao75c1261974d1962a@mail.gmail.com>
	<s5h1wibuva5.wl%tiwai@suse.de>
	<feca60390704230545h90510d9rb138fff6df6aa372@mail.gmail.com>
	<s5hvefntfz3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11681_1287719.1177337566242"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EECE2485D
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 16:12:49 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so1742047anc
	for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2007 07:12:48 -0700 (PDT)
In-Reply-To: <s5hvefntfz3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_11681_1287719.1177337566242
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here are the two codec files:
codec#3-working-14rc1 was obtained after loading snd-hda-intel with
probe_mask=8 and model=auto
the other was obtained after loading the module without special parameters


On 4/23/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 23 Apr 2007 22:45:00 +1000,
> Ben DiDonc wrote:
> >
> > Tobin, Takashi,
> > Thank you very much for your help.
> > Takashi's last suggestion did it and I finally got a working ATI SB450
> > sound card with Ubtuntu Feisty (kernel 2.6.20 and
> > alsa-driver-hg20070421). I did a (last) alsa-info.sh in case it helps
> > others, see http://pastebin.ca/454115
> > Here's what it took:
> > modprobe snd_hda_intel probe_mask=8 model=auto
> > Without probe_mask, the ALC861 is not properly detected. Without
> > model=auto, playback doesnt work.
> > Let me know If I can be of any help or if you want me to try something else.
>
> As I requested, get /proc/asound/card0/codec#* files for both working
> and non-working states.  Then we can compare what is not set up
> properly.
>
> probe_mask is a bit hard to fix right now.  A least, we need to know
> which modem codec is harmful.  Please check the codec#* file again
> with probe_mask=1.
>
>
> Takashi
>
> > Thanks again.
> > Ben
> >
> > On 4/23/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Mon, 23 Apr 2007 21:58:17 +1000,
> > > Ben DiDonc wrote:
> > > >
> > > > Tobin, Takashi,
> > > > upon Takashi's advice, I tried loading hda-intel
> > > > (alsa-driver-hg20070421) using the probe_mask argument under 2.6.20.
> > > > With probe_mask=1, the codec isnt detected and only the modem shows up
> > > > (just like before). However, with probe_mask=8, the codec IS correctly
> > > > detected (alsa-info.sh at http://pastebin.ca/454059 ). syslog shows:
> > > > ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 19
> > > > ALSA .../alsa-driver-hg20070421/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
> > > > codec_mask = 0x9
> > > > ALSA .../alsa/alsa-driver-hg20070421/pci/hda/hda_codec.c:1819:
> > > > hda_codec: model 'toshiba' is selected for config 1179:ff10 (Toshiba)
> > > >
> > > > However, there is still no playback (no muted control, all volumes at
> > > > 100% as shown by amixer in alsa-info.sh). Here again, capture works, I
> > > > successfully captured from the mic with arecord.
> > >
> > > Now you can try what I suggested, model=auto.  And compare with
> > > codec#* files.  If you have /proc/asound/card0/codec#* files on the
> > > working system, it'd be better, in addition...
> > >
> > >
> > > Takashi
> > >
> > > >
> > > > Can I draw your attention on something ? I m not sure about what i m
> > > > going to say (specially the part on NIDs) but i ll try. I know Tobin
> > > > already explained that this was normal, but if you have a look at the
> > > > post where I loaded edgy (2 posts ago), where the playback
> > > > works(2.6.17 with 1.0.12), you ll see that when I aplay something,
> > > > syslog shows only a single call to hda_codec_setup_stream with
> > > > NID=0x3. In all cases where playback doesnt work (1.0.14rcX under
> > > > 2.6.20), running aplay makes 4 calls to hda_codec_setup_stream with
> > > > NID=3, 6 ,5 and 4 in turn. Why does it try 6 5 and 4 ? Is it because 3
> > > > fails ? We know that 3 should be used as its the one that works (under
> > > > 2.6.17). Now arent NIDs node IDs of codecs connected to the HDA
> > > > controller ? Is it possible that 6, 5 and 4 are mistakenly detected
> > > > and cannot be used for playback ?
> > > > Let me know if I m way off track.
> > >
> > > > Ben
> > > >
> > > > On 4/23/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > > > At Mon, 23 Apr 2007 11:05:19 +0000,
> > > > > Ben DiDonc wrote:
> > > > > >
> > > > > > Takashi,
> > > > > > I did try passing model=auto to all 14 release candidates,
> > > > >
> > > > > Did you already try the HG version (or daily snapshot), right?
> > > > >
> > > > > > but without
> > > > > > success. the codec is never detected (see my previous posts for
> > > > > > alsa-info.sh outputs with both 2.6.20 and 2.6.17).
> > > > > > My problem is I cant get my sound card to work with kernel 2.6.20,
> > > > > > when it used to work with 2.6.17.
> > > > >
> > > > > The codec mask probed is 0x09, so you can pass either probe_mask=8 or
> > > > > probe_mask=1 to skip the modem detection (if it matters).
> > > > >
> > > > >
> > > > > Takashi
> > > > >
> > > > >
> > > > > >
> > > > > > Ben
> > > > > >
> > > > > > On 4/23/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > At Mon, 23 Apr 2007 10:50:18 +0000,
> > > > > > > Ben DiDonc wrote:
> > > > > > > >
> > > > > > > > Tobin,
> > > > > > > > Unfortunately, ACPI was on at all times. My laptop hardly ever boots
> > > > > > > > without ACPI (randomly, the SATA driver fails before it can even mount
> > > > > > > > the root partition).
> > > > > > > > I ran some more tests today:
> > > > > > > > I loaded Ubuntu Edgy from the live CD where the sound chip used to
> > > > > > > > work (kernel 2.6.17, alsa driver 1.0.12rc1). Obviously the sound works
> > > > > > > > straight away. From there , I ran the same series of test: download
> > > > > > > > and build (--with-debug=detect) the next version of alsa-driver, run a
> > > > > > > > capture from mic and try playing it back, check syslog and run
> > > > > > > > alsa-info.sh. I did this for successive versions of alsa-driver
> > > > > > > > (starting with 1.0.12) until it fails.
> > > > > > > > Here are the results:
> > > > > > > >
> > > > > > > > Alsa driver 1.0.12rc1(shipped with edgy):
> > > > > > > > capture: working, playback working, alsa-info.sh at http://pastebin.ca/453947
> > > > > > > >
> > > > > > > > Alsa driver 1.0.12: (alsa-info.sh at http://pastebin.ca/453971 )
> > > > > > > > syslog lines after modprobe:
> > > > > > > > ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 233
> > > > > > > > ALSA alsa-driver-1.0.12/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:663:
> > > > > > > > codec_mask = 0x9
> > > > > > > > hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
> > > > > > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2150: autoconfig:
> > > > > > > > line_outs=1 (0xb/0x0/0x0/0x0/0x0)
> > > > > > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2154:    speaker_outs=0
> > > > > > > > (0x0/0x0/0x0/0x0/0x0)
> > > > > > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2156:    hp=0x0,
> > > > > > > > dig_out=0x0, din_in=0x0
> > > > > > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2164:    inputs: mic=0xd,
> > > > > > > > fmic=0x0, line=0x0, fline=0x0, cd=0x11, aux=0x0
> > > > > > > >
> > > > > > > > capture: working
> > > > > > > > //capture starting
> > > > > > > > hda_intel.c:1124: azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> > > > > > > > hda_codec.c:628: hda_codec_setup_stream: NID=0x8, stream=0x1,
> > > > > > > > channel=0, format=0x11
> > > > > > > > //capture stopping
> > > > > > > > hda_codec.c:628: hda_codec_setup_stream: NID=0x8, stream=0x0,
> > > > > > > > channel=0, format=0x0
> > > > > > > >
> > > > > > > > playback: working
> > > > > > > > //starting
> > > > > > > > ALSA hda_intel.c:1124: azx_pcm_prepare: bufsize=0x10000,
> > > > > > > > fragsize=0x1000, format=0x11
> > > > > > > > ALSA hda_codec.c:628: hda_codec_setup_stream: NID=0x3, stream=0x5,
> > > > > > > > channel=0, format=0x11
> > > > > > > > //stopping
> > > > > > > > ALSA hda_codec.c:628: hda_codec_setup_stream: NID=0x3, stream=0x0,
> > > > > > > > channel=0, format=0x0
> > > > > > > >
> > > > > > > > alsa-driver-1.0.13 (alsa-info.sh at http://pastebin.ca/453975 )
> > > > > > > > modprobe snd-hda-intel:
> > > > > > > > hda_intel.c:680: codec_mask = 0x9
> > > > > > > > hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
> > > > > > > > hda_codec.c:2164: autoconfig: line_outs=1 (0xb/0x0/0x0/0x0/0x0)
> > > > > > > > hda_codec.c:2168:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> > > > > > > > hda_codec.c:2172:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
> > > > > > > > hda_codec.c:2180:    inputs: mic=0xd, fmic=0x0, line=0x0, fline=0x0,
> > > > > > > > cd=0x11, aux=0x0
> > > > > > > > capture works fine, syslog output similar to 1.0.12 plus an extra
> > > > > > > > "hda-intel: Invalid position buffer, using LPIB read method instead"
> > > > > > > > in the middle of the capture. Playback works fine too, with the same
> > > > > > > > syslog entries as 1.0.12
> > > > > > > >
> > > > > > > >
> > > > > > > > alsa-driver-1.0.14rc1 (alsa-info.sh at http://pastebin.ca/453991 )
> > > > > > > > modprobe:
> > > > > > > > ALSA hda_intel.c:696: codec_mask = 0x9
> > > > > > > > ALSA hda_codec.c:1768: hda_codec: model 'toshiba' is selected for
> > > > > > > > config 1179:ff10 (Toshiba)
> > > > > > > > Capture works (output similar to 1.0.12)
> > > > > > > > Playback does NOT work this time:
> > > > > > > > syslog shows a call to azx_pcm_prepare: and 4 calls to
> > > > > > > > hda_codec_setup_stream with different nids (3, 6 ,5, 4 as pointed out
> > > > > > > > my previous post)
> > > > > > > >
> > > > > > > >
> > > > > > > > alsa-driver-1.0.14rc2 (alsa-info.sh at http://pastebin.ca/453799 )
> > > > > > > > modprobe: the codec is correctly detected
> > > > > > > > ALSA hda_intel.c:696: codec_mask = 0x9
> > > > > > > > ALSA hda_codec.c:1764: hda_codec: model 'toshiba' is selected for
> > > > > > > > config 1179:ff10 (Toshiba)
> > > > > > > > Capture works. Playback does NOT work, same syslog entries as
> > > > > > > > 1.0.14rc1 with multiple calls to hda_codec_setup_stream
> > > > > > > >
> > > > > > > >
> > > > > > > > alsa-driver-1.0.14rc3 (alsa-info.sh at http://pastebin.ca/453785 )
> > > > > > > > modprobe: the codec isnt detected.
> > > > > > > > ALSA hda_intel.c:696: codec_mask = 0x9
> > > > > > > > capture and playback dont work.
> > > > > > > >
> > > > > > > > Summary: I tried alsa-driver 1.012 through to 1.0.14rc3 on ubuntu edgy
> > > > > > > > (kernel 2.6.17). 12 and 13 work fine, 14rc1 and 2 capture works but
> > > > > > > > not playback, 14rc3 doesnt detect the codec.
> > > > > > > > What next ? not sure, maybe make a diff of alsa-kernel/pci/hda-intel
> > > > > > > > between releases 13 and 14 ...
> > > > > > >
> > > > > > > Try to pass model=auto to snd-hda-intel module, and check whether it
> > > > > > > works (make sure that you have unmuted/adjusted mixer elements before
> > > > > > > that).  Then get /proc/asound/card0/codec#* files, and compare with
> > > > > > > the files without model option.
> > > > > > >
> > > > > > >
> > > > > > > Takashi
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

------=_Part_11681_1287719.1177337566242
Content-Type: application/octet-stream; name=codec#3-not-working-14rc2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0v0arkv
Content-Disposition: attachment; filename="codec#3-not-working-14rc2"

Q29kZWM6IFJlYWx0ZWsgQUxDODYxCkFkZHJlc3M6IDMKVmVuZG9yIElkOiAweDEwZWMwODYxClN1
YnN5c3RlbSBJZDogMHgxMTc5ZmYxMApSZXZpc2lvbiBJZDogMHgxMDAzMDAKRGVmYXVsdCBQQ006
CiAgICByYXRlcyBbMHgxNDBdOiA0ODAwMCA5NjAwMAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQK
ICAgIGZvcm1hdHMgWzB4MV06IFBDTQpEZWZhdWx0IEFtcC1JbiBjYXBzOiBOL0EKRGVmYXVsdCBB
bXAtT3V0IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0x
Ck5vZGUgMHgwMyBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDQwNTogU3RlcmVvIEFtcC1PdXQKICBB
bXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDAwIDB4MDBdCiAgUG93ZXI6IDB4
MApOb2RlIDB4MDQgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0MDU6IFN0ZXJlbyBBbXAtT3V0CiAg
QW1wLU91dCBjYXBzOiBOL0EKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIFBvd2VyOiAw
eDAKTm9kZSAweDA1IFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4NDA1OiBTdGVyZW8gQW1wLU91dAog
IEFtcC1PdXQgY2FwczogTi9BCiAgQW1wLU91dCB2YWxzOiAgWzB4MDAgMHgwMF0KICBQb3dlcjog
MHgwCk5vZGUgMHgwNiBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDQwNTogU3RlcmVvIEFtcC1PdXQK
ICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDAwIDB4MDBdCiAgUG93ZXI6
IDB4MApOb2RlIDB4MDcgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg2MDU6IFN0ZXJlbyBEaWdpdGFs
IEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDAwIDB4MDBd
CiAgUG93ZXI6IDB4MApOb2RlIDB4MDggW0F1ZGlvIElucHV0XSB3Y2FwcyAweDEwMDUxYjogU3Rl
cmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMiwgbnN0ZXBzPTB4MGQsIHN0ZXBzaXpl
PTB4MGIsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4
MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0KICBQQ006CiAgICBy
YXRlcyBbMHgxNDBdOiA0ODAwMCA5NjAwMAogICAgYml0cyBbMHgyXTogMTYKICAgIGZvcm1hdHMg
WzB4MV06IFBDTQogIFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiA2CiAgICAgMHgwZCogMHgwYyAw
eDBmIDB4MTAgMHgxMSAweDE1Ck5vZGUgMHgwOSBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2Fw
cyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MGEgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMg
MHhmMDAwMDA6IE1vbm8KTm9kZSAweDBiIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1ODE6IFN0
ZXJlbwogIFBpbmNhcCAweDA4MWY6IE9VVCBIUCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDAxMDE0
MTEwOiBbSmFja10gTGluZSBPdXQgYXQgRXh0IFJlYXIKICAgIENvbm4gPSAxLzgsIENvbG9yID0g
R3JlZW4KICBQaW4tY3RsczogMHg0MDogT1VUCiAgUG93ZXI6IDB4MAogIENvbm5lY3Rpb246IDEK
ICAgICAweDE2Ck5vZGUgMHgwYyBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNTgxOiBTdGVyZW8K
ICBQaW5jYXAgMHgwODM3OiBJTiBPVVQgRGV0ZWN0CiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDog
W04vQV0gU3BlYWtlciBhdCBFeHQgUmVhcgogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawog
IFBpbi1jdGxzOiAweDIwOiBJTgogIFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgx
OQpOb2RlIDB4MGQgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDU4MTogU3RlcmVvCiAgUGluY2Fw
IDB4MDgzMzc6IElOIE9VVCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDAxYTE5OTIxOiBbSmFja10g
TWljIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84LCBDb2xvciA9IFBpbmsKICBQaW4tY3Rsczog
MHgyNDogSU4KICBQb3dlcjogMHgwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MTgKTm9kZSAweDBl
IFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1ODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MTc6IE9V
VCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBS
ZWFyCiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4NDA6IE9VVAog
IFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgxOQpOb2RlIDB4MGYgW1BpbiBDb21w
bGV4XSB3Y2FwcyAweDQwMDU4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgzM2Y6IElOIE9VVCBIUCBE
ZXRlY3QKICBQaW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFy
CiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4YzA6IE9VVCBIUAog
IFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgxYQpOb2RlIDB4MTAgW1BpbiBDb21w
bGV4XSB3Y2FwcyAweDQwMDU4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgzM2Y6IElOIE9VVCBIUCBE
ZXRlY3QKICBQaW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFy
CiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4MjQ6IElOCiAgUG93
ZXI6IDB4MAogIENvbm5lY3Rpb246IDEKICAgICAweDFiCk5vZGUgMHgxMSBbUGluIENvbXBsZXhd
IHdjYXBzIDB4NDAwMDAxOiBTdGVyZW8KICBQaW5jYXAgMHgwODYzOiBJTgogIFBpbiBEZWZhdWx0
IDB4YjczMzExMjA6IFtGaXhlZF0gQ0QgYXQgT3RoIE1vYmlsZS1JbgogICAgQ29ubiA9IEFUQVBJ
LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4MDA6Ck5vZGUgMHgxMiBbUGluIENvbXBsZXhd
IHdjYXBzIDB4NDAwMzAxOiBTdGVyZW8gRGlnaXRhbAogIFBpbmNhcCAweDA4MTA6IE9VVAogIFBp
biBEZWZhdWx0IDB4NDExMTExZjA6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IFJlYXIKICAgIENvbm4g
PSAxLzgsIENvbG9yID0gQmxhY2sKICBQaW4tY3RsczogMHg0MDogT1VUCiAgQ29ubmVjdGlvbjog
MQogICAgIDB4MDcKTm9kZSAweDEzIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAw
MDAwOiBNb25vCk5vZGUgMHgxNCBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTBiOiBTdGVyZW8g
QW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgw
MCwgbXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXSBbMHgwMCAweDAwXQogIENvbm5l
Y3Rpb246IDIKICAgICAweDBkIDB4MTAKTm9kZSAweDE1IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgy
MDA1MGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dAogIEFtcC1JbiBjYXBzOiBvZnM9MHgwYywgbnN0
ZXBzPTB4MTcsIHN0ZXBzaXplPTB4MGIsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgw
MF0gWzB4MTcgMHgxN10gWzB4MDAgMHgwMF0KICBBbXAtT3V0IGNhcHM6IG9mcz0weDBjLCBuc3Rl
cHM9MHgwYywgc3RlcHNpemU9MHgwYiwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAgWzB4MGMgMHgw
Y10KICBQb3dlcjogMHgwCiAgQ29ubmVjdGlvbjogMwogICAgIDB4MTEgMHgxNCAweDFjCk5vZGUg
MHgxNiBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTBiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUlu
IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1w
LUluIHZhbHM6ICBbMHgwMCAweDAwXSBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDIKICAgICAw
eDAzIDB4MTUKTm9kZSAweDE3IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBB
bXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAw
LCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdCiAgQ29ubmVj
dGlvbjogMgogICAgIDB4MDQgMHgxNQpOb2RlIDB4MTggW0F1ZGlvIE1peGVyXSB3Y2FwcyAweDIw
MDEwYjogU3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAs
IHN0ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0gWzB4MDAg
MHgwMF0KICBDb25uZWN0aW9uOiAyCiAgICAgMHgwNSAweDE1Ck5vZGUgMHgxOSBbQXVkaW8gTWl4
ZXJdIHdjYXBzIDB4MjAwMTBiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAw
LCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHgw
MCAweDAwXSBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDIKICAgICAweDA2IDB4MTUKTm9kZSAw
eDFhIFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4g
Y2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAt
SW4gdmFsczogIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDAwIDB4MDBdIFsweDgwIDB4ODBd
CiAgQ29ubmVjdGlvbjogNAogICAgIDB4MDQgMHgwNiAweDE1IDB4MDMKTm9kZSAweDFiIFtBdWRp
byBNaXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2Zz
PTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtSW4gdmFsczog
IFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdCiAgQ29ubmVj
dGlvbjogNAogICAgIDB4MDQgMHgwNiAweDE1IDB4MDMKTm9kZSAweDFjIFtBdWRpbyBNaXhlcl0g
d2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5z
dGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDAwIDB4
MDBdIFsweDAwIDB4MDBdCiAgQ29ubmVjdGlvbjogMgogICAgIDB4MGMgMHgwZgpOb2RlIDB4MWQg
W1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDFlIFtW
ZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgxZiBbUGlu
IENvbXBsZXhdIHdjYXBzIDB4NDAwNTgxOiBTdGVyZW8KICBQaW5jYXAgMHgwODE3OiBPVVQgRGV0
ZWN0CiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04vQV0gU3BlYWtlciBhdCBFeHQgUmVhcgog
ICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogIFBpbi1jdGxzOiAweDQwOiBPVVQKICBQb3dl
cjogMHgwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MTgKTm9kZSAweDIwIFtQaW4gQ29tcGxleF0g
d2NhcHMgMHg0MDA1ODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MTc6IE9VVCBEZXRlY3QKICBQaW4g
RGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25uID0g
MS84LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4NDA6IE9VVAogIFBvd2VyOiAweDAKICBD
b25uZWN0aW9uOiAxCiAgICAgMHgxNwpOb2RlIDB4MjEgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0g
d2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDIyIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdj
YXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgyMyBbQmVlcCBHZW5lcmF0b3IgV2lkZ2V0XSB3Y2Fw
cyAweDcwMDAwYzogTW9ubyBBbXAtT3V0CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwZiwgbnN0ZXBz
PTB4MGYsIHN0ZXBzaXplPTB4MGIsIG11dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDhmXQo=
------=_Part_11681_1287719.1177337566242
Content-Type: application/octet-stream; name=codec#3-working-14rc1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0v0bd81
Content-Disposition: attachment; filename="codec#3-working-14rc1"

Q29kZWM6IFJlYWx0ZWsgQUxDODYxCkFkZHJlc3M6IDMKVmVuZG9yIElkOiAweDEwZWMwODYxClN1
YnN5c3RlbSBJZDogMHgxMTc5ZmYxMApSZXZpc2lvbiBJZDogMHgxMDAzMDAKRGVmYXVsdCBQQ006
CiAgICByYXRlcyBbMHgxNDBdOiA0ODAwMCA5NjAwMAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQK
ICAgIGZvcm1hdHMgWzB4MV06IFBDTQpEZWZhdWx0IEFtcC1JbiBjYXBzOiBOL0EKRGVmYXVsdCBB
bXAtT3V0IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0x
Ck5vZGUgMHgwMyBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDQwNTogU3RlcmVvIEFtcC1PdXQKICBB
bXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDAwIDB4MDBdCiAgUG93ZXI6IDB4
MApOb2RlIDB4MDQgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0MDU6IFN0ZXJlbyBBbXAtT3V0CiAg
QW1wLU91dCBjYXBzOiBOL0EKICBBbXAtT3V0IHZhbHM6ICBbMHg4MCAweDgwXQogIFBvd2VyOiAw
eDAKTm9kZSAweDA1IFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4NDA1OiBTdGVyZW8gQW1wLU91dAog
IEFtcC1PdXQgY2FwczogTi9BCiAgQW1wLU91dCB2YWxzOiAgWzB4ODAgMHg4MF0KICBQb3dlcjog
MHgwCk5vZGUgMHgwNiBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDQwNTogU3RlcmVvIEFtcC1PdXQK
ICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDgwIDB4ODBdCiAgUG93ZXI6
IDB4MApOb2RlIDB4MDcgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg2MDU6IFN0ZXJlbyBEaWdpdGFs
IEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDAwIDB4MDBd
CiAgUG93ZXI6IDB4MApOb2RlIDB4MDggW0F1ZGlvIElucHV0XSB3Y2FwcyAweDEwMDUxYjogU3Rl
cmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMiwgbnN0ZXBzPTB4MGQsIHN0ZXBzaXpl
PTB4MGIsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4
ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0KICBQQ006CiAgICBy
YXRlcyBbMHgxNDBdOiA0ODAwMCA5NjAwMAogICAgYml0cyBbMHgyXTogMTYKICAgIGZvcm1hdHMg
WzB4MV06IFBDTQogIFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiA2CiAgICAgMHgwZCogMHgwYyAw
eDBmIDB4MTAgMHgxMSAweDE1Ck5vZGUgMHgwOSBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2Fw
cyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MGEgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMg
MHhmMDAwMDA6IE1vbm8KTm9kZSAweDBiIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1ODE6IFN0
ZXJlbwogIFBpbmNhcCAweDA4MWY6IE9VVCBIUCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDAxMDE0
MTEwOiBbSmFja10gTGluZSBPdXQgYXQgRXh0IFJlYXIKICAgIENvbm4gPSAxLzgsIENvbG9yID0g
R3JlZW4KICBQaW4tY3RsczogMHg0MDogT1VUCiAgUG93ZXI6IDB4MAogIENvbm5lY3Rpb246IDEK
ICAgICAweDE2Ck5vZGUgMHgwYyBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNTgxOiBTdGVyZW8K
ICBQaW5jYXAgMHgwODM3OiBJTiBPVVQgRGV0ZWN0CiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDog
W04vQV0gU3BlYWtlciBhdCBFeHQgUmVhcgogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawog
IFBpbi1jdGxzOiAweDIwOiBJTgogIFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgx
OQpOb2RlIDB4MGQgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDU4MTogU3RlcmVvCiAgUGluY2Fw
IDB4MDgzMzc6IElOIE9VVCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDAxYTE5OTIxOiBbSmFja10g
TWljIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84LCBDb2xvciA9IFBpbmsKICBQaW4tY3Rsczog
MHgyNDogSU4KICBQb3dlcjogMHgwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MTgKTm9kZSAweDBl
IFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1ODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MTc6IE9V
VCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBS
ZWFyCiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4NDA6IE9VVAog
IFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgxOQpOb2RlIDB4MGYgW1BpbiBDb21w
bGV4XSB3Y2FwcyAweDQwMDU4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgzM2Y6IElOIE9VVCBIUCBE
ZXRlY3QKICBQaW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFy
CiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4NDA6IE9VVAogIFBv
d2VyOiAweDAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgxYQpOb2RlIDB4MTAgW1BpbiBDb21wbGV4
XSB3Y2FwcyAweDQwMDU4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgzM2Y6IElOIE9VVCBIUCBEZXRl
Y3QKICBQaW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAg
ICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4MjA6IElOCiAgUG93ZXI6
IDB4MAogIENvbm5lY3Rpb246IDEKICAgICAweDFiCk5vZGUgMHgxMSBbUGluIENvbXBsZXhdIHdj
YXBzIDB4NDAwMDAxOiBTdGVyZW8KICBQaW5jYXAgMHgwODYzOiBJTgogIFBpbiBEZWZhdWx0IDB4
YjczMzExMjA6IFtGaXhlZF0gQ0QgYXQgT3RoIE1vYmlsZS1JbgogICAgQ29ubiA9IEFUQVBJLCBD
b2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4MDA6Ck5vZGUgMHgxMiBbUGluIENvbXBsZXhdIHdj
YXBzIDB4NDAwMzAxOiBTdGVyZW8gRGlnaXRhbAogIFBpbmNhcCAweDA4MTA6IE9VVAogIFBpbiBE
ZWZhdWx0IDB4NDExMTExZjA6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IFJlYXIKICAgIENvbm4gPSAx
LzgsIENvbG9yID0gQmxhY2sKICBQaW4tY3RsczogMHg0MDogT1VUCiAgQ29ubmVjdGlvbjogMQog
ICAgIDB4MDcKTm9kZSAweDEzIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAw
OiBNb25vCk5vZGUgMHgxNCBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTBiOiBTdGVyZW8gQW1w
LUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwg
bXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXSBbMHgwMCAweDAwXQogIENvbm5lY3Rp
b246IDIKICAgICAweDBkIDB4MTAKTm9kZSAweDE1IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDA1
MGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dAogIEFtcC1JbiBjYXBzOiBvZnM9MHgwYywgbnN0ZXBz
PTB4MTcsIHN0ZXBzaXplPTB4MGIsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4ODAgMHg4MF0g
WzB4ODAgMHg4MF0gWzB4MDAgMHgwMF0KICBBbXAtT3V0IGNhcHM6IG9mcz0weDBjLCBuc3RlcHM9
MHgwYywgc3RlcHNpemU9MHgwYiwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAgWzB4MGMgMHgwY10K
ICBQb3dlcjogMHgwCiAgQ29ubmVjdGlvbjogMwogICAgIDB4MTEgMHgxNCAweDFjCk5vZGUgMHgx
NiBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTBiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUluIGNh
cHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLUlu
IHZhbHM6ICBbMHgwMCAweDAwXSBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDIKICAgICAweDAz
IDB4MTUKTm9kZSAweDE3IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAt
SW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBt
dXRlPTEKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdCiAgQ29ubmVjdGlv
bjogMgogICAgIDB4MDQgMHgxNQpOb2RlIDB4MTggW0F1ZGlvIE1peGVyXSB3Y2FwcyAweDIwMDEw
YjogU3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0
ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0gWzB4MDAgMHgw
MF0KICBDb25uZWN0aW9uOiAyCiAgICAgMHgwNSAweDE1Ck5vZGUgMHgxOSBbQXVkaW8gTWl4ZXJd
IHdjYXBzIDB4MjAwMTBiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBu
c3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAw
eDAwXSBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDIKICAgICAweDA2IDB4MTUKTm9kZSAweDFh
IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fw
czogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtSW4g
dmFsczogIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdCiAg
Q29ubmVjdGlvbjogNAogICAgIDB4MDQgMHgwNiAweDE1IDB4MDMKTm9kZSAweDFiIFtBdWRpbyBN
aXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4
MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsw
eDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdCiAgQ29ubmVjdGlv
bjogNAogICAgIDB4MDQgMHgwNiAweDE1IDB4MDMKTm9kZSAweDFjIFtBdWRpbyBNaXhlcl0gd2Nh
cHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVw
cz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBd
IFsweDAwIDB4MDBdCiAgQ29ubmVjdGlvbjogMgogICAgIDB4MGMgMHgwZgpOb2RlIDB4MWQgW1Zl
bmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDFlIFtWZW5k
b3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgxZiBbUGluIENv
bXBsZXhdIHdjYXBzIDB4NDAwNTgxOiBTdGVyZW8KICBQaW5jYXAgMHgwODE3OiBPVVQgRGV0ZWN0
CiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04vQV0gU3BlYWtlciBhdCBFeHQgUmVhcgogICAg
Q29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogIFBpbi1jdGxzOiAweDQwOiBPVVQKICBQb3dlcjog
MHgwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MTgKTm9kZSAweDIwIFtQaW4gQ29tcGxleF0gd2Nh
cHMgMHg0MDA1ODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MTc6IE9VVCBEZXRlY3QKICBQaW4gRGVm
YXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84
LCBDb2xvciA9IEJsYWNrCiAgUGluLWN0bHM6IDB4NDA6IE9VVAogIFBvd2VyOiAweDAKICBDb25u
ZWN0aW9uOiAxCiAgICAgMHgxNwpOb2RlIDB4MjEgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2Nh
cHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDIyIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBz
IDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgyMyBbQmVlcCBHZW5lcmF0b3IgV2lkZ2V0XSB3Y2FwcyAw
eDcwMDAwYzogTW9ubyBBbXAtT3V0CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwZiwgbnN0ZXBzPTB4
MGYsIHN0ZXBzaXplPTB4MGIsIG11dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDhmXQo=
------=_Part_11681_1287719.1177337566242
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_11681_1287719.1177337566242--
