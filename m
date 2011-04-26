From: Grant Diffey <gdiffey@gmail.com>
Subject: [PATCH] Re: Small Regression in midi for M-Audio Fast
 Track Ultra.
Date: Tue, 26 Apr 2011 19:42:06 +1000
Message-ID: <BANLkTim8J09R2MQ-6GoPno_x6cBzXyOYxQ@mail.gmail.com>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
	<4DAC0158.6090400@ladisch.de> <4DAC0468.4000705@showlabor.de>
	<4DAF4148.5050600@showlabor.de>
	<BANLkTi=SCB8-HAvwdK-4MiZ6eTA7Pu3v+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502d396240cfc04a1cf23fd
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA82103885
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 11:42:07 +0200 (CEST)
Received: by eyg5 with SMTP id 5so136778eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 02:42:07 -0700 (PDT)
In-Reply-To: <BANLkTi=SCB8-HAvwdK-4MiZ6eTA7Pu3v+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

--00504502d396240cfc04a1cf23fd
Content-Type: text/plain; charset=ISO-8859-1

oh here's a git patch if that helps

On Tue, Apr 26, 2011 at 7:17 PM, Grant Diffey <gdiffey@gmail.com> wrote:

> So I finally got around to building a new kernel today.
>
> and after rebooting I get:
>
> [  131.832084] usb 2-1: new high speed USB device using ehci_hcd and
> address 3
> [  131.969795] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint 0x7
> has invalid maxpacket 8
> [  131.969800] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint
> 0x87 has invalid maxpacket 8
> [  131.970886] usb 2-1: New USB device found, idVendor=0763, idProduct=2080
> [  131.970890] usb 2-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [  131.970892] usb 2-1: Product: Fast Track Ultra
> [  131.970894] usb 2-1: Manufacturer: M-Audio
> [  132.060121] usbcore: registered new interface driver snd-usb-audio
> nevyn@cetacea:~$ amidi -l
> Dir Device    Name
> IO  hw:1,0,0  Fast Track Ultra MIDI 1
>
> Which is excellent and solves my problem.
>
> now to find and apply that mixer patch.
>
> Grant.
>
>
>
> On Thu, Apr 21, 2011 at 6:25 AM, Felix Homann <linuxaudio@showlabor.de>wrote:
>
>> Sorry, Clemens,
>>
>> I must have messed around with too many Alsa versions on my machine,
>> again.
>> Your suggested fix _does_ fix the issue!
>>
>> Would you mind adding this to the git tree? Or shall I prepare a patch?
>>
>>
>> Am 18.04.2011 11:16, schrieb Clemens Ladisch:
>>
>>> Try replacing the comment with:
>>>>                        {
>>>>                                .iface = 3,
>>>>                                .type = QUIRK_MIDI_STANDARD_INTERFACE
>>>>                        },
>>>>
>>>>
>> In the meantime I started a bisect session on the mainline kernel. The
>> cause of this issue lies in the refactoring done last year. I couldn't
>> identify the exact patch introducing the regression, though, since starting
>> at step 10 the kernels would not boot. See the corresponding git bisect log
>> (the last revision is the first one that would not boot).
>>
>> Regards,
>>
>> Felix
>>
>
>

--00504502d396240cfc04a1cf23fd
Content-Type: text/x-diff; charset=US-ASCII; name="FastTrackUltra_MIDI_Quirk.patch"
Content-Disposition: attachment; filename="FastTrackUltra_MIDI_Quirk.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmynclvl0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MtdGFibGUuaCBiL3NvdW5kL3VzYi9xdWlya3Mt
dGFibGUuaAppbmRleCA5MjFhODZmLi42YTI1MTAxIDEwMDY0NAotLS0gYS9zb3VuZC91c2IvcXVp
cmtzLXRhYmxlLmgKKysrIGIvc291bmQvdXNiL3F1aXJrcy10YWJsZS5oCkBAIC0xOTcyLDcgKzE5
NzIsMTAgQEAgWUFNQUhBX0RFVklDRSgweDcwMTAsICJVQjk5IiksCiAJCQkJCX0KIAkJCQl9CiAJ
CQl9LAotCQkJLyogaW50ZXJmYWNlIDMgKE1JREkpIGlzIHN0YW5kYXJkIGNvbXBsaWFudCAqLwor
CQkJeworCQkJCS5pZm51bSA9IDMsCisJCQkJLnR5cGUgPSBRVUlSS19NSURJX1NUQU5EQVJEX0lO
VEVSRkFDRQorCQkJfSwKIAkJCXsKIAkJCQkuaWZudW0gPSAtMQogCQkJfQpAQCAtMjAzOSw3ICsy
MDQyLDEwIEBAIFlBTUFIQV9ERVZJQ0UoMHg3MDEwLCAiVUI5OSIpLAogCQkJCQl9CiAJCQkJfQog
CQkJfSwKLQkJCS8qIGludGVyZmFjZSAzIChNSURJKSBpcyBzdGFuZGFyZCBjb21wbGlhbnQgKi8K
KwkJCXsKKwkJCQkuaWZudW0gPSAzLAorCQkJCS50eXBlID0gUVVJUktfTUlESV9TVEFOREFSRF9J
TlRFUkZBQ0UKKwkJCX0sCiAJCQl7CiAJCQkJLmlmbnVtID0gLTEKIAkJCX0K
--00504502d396240cfc04a1cf23fd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00504502d396240cfc04a1cf23fd--
