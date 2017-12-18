From: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mixer regression with usb soundcard
Date: Mon, 18 Dec 2017 22:10:37 +0000
Message-ID: <45384a01-cd74-35d9-db92-7bc27efe85a4@gmail.com>
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
 <ec393c6b-a960-5fb3-f98c-cb2120961d45@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------40819AADDCD6216BA4D33ACC"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ec393c6b-a960-5fb3-f98c-cb2120961d45-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------40819AADDCD6216BA4D33ACC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 18-12-2017 21:56, Mauro Santos wrote:
> On 18-12-2017 19:30, Takashi Iwai wrote:
>> On Mon, 18 Dec 2017 20:10:44 +0100,
>> Mauro Santos wrote:
>>>
>>> On 18-12-2017 17:50, Jaejoong Kim wrote:
>>>> Mauro,
>>>>
>>>> Could you please try debug patch(I also attach the patch file)?
>>>
>>> With the attached patch I get the following when plugging in the usb dac
>>> directly to a usb3 port:
>>> [   54.391539] usb 1-2: new full-speed USB device number 7 using xhci_hcd
>>> [   54.514996] usb 1-2: device descriptor read/64, error -71
>>> [   54.849808] input: HiFimeDIY Audio HiFimeDIY DAC as
>>> /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:1852:7022.0003/input/input20
>>> [   54.850168] hid-generic 0003:1852:7022.0003: input,hidraw2: USB HID
>>> v1.00 Device [HiFimeDIY Audio HiFimeDIY DAC] on usb-0000:00:14.0-2/input0
>>> [   54.950421] usb 1-2: [DEBUG] nameid:0, len:0
>>> [   54.950426] usb 1-2: [DEBUG] len:3, get_term_name:PCM
>>> [   54.950429] usb 1-2: [11] SU [PCM] items = 2
>>> [   54.950985] usbcore: registered new interface driver snd-usb-audio
>>
>> Hmm, the driver get the supposedly correct name string here, so I see
>> no flaw, so far.
>>
>> Could you put the similar debug prints after reverting the commit and
>> compare?  Or, at minimum, you can enable simply the kernel debug
>> prints like below:
>>
>>   % echo "file sound/usb/mixer.c +p" > /sys/kernel/debug/dynamic_debug_control
>>
>> and re-plug the device.
>>
>> Also, could you attach the output of "amixer contents" on both working
>> and non-working kernels?
>>
> 
> I have compiled a new kernel where I have reverted the commit and I've
> added the debug output based on your last debug patch. I attach the
> patch that reverts the changes and adds the debug output just in case
> anyone wants to do a sanity check on it (don't mind the indentation I
> think I botched that).
> 
> With the debug patches I get no extra output when echoing to the
> dynamic_debug/control file, I guess that's expected.
> 
Turns out there is some output, I can't echo and plug, I need to plug,
echo, replug. Dmesg outputs are attached.

> I attach the dmesg and amixer outputs for the case without revert plus
> debug (bad) and revert plus debug (good).
> 
> One change does jump out:
> 
> bad:  usb 1-2: [11] SU [PCM] items = 2
> good: usb 1-2: [11] SU [PCM Capture Source] items = 2
> 


-- 
Mauro Santos

--------------40819AADDCD6216BA4D33ACC
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_replug_bad.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg_replug_bad.txt"

WyAgIDgxLjc1MzcwM10gdXNiIDEtMjogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1i
ZXIgOSB1c2luZyB4aGNpX2hjZApbICAgODEuODc3MTQ4XSB1c2IgMS0yOiBkZXZpY2UgZGVz
Y3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDgyLjIxMDkwN10gaW5wdXQ6IEhpRmlt
ZURJWSBBdWRpbyBIaUZpbWVESVkgREFDIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxNC4wL3VzYjEvMS0yLzEtMjoxLjAvMDAwMzoxODUyOjcwMjIuMDAwNS9pbnB1dC9pbnB1
dDIyClsgICA4Mi4yMTExMjFdIGhpZC1nZW5lcmljIDAwMDM6MTg1Mjo3MDIyLjAwMDU6IGlu
cHV0LGhpZHJhdzI6IFVTQiBISUQgdjEuMDAgRGV2aWNlIFtIaUZpbWVESVkgQXVkaW8gSGlG
aW1lRElZIERBQ10gb24gdXNiLTAwMDA6MDA6MTQuMC0yL2lucHV0MApbICAgODIuMjMxMDQy
XSB1c2IgMS0yOiBbMTZdIEZVIFtQQ00gUGxheWJhY2sgU3dpdGNoXSBjaCA9IDEsIHZhbCA9
IDAvMS8xClsgICA4Mi4yMzIyMTFdIHVzYiAxLTI6IGNhbm5vdCBzZXQgY3RsIHZhbHVlOiBy
ZXEgPSAweDQsIHdWYWx1ZSA9IDB4MjAxLCB3SW5kZXggPSAweDEwMDEsIHR5cGUgPSA0LCBk
YXRhID0gMHg0MC8weDAKWyAgIDgyLjIzMjYxNl0gdXNiIDEtMjogWzE2XSBGVSBbUENNIFBs
YXliYWNrIFZvbHVtZV0gY2ggPSAyLCB2YWwgPSAtMTQwODAvMC8xMjgKWyAgIDgyLjIzMjYy
Nl0gdXNiIDEtMjogWzE0XSBGVSBbTGluZSBDYXB0dXJlIFN3aXRjaF0gY2ggPSAxLCB2YWwg
PSAwLzEvMQpbICAgODIuMjMzOTE5XSB1c2IgMS0yOiBjYW5ub3Qgc2V0IGN0bCB2YWx1ZTog
cmVxID0gMHg0LCB3VmFsdWUgPSAweDIwMSwgd0luZGV4ID0gMHhlMDEsIHR5cGUgPSA0LCBk
YXRhID0gMHg0MC8weDAKWyAgIDgyLjIzNDMwMV0gdXNiIDEtMjogWzE0XSBGVSBbTGluZSBD
YXB0dXJlIFZvbHVtZV0gY2ggPSAyLCB2YWwgPSAtMTAyNDAvMzA3Mi8xMjgKWyAgIDgyLjIz
NDMxMF0gdXNiIDEtMjogW0RFQlVHXSBuYW1laWQ6MCwgbGVuOjAKWyAgIDgyLjIzNDMxM10g
dXNiIDEtMjogW0RFQlVHXSBsZW46MywgZ2V0X3Rlcm1fbmFtZTpQQ00KWyAgIDgyLjIzNDMx
NV0gdXNiIDEtMjogWzExXSBTVSBbUENNXSBpdGVtcyA9IDIK
--------------40819AADDCD6216BA4D33ACC
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_replug_good.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg_replug_good.txt"

