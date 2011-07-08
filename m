From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Fri, 8 Jul 2011 17:13:08 +0200
Message-ID: <CACTFLAPztC8m4WhUdAxQyKu0F9croLK03q6c7=MbA=VqPer+6g@mail.gmail.com>
References: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com>
	<201107071433.42081.oliver@neukum.org>
	<CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg@mail.gmail.com>
	<201107071508.43988.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=005045029d08685d2204a79045ac
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201107071508.43988.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--005045029d08685d2204a79045ac
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 7, 2011 at 3:08 PM, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org> wrote:
> Am Donnerstag, 7. Juli 2011, 14:38:51 schrieb Daniel Mack:
>> On Thu, Jul 7, 2011 at 2:33 PM, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org> wrote:
>>
>> > PS: =A0Do you still see this if you enable 64bit DMA for EHCI?
>>
>> The problem is that I personally don't see that issue at all. I even
>> installed 4GB of RAM to my development machine last year to be able to
>> reproduce this, but I can't, even when the memory allocator is under
>> heavy load. The only people who see this effect are Pedro Ribeiro and
>> William Light (both in Cc:), and both have been very helpful in trying
>> patches and reporting back in detail. Which instructions could we
>> probably give to these people to finally hunt this issue down?
>
> Do they have an IOMMU or are they using bounce buffers?
> If the latter, you might be able to reproduce it if you disable your
> IOMMU.

Ok, Pedro and William - can I ask you to dump the following
information to some paste bin:

- your .config
- the dmesg output of a booted kernel that shows the effect
- the output of "sudo lspci -v"

Also, the attached patch might give you at least one warning to your
kernel logs once the audio stream starts and outputs noise. I'm
curious whether it really does.

Thanks,
Daniel

--005045029d08685d2204a79045ac
Content-Type: text/x-patch; charset=US-ASCII; name="ehci-32bit-debug.diff"
Content-Disposition: attachment; filename="ehci-32bit-debug.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpvaakgo0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1zY2hlZC5jIGIvZHJpdmVycy91c2Iv
aG9zdC9laGNpLXNjaGVkLmMKaW5kZXggNmM5ZmJlMy4uNDI2MGY3OCAxMDA2NDQKLS0tIGEvZHJp
dmVycy91c2IvaG9zdC9laGNpLXNjaGVkLmMKKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLXNj
aGVkLmMKQEAgLTExODgsNiArMTE4OCw5IEBAIGl0ZF9zY2hlZF9pbml0KAogCQl0cmFucyB8PSBs
ZW5ndGggPDwgMTY7CiAJCXVmcmFtZS0+dHJhbnNhY3Rpb24gPSBjcHVfdG9faGMzMihlaGNpLCB0
cmFucyk7CiAKKwkJV0FSTl9PTkNFKCh1NjQpYnVmICYgKHU2NCkgMHhmZmYsICJYWFhYWCBVUkIg
RE1BICUwMTZ4IGlzIG5vdCA0ay1hbGlnbmVkIiwgKHU2NCkgYnVmKTsKKwkJV0FSTl9PTkNFKCh1
NjQpYnVmICYgMHhmZmZmZmZmZjAwMDAwMDAwVUxMLCAiWFhYWFggVVJCIERNQSAlMDE2eCBoYXMg
dXBwZXIgMzJiaXQgc2V0IiwgKHU2NCkgYnVmKTsKKwogCQkvKiBtaWdodCBuZWVkIHRvIGNyb3Nz
IGEgYnVmZmVyIHBhZ2Ugd2l0aGluIGEgdWZyYW1lICovCiAJCXVmcmFtZS0+YnVmcCA9IChidWYg
JiB+KHU2NCkweDBmZmYpOwogCQlidWYgKz0gbGVuZ3RoOwo=
--005045029d08685d2204a79045ac--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
