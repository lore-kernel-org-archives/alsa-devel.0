From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Fri, 12 Jun 2015 18:57:34 +0500
Message-ID: <557AE54E.8030508@gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <CACuU-+gmSj7rw8h6scpokXgMrL8QFr8a+xt2hH-4yLy=3POc5A@mail.gmail.com>
 <557AE213.2010005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010204080502040006040007"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id BDCF526049A
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 15:57:37 +0200 (CEST)
Received: by wibut5 with SMTP id ut5so19656771wib.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 06:57:37 -0700 (PDT)
In-Reply-To: <557AE213.2010005@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun@accosted.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010204080502040006040007
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

sorry, I need to clarify some of my words

12.06.2015 18:43, Alexander E. Patrakov wrote:
> To guarantee the reproducibility of this experiment, the entire system
> (Gentoo stage3 plus PulseAudio plus laptop-mode-tools) has been put in
> the initramfs,

Clarification due to a possible "why PulseAudio" question. I have 
actually reused an old initramfs that I put together in order to measure 
the effect of various resamplers on battery life. Result back then: with 
1s latency, when resampling from 44.1 to 48 kHz, speex-float-5 robs 734 
seconds of battery life, out of 26731, as compared to speex-float-1. 
I.e. less than the battery lost due to 6 months of aging.

The scripts are attached, measure.sh is called from a script in 
/etc/local.d.

> 2. Limiting of the sleep time in the timer-based scheduling logic to a
> similar value. If this ends up below 30 ms, then we can simplify
> PulseAudio by removing all traces of the rewind logic.

I should point out that CRAS (another sound server that implements 
timer-based scheduling, from ChromeOS) has no rewind logic at all, and 
relies on clients not to request insanely large buffer size. Also, it 
contains no batch-card logic.

-- 
Alexander E. Patrakov

--------------010204080502040006040007
Content-Type: application/x-shellscript;
 name="measure.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="measure.sh"

IyEvYmluL2Jhc2gKCmVjaG8gMCA+IC9zeXMvY2xhc3MvZ3JhcGhpY3MvZmJjb24vY3Vyc29y
X2JsaW5rCnNldHRlcm0gLWJsYW5rIGZvcmNlIDwvZGV2L3R0eTAgPi9kZXYvdHR5MApzdGFy
dGRhdGU9YGRhdGUgKyVzYAoKcmVzYW1wbGVfbWV0aG9kPSJzcGVleC1mbG9hdC0xIgpldmFs
IGBncmVwIC1vICdyZXNhbXBsZV9tZXRob2Q9W14gXSonIC9wcm9jL2NtZGxpbmVgCgpzYW1w
bGVfcmF0ZT00NDEwMApldmFsIGBncmVwIC1vICdzYW1wbGVfcmF0ZT1bXiBdKicgL3Byb2Mv
Y21kbGluZWAKCnRlc3RfY2FzZT1wYXBsYXkKZXZhbCBgZ3JlcCAtbyAndGVzdF9jYXNlPVte
IF0qJyAvcHJvYy9jbWRsaW5lYAoKZWNobyAiZGVmYXVsdC1zYW1wbGUtcmF0ZSA9ICRzYW1w
bGVfcmF0ZSIgPj4gL2V0Yy9wdWxzZS9kYWVtb24uY29uZgplY2hvICJhbHRlcm5hdGUtc2Ft
cGxlLXJhdGUgPSAkc2FtcGxlX3JhdGUiID4+IC9ldGMvcHVsc2UvZGFlbW9uLmNvbmYKZWNo
byAicmVzYW1wbGUtbWV0aG9kID0gJHJlc2FtcGxlX21ldGhvZCIgPj4gL2V0Yy9wdWxzZS9k
YWVtb24uY29uZgoKbW91bnQgL2Jvb3QKLiAvYm9vdC9iYXR0ZXJ5LWVhdGVyL3Rlc3RzLyR0
ZXN0X2Nhc2Uuc2gKdW1vdW50IC9ib290CgpwdWxzZWF1ZGlvIC0tc3RhcnQKc2xlZXAgNQpw
dWxzZXBpZD1gcGlkb2YgcHVsc2VhdWRpb2AKCndoaWxlIDo7IGRvCiAgICBub3c9YGRhdGUg
KyVzYAogICAgcmVhZCBlbmVyZ3lfbm93IDwgL3N5cy9jbGFzcy9wb3dlcl9zdXBwbHkvQkFU
MS9lbmVyZ3lfbm93CiAgICBwdWxzZXRpbWVzPWBjdXQgLWQgJyAnIC1mIDE0LDE1IC9wcm9j
LyRwdWxzZXBpZC9zdGF0YAoKICAgIGVjaG8gJCgoICRub3cgLSAkc3RhcnRkYXRlICkpICRl
bmVyZ3lfbm93ICRwdWxzZXRpbWVzID4+IHJlcG9ydC50eHQKICAgIGlmIFsgIiRlbmVyZ3lf
bm93IiAtbHQgMTAwMDAwMCBdIDsgdGhlbgogICAgICAgIG1vdW50IC9ib290CgljcCByZXBv
cnQudHh0IC9ib290L2JhdHRlcnktZWF0ZXIvcmVwb3J0LSRzdGFydGRhdGUudHh0Cgl1bW91
bnQgL2Jvb3QKCXN5bmMKCXBvd2Vyb2ZmCglleGl0CiAgICBmaQogICAgZWF0X2JhdHRlcnkK
ZG9uZQo=
--------------010204080502040006040007
Content-Type: application/x-shellscript;
 name="aplay.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="aplay.sh"

ZWF0X2JhdHRlcnkoKSB7CiAgICAjIEFzIGluIEF1ZGlvRmxpbmdlcgogICAgYXBsYXkgLS1t
bWFwIC1EIGh3OjAgLS1idWZmZXItc2l6ZT00NDAgLS1wZXJpb2Qtc2l6ZT0yMjAgZmlsZS53
YXYKfQo=
--------------010204080502040006040007
Content-Type: application/x-shellscript;
 name="paplay.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="paplay.sh"

ZWF0X2JhdHRlcnkoKSB7CiAgICBwYXBsYXkgLS1sYXRlbmN5LW1zZWM9MTAgZmlsZS53YXYK
fQo=
--------------010204080502040006040007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010204080502040006040007--
