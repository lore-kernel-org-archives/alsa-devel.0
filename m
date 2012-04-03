From: David Alexander <lidxv0n@gmail.com>
Subject: Re: trying to get an eleven rack to work
Date: Tue, 3 Apr 2012 11:36:31 -0400
Message-ID: <CAOyn=DF7+dfizJsxJUkwsbZsV-sO9LwbhJbp7s7o2v24Rc2Yqg@mail.gmail.com>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
	<4F6883F9.4010405@ladisch.de>
	<CACckToUeX7oJmQ9NeRLGecxOxWaLpxbZDnNWA0+t5+XxFvf+FQ@mail.gmail.com>
	<4F718114.5020602@ladisch.de>
	<CAOyn=DFig0m1zFRWyTE6Neimrcy12PPAoNL8BdFVaAUrYEYbGw@mail.gmail.com>
	<4F740A6A.3030608@ladisch.de>
	<CAOyn=DGYAr5kCPTRcf=QN8ypMZy3SWpN--zvKBevWcr4Tnqr_w@mail.gmail.com>
	<CAOyn=DGXcm+0RfuNj5G+BvgrwofpO6TROsKRLiekNxW8FUupFg@mail.gmail.com>
	<CACckToX-kqDyM6sFW_9in64cgO5RQekA-J=EEHSXxgsxEuMk=Q@mail.gmail.com>
	<CAOyn=DGw0U572nKkEsGQ-KoZ_CfBsYbu5vBzxmZ+1Kjwu0d6_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B9C1104272
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 17:36:35 +0200 (CEST)
Received: by yenl1 with SMTP id l1so1893522yen.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2012 08:36:32 -0700 (PDT)
In-Reply-To: <CAOyn=DGw0U572nKkEsGQ-KoZ_CfBsYbu5vBzxmZ+1Kjwu0d6_w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grant & Clemens,

I have come across some code written for another device by the same
company for another product (Digidesign MBox 2).  It appears that for
this other device to function there is a boot sequence that needs to
be sent to the device to work.  From the comments in the code:
/* From USB Snoop,
                 *
                 * SetupPacket =3D RT RQ VHVL INDX SIZE
                 * RT =3D 0xRT Request Type
                 * RQ =3D 0xRQ Request
                 * VHVL =3D 0xVLVH Value in reverse byte order
                 * INDX =3D 0xDXIN Index in reverse byte order
                 * SIZE =3D 0xZESI Size in reverse byte order
                 *
                 * Magic boot code setup packet: c0 85 01 00 00 00 12 00
                 *           RQ    RT    VLVH    DXIN                 ZESI
                 * becomes 0x85, 0xc0, 0x0001, 0x0000, &RETURNDATA,
0x0012, TIMEOUT
                 * for snd_usb_ctl_msg()
                 */

I have a logfile from a usb snoop on windows and was wondering if you
could give me any pointers of what to look for if something like this
is also required for the eleven rack device.  I see a
urb_function_select_configuration, and many
urb_function_control_transfer with data that says the data is going
from the host to device.   Can you offer any suggestions as to
anything I should be looking for that might be outside of what is
"normal" and requires some sort of data string be sent to the device
to get it to operate normally?

Thank you,
David






On Mon, Apr 2, 2012 at 1:50 PM, David Alexander <lidxv0n@gmail.com> wrote:
> Grant,
>
> I had an entry using the USB_DEVICE which is very similar to the one
> you suggested. =A0I changed it over to the USB_DEVICE_VENDOR_SPEC you
> had listed.
>
> I am getting:
>
> [ =A0 60.952067] usb 2-4: new high speed USB device number 2 using ehci_h=
cd
> [ =A0 61.468413] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
> [ =A0 61.468433] snd-usb-audio: probe of 2-4:1.1 failed with error -5
> [ =A0 61.469257] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
> [ =A0 61.469266] snd-usb-audio: probe of 2-4:1.3 failed with error -5
> [ =A0 61.469280] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
> [ =A0 61.469285] snd-usb-audio: probe of 2-4:1.4 failed with error -5
> [ =A0 61.469305] usbcore: registered new interface driver snd-usb-audio
>
> and I have entries in /proc/asound as before:
>
> ls -l
> total 0
> -r--r--r-- 1 root root 0 2012-04-02 13:47 id
> -r--r--r-- 1 root root 0 2012-04-02 13:47 midi0
> -r--r--r-- 1 root root 0 2012-04-02 13:47 usbbus
> -r--r--r-- 1 root root 0 2012-04-02 13:47 usbid
>
> Those entries had disappeared after making the changed to mixer.c.
>
> It didn't seem to be the magic bullet though, as I need some sort of
> pcm entries to be created? =A0 What is the difference between the
> usb_device and usb_device_vendor_spec? =A0 Any other ideas?
>
> thanks,
> David
>
> On Fri, Mar 30, 2012 at 5:02 PM, Grant Diffey <gdiffey@gmail.com> wrote:
>>
>> On Sat, Mar 31, 2012 at 4:27 AM, David Alexander <lidxv0n@gmail.com> wro=
te:
>>>
>>> Grant,
>>>
>>> You had mentioned something about the end point for the mixer. =A0I have
>>> found this information from the trace I had performed:
>>>
>>> From a dispatch urb_function_get_descriptor_from_device message under
>>> the fid_USBPORT_Endpoint_Descriptor:
>>>
>>> fid_bLength 7
>>> fid_bDescriptortype 5
>>> fid_bEndpointAddress 0
>>> fid_bmAttributes 0
>>> fid_wMaxPacketSize 64
>>> fid_bInterval 0
>>>
>>> Is this what you were asking about, and does it help us?
>>>
>>> thanks,
>>> David
>>>
>>>
>>>
>>
>> What does the quirk look like that you have now? because what I wrote was
>> wrong.
>>
>> it seems I can't count to 5 :)
>>
>> so based on what Clemens said and me re-reading the interface descriptor
>>
>> Interface 0 is dfu upload
>> Interface 1 is a mixer
>>
>> Interface 2 is the midi
>> Interface 3 is audio output
>> Interface 4 is audio Input and provides clock data for output
>>
>> 0 and 2 were previously recognised so do not need to be quirked.
>>
>> so I think this is what the quirk should look like:
>>
>>
>> USB_DEVICE_VENDOR_SPEC(0x0dba, 0xb011),
>>
>> =A0 =A0 =A0 =A0.driver_info =3D (unsigned long) & (const struct snd_usb_=
audio_quirk) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vendor_name =3D "Digidesign",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.product_name =3D "Eleven Rack",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 .ifnum =3D QUIRK_ANY_INTERFACE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =3D QUIRK_COMPOSITE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.data =3D & (const struct snd_usb_audio_q=
uirk[]) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ifnum =
=3D 1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =3D=
 QUIRK_AUDIO_STANDARD_MIXER
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ifnum =
=3D 3,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =3D=
 QUIRK_AUDIO_STANDARD_INTERFACE
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ifnum =
=3D 4,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =3D=
 QUIRK_AUDIO_STANDARD_INTERFACE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ifnum =
=3D -1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>> }
>>
>> is that similar to what you have?
>>
>> Grant.
>>
