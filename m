From: Daniel Drake <dsd@laptop.org>
Subject: Re: Handling HDA FIFO error
Date: Sat, 25 May 2013 08:08:14 -0600
Message-ID: <CAMLZHHRfUJCCEpkFJ83w+8Bt3T1KVvWhXGuzE77jRE04UcYz6w@mail.gmail.com>
References: <CAMLZHHT8Q4iV5Ug8s6XyA1-LNWUe+WH3a0jEqHTbXYC-ihzy7w@mail.gmail.com>
 <519350A7.3000606@ladisch.de> <s5hobccmu6i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2b55c514ee904dd8b72e2
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f46.google.com (mail-qe0-f46.google.com
 [209.85.128.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D145D2610C4
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2013 16:08:15 +0200 (CEST)
Received: by mail-qe0-f46.google.com with SMTP id 1so3015494qee.33
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2013 07:08:15 -0700 (PDT)
In-Reply-To: <s5hobccmu6i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

--001a11c2b55c514ee904dd8b72e2
Content-Type: text/plain; charset=ISO-8859-1

On Wed, May 15, 2013 at 4:08 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 15 May 2013 11:08:55 +0200,
> Clemens Ladisch wrote:
>> Daniel Drake wrote:
>> > Digging into the HDA code, I can see that normally, when the stream
>> > gets started, we get interrupts with SD_STS as 0x24. In the failure
>> > case, as soon as we start the stream, we get a flood of interrupts
>> > with SD_STS 0x8 - which indicates FIFO error.
>> >
>> > Disabling interrupt generation upon FIFO error does not help much - it
>> > avoids the flood of interrupts, but doesn't change the fact that audio
>> > playing apps hang or loop infinitely.
>> >
>> > Are there any things I could check that would explain why a FIFO error
>> > might be occurring?
>>
>> Probably a buffer underrun, i.e., the controller did not manage to
>> read samples from memory fast enough.

That would seem logical, but I don't think this can be happening here.
In this case the audio buffer is filled up with data before playback
is started, and it only auto-starts right at the point when the buffer
becomes full. Then immediately, the first interrupt that comes in says
"FIFO error". The buffer was full at this point.

However I was unable to reproduce this FIFO error interrupt when
revisiting the problem. Every time I go back to it with my test case
of calling gst-launch in a loop, a different audio-related problem
seems to pop up.

Digging further, I found some oddness with the device being powered up
and down at the wrong times. I'm on Linux-3.3 here, so I threw in a
load of the newer commits that fix the CONFIG_SND_HDA_POWER_SAVE
functionality and now things seem to be working perfectly. Sorry for
the noise and thanks for already having fixed this :)

Here is a patch anyway which could be used to handle the FIFO error
interrupt. It hasn't reappeared so I haven't been able to test it.

Thanks,
Daniel

--001a11c2b55c514ee904dd8b72e2
Content-Type: text/plain; charset=US-ASCII; name="0001-ALSA-HDA-handle-FIFO-errors.txt"
Content-Disposition: attachment;
	filename="0001-ALSA-HDA-handle-FIFO-errors.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hh4veref0

RnJvbSBiYTA1N2FiZTkwOWRmN2UyYjlmYmE1N2UwZGI5ODllN2VhNDc5NTFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgRHJha2UgPGRzZEBsYXB0b3Aub3JnPgpEYXRlOiBU
dWUsIDIxIE1heSAyMDEzIDEzOjAyOjM5IC0wNjAwClN1YmplY3Q6IFtQQVRDSF0gQUxTQTogSERB
OiBoYW5kbGUgRklGTyBlcnJvcnMKClRoZSBIREEgY29kZSB3YXMgbGlzdGVuaW5nIGZvciB0aGUg
RklGTyBlcnJvciBpbnRlcnJ1cHQgYnV0IG5vdCBoYW5kbGluZwppdC4gU3VjaCBjb25kaXRpb24g
d291bGQgdGVuZCB0byBpbmRpY2F0ZSBhbiB4cnVuLgoKT24gT0xQQyBYTy0xLjc1IChWSUEgVlg4
NTUpIHRoaXMgaW50ZXJydXB0IHNlZW1zIHRvIGJlIGVycm9uZW91c2x5IHJhaXNlZApvbiBvY2Nh
c2lvbiwgcmVzdWx0aW5nIGluIGEgaGFsdCBvZiBzb3VuZCBwbGF5YmFjayBhbmQgdGhlIGFwcGxp
Y2F0aW9uCmhhbmdpbmcgYXMgbm8gc291bmQgYnVmZmVyIHNwYWNlIGJlY29tZXMgYXZhaWxhYmxl
LgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIERyYWtlIDxkc2RAbGFwdG9wLm9yZz4KLS0tCiBzb3Vu
ZC9wY2kvaGRhL2hkYV9pbnRlbC5jIHwgMTYgKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQv
cGNpL2hkYS9oZGFfaW50ZWwuYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKaW5kZXggZGU2
NWZhOC4uYzNlZjM3NiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYworKysg
Yi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCkBAIC0xMjM3LDggKzEyMzcsMjAgQEAgc3RhdGlj
IGlycXJldHVybl90IGF6eF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQogCQlpZiAo
c3RhdHVzICYgYXp4X2Rldi0+c2RfaW50X3N0YV9tYXNrKSB7CiAJCQlzZF9zdGF0dXMgPSBhenhf
c2RfcmVhZGIoYXp4X2RldiwgU0RfU1RTKTsKIAkJCWF6eF9zZF93cml0ZWIoYXp4X2RldiwgU0Rf
U1RTLCBTRF9JTlRfTUFTSyk7Ci0JCQlpZiAoIWF6eF9kZXYtPnN1YnN0cmVhbSB8fCAhYXp4X2Rl
di0+cnVubmluZyB8fAotCQkJICAgICEoc2Rfc3RhdHVzICYgU0RfSU5UX0NPTVBMRVRFKSkKKwkJ
CWlmICghYXp4X2Rldi0+c3Vic3RyZWFtIHx8ICFhenhfZGV2LT5ydW5uaW5nKQorCQkJCWNvbnRp
bnVlOworCisJCQlpZiAoc2Rfc3RhdHVzICYgU0RfSU5UX0ZJRk9fRVJSKSB7CisJCQkJc25kX3Bj
bV9zdHJlYW1fbG9jayhhenhfZGV2LT5zdWJzdHJlYW0pOworCQkJCXNwaW5fdW5sb2NrKCZjaGlw
LT5yZWdfbG9jayk7CisJCQkJc25kX3BjbV9zdG9wKGF6eF9kZXYtPnN1YnN0cmVhbSwKKwkJCQkJ
ICAgICBTTkRSVl9QQ01fU1RBVEVfWFJVTik7CisJCQkJc3Bpbl9sb2NrKCZjaGlwLT5yZWdfbG9j
ayk7CisJCQkJc25kX3BjbV9zdHJlYW1fdW5sb2NrKGF6eF9kZXYtPnN1YnN0cmVhbSk7CisJCQkJ
Y29udGludWU7CisJCQl9CisKKwkJCWlmICghKHNkX3N0YXR1cyAmIFNEX0lOVF9DT01QTEVURSkp
CiAJCQkJY29udGludWU7CiAJCQkvKiBjaGVjayB3aGV0aGVyIHRoaXMgSVJRIGlzIHJlYWxseSBh
Y2NlcHRhYmxlICovCiAJCQlvayA9IGF6eF9wb3NpdGlvbl9vayhjaGlwLCBhenhfZGV2KTsKLS0g
CjEuOC4xLjQKCg==
--001a11c2b55c514ee904dd8b72e2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11c2b55c514ee904dd8b72e2--