WyAgIDU5LjI4MzQxOF0gdXNiIDEtMjogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1i
ZXIgOCB1c2luZyB4aGNpX2hjZApbICAgNTkuNDA3MTE2XSB1c2IgMS0yOiBkZXZpY2UgZGVz
Y3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDU5Ljc0MDY4Nl0gaW5wdXQ6IEhpRmlt
ZURJWSBBdWRpbyBIaUZpbWVESVkgREFDIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxNC4wL3VzYjEvMS0yLzEtMjoxLjAvMDAwMzoxODUyOjcwMjIuMDAwNC9pbnB1dC9pbnB1
dDIxClsgICA1OS43NDA4OTNdIGhpZC1nZW5lcmljIDAwMDM6MTg1Mjo3MDIyLjAwMDQ6IGlu
cHV0LGhpZHJhdzI6IFVTQiBISUQgdjEuMDAgRGV2aWNlIFtIaUZpbWVESVkgQXVkaW8gSGlG
aW1lRElZIERBQ10gb24gdXNiLTAwMDA6MDA6MTQuMC0yL2lucHV0MApbICAgNTkuNzYwOTcx
XSB1c2IgMS0yOiBbMTZdIEZVIFtQQ00gUGxheWJhY2sgU3dpdGNoXSBjaCA9IDEsIHZhbCA9
IDAvMS8xClsgICA1OS43NjIwNTZdIHVzYiAxLTI6IGNhbm5vdCBzZXQgY3RsIHZhbHVlOiBy
ZXEgPSAweDQsIHdWYWx1ZSA9IDB4MjAxLCB3SW5kZXggPSAweDEwMDEsIHR5cGUgPSA0LCBk
YXRhID0gMHg0MC8weDAKWyAgIDU5Ljc2MjQxOF0gdXNiIDEtMjogWzE2XSBGVSBbUENNIFBs
YXliYWNrIFZvbHVtZV0gY2ggPSAyLCB2YWwgPSAtMTQwODAvMC8xMjgKWyAgIDU5Ljc2MjQy
M10gdXNiIDEtMjogWzE0XSBGVSBbTGluZSBDYXB0dXJlIFN3aXRjaF0gY2ggPSAxLCB2YWwg
PSAwLzEvMQpbICAgNTkuNzYzNTEwXSB1c2IgMS0yOiBjYW5ub3Qgc2V0IGN0bCB2YWx1ZTog
cmVxID0gMHg0LCB3VmFsdWUgPSAweDIwMSwgd0luZGV4ID0gMHhlMDEsIHR5cGUgPSA0LCBk
YXRhID0gMHg0MC8weDAKWyAgIDU5Ljc2Mzg0NV0gdXNiIDEtMjogWzE0XSBGVSBbTGluZSBD
YXB0dXJlIFZvbHVtZV0gY2ggPSAyLCB2YWwgPSAtMTAyNDAvMzA3Mi8xMjgKWyAgIDU5Ljc2
Mzg0OF0gdXNiIDEtMjogW0RFQlVHXSBuYW1laWQ6MCwgbGVuOjAKWyAgIDU5Ljc2Mzg0OV0g
dXNiIDEtMjogW0RFQlVHXSBsZW46MywgZ2V0X3Rlcm1fbmFtZTpQQ00KWyAgIDU5Ljc2Mzg1
MF0gdXNiIDEtMjogWzExXSBTVSBbUENNIENhcHR1cmUgU291cmNlXSBpdGVtcyA9IDIK
--------------40819AADDCD6216BA4D33ACC--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
