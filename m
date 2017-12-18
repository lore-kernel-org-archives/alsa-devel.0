From: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mixer regression with usb soundcard
Date: Mon, 18 Dec 2017 21:56:07 +0000
Message-ID: <ec393c6b-a960-5fb3-f98c-cb2120961d45@gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
 <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
 <s5ha7ygdoqb.wl-tiwai@suse.de>
 <9dff0299-5621-2670-50b6-ee1851bb40f4@gmail.com>
 <s5htvwoc63f.wl-tiwai@suse.de>
 <CAL6iAaJVVVow45P=+whSnog+THH0CqW7ZdAYmegbd7byqCFUxg@mail.gmail.com>
 <CAL6iAaJVwWRpdGMXKTRYBN8gTD9vUS5C7cjN6SBsN1UBMxYcPw@mail.gmail.com>
 <cd84d03e-ba85-d43b-684f-90d1fcfaac9d@gmail.com>
 <s5htvwn6dg4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------46573C233A4A93A68565CB6E"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5htvwn6dg4.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------46573C233A4A93A68565CB6E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 18-12-2017 19:30, Takashi Iwai wrote:
> On Mon, 18 Dec 2017 20:10:44 +0100,
> Mauro Santos wrote:
>>
>> On 18-12-2017 17:50, Jaejoong Kim wrote:
>>> Mauro,
>>>
>>> Could you please try debug patch(I also attach the patch file)?
>>
>> With the attached patch I get the following when plugging in the usb dac
>> directly to a usb3 port:
>> [   54.391539] usb 1-2: new full-speed USB device number 7 using xhci_hcd
>> [   54.514996] usb 1-2: device descriptor read/64, error -71
>> [   54.849808] input: HiFimeDIY Audio HiFimeDIY DAC as
>> /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:1852:7022.0003/input/input20
>> [   54.850168] hid-generic 0003:1852:7022.0003: input,hidraw2: USB HID
>> v1.00 Device [HiFimeDIY Audio HiFimeDIY DAC] on usb-0000:00:14.0-2/input0
>> [   54.950421] usb 1-2: [DEBUG] nameid:0, len:0
>> [   54.950426] usb 1-2: [DEBUG] len:3, get_term_name:PCM
>> [   54.950429] usb 1-2: [11] SU [PCM] items = 2
>> [   54.950985] usbcore: registered new interface driver snd-usb-audio
> 
> Hmm, the driver get the supposedly correct name string here, so I see
> no flaw, so far.
> 
> Could you put the similar debug prints after reverting the commit and
> compare?  Or, at minimum, you can enable simply the kernel debug
> prints like below:
> 
>   % echo "file sound/usb/mixer.c +p" > /sys/kernel/debug/dynamic_debug_control
> 
> and re-plug the device.
> 
> Also, could you attach the output of "amixer contents" on both working
> and non-working kernels?
> 

I have compiled a new kernel where I have reverted the commit and I've
added the debug output based on your last debug patch. I attach the
patch that reverts the changes and adds the debug output just in case
anyone wants to do a sanity check on it (don't mind the indentation I
think I botched that).

With the debug patches I get no extra output when echoing to the
dynamic_debug/control file, I guess that's expected.

I attach the dmesg and amixer outputs for the case without revert plus
debug (bad) and revert plus debug (good).

One change does jump out:

bad:  usb 1-2: [11] SU [PCM] items = 2
good: usb 1-2: [11] SU [PCM Capture Source] items = 2

-- 
Mauro Santos

--------------46573C233A4A93A68565CB6E
Content-Type: text/plain; charset=UTF-8;
 name="amixer_good.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="amixer_good.txt"

