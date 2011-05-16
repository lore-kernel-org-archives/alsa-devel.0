From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Mon, 16 May 2011 08:48:11 +0200
Message-ID: <BANLkTimWSVAGNmfxpXPTWsWAx-MH8WU5KQ@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTinFu=NLm+8dkM8h_KLMT=PtrutjYg@mail.gmail.com>
	<BANLkTik5LMFp-W2q9yhadPdJwswYXUbDgA@mail.gmail.com>
	<BANLkTimuaynDA+0wq9kqwizL5kp+b+AuLA@mail.gmail.com>
	<BANLkTiksbKfS5QdOobDn=2=o3EwrcYXMtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd33104f53a0304a35f0969
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id A9265244BB
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 08:48:12 +0200 (CEST)
Received: by pzk26 with SMTP id 26so2376984pzk.38
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 23:48:11 -0700 (PDT)
In-Reply-To: <BANLkTiksbKfS5QdOobDn=2=o3EwrcYXMtA@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

--000e0cd33104f53a0304a35f0969
Content-Type: text/plain; charset=ISO-8859-1

On Mon, May 16, 2011 at 4:55 AM, Grant Diffey <gdiffey@gmail.com> wrote:
> On Mon, May 16, 2011 at 7:30 AM, Daniel Mack <zonque@gmail.com> wrote:
>> Attached is a patch that adds some debug output. If you could apply
>> that and report what the kernel logs during the probe of the device,
>> that would be appreciated.
>>
>>
> Nothing is leaping out at me after building with he patch above...

Ok, so the reason is clear now to me and it has to do with the way the
device is matched by the driver. Basically, the only thing the drivers
matches on is a standard audio control interface. If that is found,
the USB core calls it to handle that specific interface. Once a
control header is found, it is iterated and MIDI devices are created
when a specific interface associated to the control header is found.

The problem in your case is that the device is matched with a
USB_DEVICE() macro now with no further hints in the quirks table,
which makes the USB core hand over the whole device to the driver, and
not individual interfaces. Because the assumption is that if a driver
announces to handle the whole thing, it knows what it's doing.

In the USB audio driver though, we handle that case by defining a fix
behaviour, which is that only interfaces listed in the quirk are
actually being looked at.

In earlier versions of the driver, the whole quirk for this device was
missing, and hence the last, more generic quirk to look for
MIDI_STREAMING interfaces was applied (the last one in
quirks-table.h). Hence it worked back then but not today.

The solution is most probably rather simple by handling the Fasttrack
as composite device that has non-standard and standard interfaces
mixed. There is a macro for that which we just need to use.

Can you give the attached patch a change?

HTH,
Daniel

--000e0cd33104f53a0304a35f0969
Content-Type: application/octet-stream; name="fasttrack-composite.diff"
Content-Disposition: attachment; filename="fasttrack-composite.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnr1usvb0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MtdGFibGUuaCBiL3NvdW5kL3VzYi9xdWlya3Mt
dGFibGUuaAppbmRleCBhNTZmYmQ4Li5kOGM0N2YyIDEwMDY0NAotLS0gYS9zb3VuZC91c2IvcXVp
cmtzLXRhYmxlLmgKKysrIGIvc291bmQvdXNiL3F1aXJrcy10YWJsZS5oCkBAIC0xOTc5LDcgKzE5
NzksNyBAQCBZQU1BSEFfREVWSUNFKDB4NzAxMCwgIlVCOTkiKSwKIAl9CiB9LAogewotCVVTQl9E
RVZJQ0UoMHgwNzYzLCAweDIwODApLAorCVVTQl9ERVZJQ0VfVkVORE9SX1NQRUMoMHgwNzYzLCAw
eDIwODApLAogCS5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSAmIChjb25zdCBzdHJ1Y3Qg
c25kX3VzYl9hdWRpb19xdWlyaykgewogCQkvKiAudmVuZG9yX25hbWUgPSAiTS1BdWRpbyIsICov
CiAJCS8qIC5wcm9kdWN0X25hbWUgPSAiRmFzdCBUcmFjayBVbHRyYSIsICovCg==
--000e0cd33104f53a0304a35f0969
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000e0cd33104f53a0304a35f0969--
