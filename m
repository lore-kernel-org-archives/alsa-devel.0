From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] alsa-tools : hwmixvolume - update README for
	au88x0
Date: Sun, 11 Mar 2012 11:48:53 +0800
Message-ID: <CAN8cciav4d8L5R=qy+jef-LraODkv5dDeUFY+ySGYmoT-7S47w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0444803525dc8304baef8154
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A4C0124473
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 04:48:56 +0100 (CET)
Received: by werg1 with SMTP id g1so2333941wer.38
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 19:48:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--f46d0444803525dc8304baef8154
Content-Type: text/plain; charset=UTF-8

2012/1/24, Takashi Iwai <tiwai@suse.de>:
> At Tue, 17 Jan 2012 12:05:11 +0800,
> Raymond Yau wrote:
>>
>> [PATCH] ALSA Au88x0 - Implement subdevice volume controls
>>
>> - add "PCM Playback Volume" controls for 16 playback subdevices
>>   This allow application to change the volume of each subdevice
>>   by using hardware mixer of au88x0 and default is zero gain/attenunation.
>
> Applied this, but to the branch for the next (3.4) kernel,
> as this is no urgent "fix".
>
>

[PATCH] alsa-tools: hwmixvolume - update README for au88x0

  Need to use alsa-driver kernel 3.4 for Aureal sound cards
* Aureal Vortex/Vortex2/Advantage (driver: snd-au8820, snd-au8830, snd-au8810)

--f46d0444803525dc8304baef8154
Content-Type: application/octet-stream;
	name="0001-alsa-tools-hwmixvolume-update-README-for-au88x0.patch"
Content-Disposition: attachment;
	filename="0001-alsa-tools-hwmixvolume-update-README-for-au88x0.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

RnJvbSAyN2ZiY2ZmY2Y3MzBmZTk3NDU5OTBhZTMzOWYyZGUwNzJhMzlhNDMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBTdW4sIDExIE1hciAyMDEyIDExOjM3OjIyICswODAwClN1YmplY3Q6IFtQQVRD
SCAxLzFdIGFsc2EtdG9vbHM6IGh3bWl4dm9sdW1lIC0gdXBkYXRlIFJFQURNRSBmb3IgYXU4OHgw
CgotIE5lZWQgdG8gdXNlIGFsc2EtZHJpdmVyIGtlcm5lbCAzLjQgZm9yIEF1cmVhbCBzb3VuZCBj
YXJkcwoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52b3J0ZXgyQGdtYWls
LmNvbT4KCmRpZmYgLS1naXQgYS9od21peHZvbHVtZS9SRUFETUUgYi9od21peHZvbHVtZS9SRUFE
TUUKaW5kZXggOTZiYjBiNC4uOTg4NGVjMiAxMDA2NDQKLS0tIGEvaHdtaXh2b2x1bWUvUkVBRE1F
CisrKyBiL2h3bWl4dm9sdW1lL1JFQURNRQpAQCAtMTMsNSArMTMsNyBAQCBUaGlzIHRvb2wgcmVx
dWlyZXMgUHl0aG9uLCBweWd0aywgYW5kIGFsc2EtcHl0b24gMS4wLjIyIG9yIGxhdGVyLgogSXQg
aXMgcmVjb21tZW5kZWQgdG8gdXNlIGF0IGxlYXN0IExpbnV4IGtlcm5lbCAyLjYuMzIgb3IgYWxz
YS1kcml2ZXIgMS4wLjIyOwogb3RoZXJ3aXNlLCB0aGUgbmFtZSBvZiB0aGUgcHJvZ3JhbSB0aGF0
IGlzIHVzaW5nIGEgc3RyZWFtIGNhbm5vdCBiZSBzaG93bi4KIAorTmVlZCB0byB1c2UgYWxzYS1k
cml2ZXIga2VybmVsIDMuNCBmb3IgQXVyZWFsIHNvdW5kIGNhcmRzCisqIEF1cmVhbCBWb3J0ZXgv
Vm9ydGV4Mi9BZHZhbnRhZ2UgKGRyaXZlcjogc25kLWF1ODgyMCwgc25kLWF1ODgzMCwgc25kLWF1
ODgxMCkKIAogQXV0aG9yOiBDbGVtZW5zIExhZGlzY2ggPGNsZW1lbnNAbGFkaXNjaC5kZT4KLS0g
CjEuNi4wLjYKCg==
--f46d0444803525dc8304baef8154
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d0444803525dc8304baef8154--