U2ltcGxlIG1peGVyIGNvbnRyb2wgJ1BDTScsMAogIENhcGFiaWxpdGllczogcHZvbHVtZSBw
c3dpdGNoIHBzd2l0Y2gtam9pbmVkCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQg
LSBGcm9udCBSaWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDExMAogIE1vbm86CiAgRnJv
bnQgTGVmdDogUGxheWJhY2sgMCBbMCVdIFstNTUuMDBkQl0gW29uXQogIEZyb250IFJpZ2h0
OiBQbGF5YmFjayAwIFswJV0gWy01NS4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9s
ICdQQ00gQ2FwdHVyZSBTb3VyY2UnLDAKICBDYXBhYmlsaXRpZXM6IGVudW0KICBJdGVtczog
J0xpbmUnICdJRUM5NTggSW4nCiAgSXRlbTA6ICdMaW5lJwpTaW1wbGUgbWl4ZXIgY29udHJv
bCAnTGluZScsMAogIENhcGFiaWxpdGllczogY3ZvbHVtZSBjc3dpdGNoIGNzd2l0Y2gtam9p
bmVkCiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGlt
aXRzOiBDYXB0dXJlIDAgLSAxMDQKICBGcm9udCBMZWZ0OiBDYXB0dXJlIDAgWzAlXSBbLTQw
LjAwZEJdIFtvZmZdCiAgRnJvbnQgUmlnaHQ6IENhcHR1cmUgMCBbMCVdIFstNDAuMDBkQl0g
W29mZl0K
--------------46573C233A4A93A68565CB6E
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_good.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg_good.txt"

WyAgIDYzLjYwMDQwMl0gdXNiIDEtMjogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1i
ZXIgNyB1c2luZyB4aGNpX2hjZApbICAgNjMuNzIzNzM5XSB1c2IgMS0yOiBkZXZpY2UgZGVz
Y3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDY0LjA1NzUwNl0gaW5wdXQ6IEhpRmlt
ZURJWSBBdWRpbyBIaUZpbWVESVkgREFDIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxNC4wL3VzYjEvMS0yLzEtMjoxLjAvMDAwMzoxODUyOjcwMjIuMDAwMy9pbnB1dC9pbnB1
dDIwClsgICA2NC4wNTc3ODBdIGhpZC1nZW5lcmljIDAwMDM6MTg1Mjo3MDIyLjAwMDM6IGlu
cHV0LGhpZHJhdzI6IFVTQiBISUQgdjEuMDAgRGV2aWNlIFtIaUZpbWVESVkgQXVkaW8gSGlG
aW1lRElZIERBQ10gb24gdXNiLTAwMDA6MDA6MTQuMC0yL2lucHV0MApbICAgNjQuMTU0MDkx
XSB1c2IgMS0yOiBbREVCVUddIG5hbWVpZDowLCBsZW46MApbICAgNjQuMTU0MDk1XSB1c2Ig
MS0yOiBbREVCVUddIGxlbjozLCBnZXRfdGVybV9uYW1lOlBDTQpbICAgNjQuMTU0MDk3XSB1
c2IgMS0yOiBbMTFdIFNVIFtQQ00gQ2FwdHVyZSBTb3VyY2VdIGl0ZW1zID0gMgpbICAgNjQu
MTU0NDk1XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHNuZC11
c2ItYXVkaW8K
--------------46573C233A4A93A68565CB6E
Content-Type: text/x-patch;
 name="revert_with_debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="revert_with_debug.patch"

diff -ur a/sound/usb/mixer.c b/sound/usb/mixer.c
--- a/sound/usb/mixer.c	2017-12-18 19:47:02.748776502 +0000
+++ b/sound/usb/mixer.c	2017-12-18 20:18:30.023770892 +0000
@@ -595,7 +595,7 @@
 	while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
 		kctl->id.index++;
 	if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
-		usb_audio_dbg(mixer->chip, "cannot add control (err = %d)\n",
+		usb_audio_err(mixer->chip, "cannot add control (err = %d)\n",
 			      err);
 		return err;
 	}
