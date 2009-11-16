From: Javier Kohen <jkohen@users.sourceforge.net>
Subject: Quirk to disable master volume control in PCM2702
Date: Tue, 17 Nov 2009 00:17:10 +0100
Message-ID: <861213340911161517tfb33467i9a4b270c0a548c69@mail.gmail.com>
References: <861213340911161513n53c8b303i67ac2f07db87cddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e2a7d801efb047885351f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D3BA1037FE
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 00:17:11 +0100 (CET)
Received: by ywh28 with SMTP id 28so5360958ywh.16
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 15:17:10 -0800 (PST)
In-Reply-To: <861213340911161513n53c8b303i67ac2f07db87cddc@mail.gmail.com>
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

--0016368e2a7d801efb047885351f
Content-Type: text/plain; charset=ISO-8859-1

[Alan Stern on BCC]

Hi ALSA developers,

I've written the attached patch to disable the master volume control
in this chipset. The datasheet [1] documents two independent channel
volume controls, one master mute control and one master volume
control. However, at least on my device (a Fubar USB DAC), the master
volume control always returns USB stalls when queried for any of its
parameters (min/max/res/cur). All other controls work as expected,
both at the protocol and at the application levels.

Read on for the gory details. Otherwise please take the patch at face
value. I'm ready to make changes if necessary to make it more fitting
to the rest of the code. It would be very appreciated if this can go
into 2.6.32, or in a stable patch shortly after.

Normally I wouldn't give this problem a second thought, since in the
worst case a non-functional control appears in the mixer. Only that
Alan Stern submitted a patch to the USB subsystem during the
development of kernel 2.6.31 that enables the sending of the
Clear-TT-Buffer request to USB hubs on stalls from devices. For some
reason upon receiving the Clear-TT-Buffer the audio goes mute, even
though the kernel keeps sending the audio stream to the device. There
is an ongoing thread on the linux-usb ML where Alan argues that
sending the request is the correct behavior and it shouldn't have the
effect I'm seeing. Since I lack any knowledge of the USB protocol, I
take his word. However, it seems that either the USB specs are wrong,
or my USB hub or the card are buggy.

In the meantime I'm trying to get another hub to compare.
Unfortunately I have to rely on the hub, because the PCM2702 and my
motherboard don't interact well. After a while the sound is degraded,
first into a hiss, then into pure noise. Other users have complained
on different forums; one of the wrote to alsa-user a month ago. I
haven't been able to make any progress to track this issue with usbmon
and ALSA verbose debug messages, to nobody's surprise, since I'm a
complete layman in that area. Any help with this would be appreciated
as well.

[1] http://focus.ti.com/docs/prod/folders/print/pcm2702.html

--0016368e2a7d801efb047885351f
Content-Type: application/octet-stream; name="pcm2702-quirks.diff"
Content-Disposition: attachment; filename="pcm2702-quirks.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g23u0xsr0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi91c2JtaXhlci5jIGIvc291bmQvdXNiL3VzYm1peGVyLmMK
aW5kZXggOWVmY2ZkMC4uNDA2MzE1ZSAxMDA2NDQKLS0tIGEvc291bmQvdXNiL3VzYm1peGVyLmMK
KysrIGIvc291bmQvdXNiL3VzYm1peGVyLmMKQEAgLTEwNzEsNiArMTA3MSwxNiBAQCBzdGF0aWMg
aW50IHBhcnNlX2F1ZGlvX2ZlYXR1cmVfdW5pdChzdHJ1Y3QgbWl4ZXJfYnVpbGQgKnN0YXRlLCBp
bnQgdW5pdGlkLCB1bnNpZwogCWNoYW5uZWxzID0gKGZ0clswXSAtIDcpIC8gY3NpemUgLSAxOwog
CiAJbWFzdGVyX2JpdHMgPSBzbmRfdXNiX2NvbWJpbmVfYnl0ZXMoZnRyICsgNiwgY3NpemUpOwor
CS8qIG1hc3RlciBjb25maWd1cmF0aW9uIHF1aXJrcyAqLworCXN3aXRjaCAoc3RhdGUtPmNoaXAt
PnVzYl9pZCkgeworCWNhc2UgVVNCX0lEKDB4MDhiYiwgMHgyNzAyKToKKwkJc25kX3ByaW50ayhL
RVJOX0lORk8KKwkJCSAgICJtYXN0ZXIgdm9sdW1lIHF1aXJrIGZvciBQQ00yNzAyIGNoaXBcbiIp
OworCQkvKiBkaXNhYmxlIG5vbi1mdW5jdGlvbmFsIHZvbHVtZSBjb250cm9sICovCisJCW1hc3Rl
cl9iaXRzICY9IH4oMSA8PCAoVVNCX0ZFQVRVUkVfVk9MVU1FIC0gMSkpOworCQlicmVhazsKKwor
CX0KIAlpZiAoY2hhbm5lbHMgPiAwKQogCQlmaXJzdF9jaF9iaXRzID0gc25kX3VzYl9jb21iaW5l
X2J5dGVzKGZ0ciArIDYgKyBjc2l6ZSwgY3NpemUpOwogCWVsc2UK
--0016368e2a7d801efb047885351f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016368e2a7d801efb047885351f--