@@ -656,10 +656,14 @@
 			 unsigned char *name, int maxlen, int term_only)
 {
 	struct iterm_name_combo *names;
+    int len;
 
-	if (iterm->name)
-		return snd_usb_copy_string_desc(state, iterm->name,
+	if (iterm->name) {
+		len = snd_usb_copy_string_desc(state, iterm->name,
 						name, maxlen);
+        usb_audio_err(state->chip, "[DEBUG] len:%d, iterm->name:%d\n", len, iterm->name);
+        return len;
+    }
 
 	/* virtual type - not a real terminal */
 	if (iterm->type >> 16) {
@@ -2175,17 +2179,24 @@
 
 	nameid = uac_selector_unit_iSelector(desc);
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
+
+    usb_audio_err(state->chip, "[DEBUG] nameid:%d, len:%d\n", nameid, len);
+
 	if (len)
 		;
-	else if (nameid)
+	else if (nameid) {
 		len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
 					 sizeof(kctl->id.name));
-	else
+        usb_audio_err(state->chip, "[DEBUG] len:%d, copy_string id.name:%s\n",
+                    len, (len > 0) ? kctl->id.name : " ");
+    }
+	else {
 		len = get_term_name(state, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
-
-	if (!len) {
-		strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
+        usb_audio_err(state->chip, "[DEBUG] len:%d, get_term_name:%s\n",
+                    len, (len > 0) ? kctl->id.name : " ");
+		if (!len)
+			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
 		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
@@ -2195,7 +2206,7 @@
 			append_ctl_name(kctl, " Playback Source");
 	}
 
-	usb_audio_dbg(state->chip, "[%d] SU [%s] items = %d\n",
+	usb_audio_err(state->chip, "[%d] SU [%s] items = %d\n",
 		    cval->head.id, kctl->id.name, desc->bNrInPins);
 	return snd_usb_mixer_add_control(&cval->head, kctl);
 }

--------------46573C233A4A93A68565CB6E
Content-Type: text/plain; charset=UTF-8;
 name="amixer_bad.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="amixer_bad.txt"

U2ltcGxlIG1peGVyIGNvbnRyb2wgJ1BDTScsMAogIENhcGFiaWxpdGllczogcHZvbHVtZSBw
c3dpdGNoIHBzd2l0Y2gtam9pbmVkIGVudW0KICBJdGVtczogJ0xpbmUnICdJRUM5NTggSW4n
CiAgSXRlbTA6ICdMaW5lJwogIEl0ZW0xOiAnTGluZScKU2ltcGxlIG1peGVyIGNvbnRyb2wg
J0xpbmUnLDAKICBDYXBhYmlsaXRpZXM6IGN2b2x1bWUgY3N3aXRjaCBjc3dpdGNoLWpvaW5l
ZAogIENhcHR1cmUgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdodAogIExpbWl0
czogQ2FwdHVyZSAwIC0gMTA0CiAgRnJvbnQgTGVmdDogQ2FwdHVyZSAwIFswJV0gWy00MC4w
MGRCXSBbb2ZmXQogIEZyb250IFJpZ2h0OiBDYXB0dXJlIDAgWzAlXSBbLTQwLjAwZEJdIFtv
ZmZdCg==
--------------46573C233A4A93A68565CB6E
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_bad.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg_bad.txt"

WyAgIDU2LjMxNzAzOF0gdXNiIDEtMjogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1i
ZXIgNyB1c2luZyB4aGNpX2hjZApbICAgNTYuNDQwNDI0XSB1c2IgMS0yOiBkZXZpY2UgZGVz
Y3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDU2Ljc3NTMyN10gaW5wdXQ6IEhpRmlt
ZURJWSBBdWRpbyBIaUZpbWVESVkgREFDIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxNC4wL3VzYjEvMS0yLzEtMjoxLjAvMDAwMzoxODUyOjcwMjIuMDAwMy9pbnB1dC9pbnB1
dDIwClsgICA1Ni43NzU2ODldIGhpZC1nZW5lcmljIDAwMDM6MTg1Mjo3MDIyLjAwMDM6IGlu
cHV0LGhpZHJhdzI6IFVTQiBISUQgdjEuMDAgRGV2aWNlIFtIaUZpbWVESVkgQXVkaW8gSGlG
aW1lRElZIERBQ10gb24gdXNiLTAwMDA6MDA6MTQuMC0yL2lucHV0MApbICAgNTYuODc2ODky
XSB1c2IgMS0yOiBbREVCVUddIG5hbWVpZDowLCBsZW46MApbICAgNTYuODc2ODk2XSB1c2Ig
MS0yOiBbREVCVUddIGxlbjozLCBnZXRfdGVybV9uYW1lOlBDTQpbICAgNTYuODc2OTAwXSB1
c2IgMS0yOiBbMTFdIFNVIFtQQ01dIGl0ZW1zID0gMgpbICAgNTYuODc3MzkyXSB1c2Jjb3Jl
OiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHNuZC11c2ItYXVkaW8K
--------------46573C233A4A93A68565CB6E--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
