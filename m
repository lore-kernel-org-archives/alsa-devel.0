From: Niels Laukens <niels.laukens@innovatie.vrt.be>
Subject: Can't get capturing from RME Hammerfall MADI card to
 work: sound loops & silcence
Date: Fri, 27 Sep 2013 08:08:59 +0200
Message-ID: <CANYi0v7OD_AFC9-jFeH4MGLZQGsPX91S5NdjqDsmZ_9pOR0hPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1133225281fcf004e7575279
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f45.google.com (mail-vb0-f45.google.com
 [209.85.212.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F055261A29
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 08:09:00 +0200 (CEST)
Received: by mail-vb0-f45.google.com with SMTP id e15so1528875vbg.18
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 23:08:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001a1133225281fcf004e7575279
Content-Type: text/plain; charset=UTF-8

Hi,

I'm trying to capture audio from an RME Hammerfall MADI card (PCI ID
10ee:3fc6). The setup previously worked fine on Windows, so I'm currently
assuming that the card and the input signal is OK.

I wrote a very simple ALSA-application that simply opens the device, sets
the access format to NONINTERLEAVED (which seems to be the only option the
card likes), selects 32bit sampling (although the audio is 24bit, ALSA
rejects this option), 48kHz sampling and 64 channels (also, the only
option the card accepts). Next, it loops with snd_pcm_readn() to get 100ms
worth of audio, and dumps channel 10 to file. (Full source in attachement)

The result is strange for various reasons:

* The second half of every buffer returned by snd_pcm_readn() is always
zero's.

* The call seems to return way to fast: I would expect to get 48000
frames/second, but judging from the timing of the snd_pcm_readn() call,
it's more like 1536000 frames/second (i.e. 32 fold faster).

* When playing back the resulting file, I do recognize some music, but it
sounds like it's the same part over and over again. Also, restarting the
capture program minutes later, returns the same (at least as far as my
ears & brain can recall) fragment of audio.

What am I doing wrong here? (Samples of the PCM-file are available upon
request)


I've also tried a related test with `arecord`, with similar but different
results:

* The audio was also interspersed with silence

* The capture duration did not match the requested '-d' option: the
recording was a factor of 2 shorter than requested.

* There was more audio in the recording: if I manually cut out the silent
parts, the audio sounded reasonable.

What am I missing here?


Is this the right place to ask? Or should this go to the RME forum?


Thanks in advance,
Niels

--001a1133225281fcf004e7575279
Content-Type: text/x-c++src; charset=US-ASCII; name="capture.cpp"
Content-Disposition: attachment; filename="capture.cpp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hm30exts0

I2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CiNpbmNsdWRlIDxpb3N0cmVhbT4KI2luY2x1ZGUg
PHN0cmluZz4KCmludCBtYWluKCkgewoJc3RkOjpzdHJpbmcgZGV2aWNlID0gImh3OjAsMCI7CgoJ
Lyogb3BlbiB0aGUgY2FwdHVyZSBzdHJlYW0gKi8KCXNuZF9wY21fdCAqcGNtX2hhbmRsZTsKCWlu
dCBydiA9IHNuZF9wY21fb3BlbiggJnBjbV9oYW5kbGUsIGRldmljZS5jX3N0cigpLCBTTkRfUENN
X1NUUkVBTV9DQVBUVVJFLCAwKTsKCWlmKCBydiA8IDAgKSB7CgkJc3RkOjpjZXJyIDw8ICJDb3Vs
bid0IG9wZW4gZGV2aWNlIFwiIiA8PCBkZXZpY2UgPDwgIlwiIGZvciBjYXB0dXJlOiAiCgkJCTw8
IHNuZF9zdHJlcnJvcihydikgPDwgc3RkOjplbmRsOwoJCXJldHVybiAxOwoJfQoKCS8qIEdldCBm
dWxsIHBvc3NpYmxlIHBhcmFtZXRlcnMgKi8KCXNuZF9wY21faHdfcGFyYW1zX3QgKmh3X3BhcmFt
czsKCXNuZF9wY21faHdfcGFyYW1zX21hbGxvYygmaHdfcGFyYW1zKTsKCXJ2ID0gc25kX3BjbV9o
d19wYXJhbXNfYW55KHBjbV9oYW5kbGUsIGh3X3BhcmFtcyk7CglpZiggcnYgPCAwICkgewoJCXN0
ZDo6Y2VyciA8PCAiQ291bGRuJ3QgZ2V0IHBhcmFtZXRlci1saXN0OiAiIDw8IHNuZF9zdHJlcnJv
cihydikgPDwgc3RkOjplbmRsOwoJCXJldHVybiAxOwoJfQoKCXJ2ID0gc25kX3BjbV9od19wYXJh
bXNfc2V0X2FjY2VzcyhwY21faGFuZGxlLCBod19wYXJhbXMsIFNORF9QQ01fQUNDRVNTX1JXX05P
TklOVEVSTEVBVkVEKTsKCWlmKCBydiA8IDAgKSB7CgkJc3RkOjpjZXJyIDw8ICJDb3VsZG4ndCBz
ZXQgYWNjZXNzIHRvIFJXX05PTklOVEVSTEVBVkVEOiAiIDw8IHNuZF9zdHJlcnJvcihydikgPDwg
c3RkOjplbmRsOwoJCXJldHVybiAxOwoJfQoJCglydiA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9m
b3JtYXQocGNtX2hhbmRsZSwgaHdfcGFyYW1zLCBTTkRfUENNX0ZPUk1BVF9TMzJfTEUpOwoJaWYo
IHJ2IDwgMCApIHsKCQlzdGQ6OmNlcnIgPDwgIkNvdWxkbid0IHNldCBzYW1wbGUgZm9ybWF0IHRv
IFMzMl9MRTogIiA8PCBzbmRfc3RyZXJyb3IocnYpIDw8IHN0ZDo6ZW5kbDsKCQlyZXR1cm4gMTsK
CX0KCgl1bnNpZ25lZCBpbnQgcmF0ZSA9IDQ4MDAwOwoJcnYgPSBzbmRfcGNtX2h3X3BhcmFtc19z
ZXRfcmF0ZV9uZWFyKHBjbV9oYW5kbGUsIGh3X3BhcmFtcywgJnJhdGUsIE5VTEwpOwoJaWYoIHJ2
IDwgMCApIHsKCQlzdGQ6OmNlcnIgPDwgIkNvdWxkbid0IHNldCBzYW1wbGVyYXRlIHRvICIgPDwg
cmF0ZSA8PCAiOiAiIDw8IHNuZF9zdHJlcnJvcihydikgPDwgc3RkOjplbmRsOwoJCXJldHVybiAx
OwoJfQoJc3RkOjpjZXJyIDw8ICJTYW1wbGVyYXRlID0gIiA8PCByYXRlIDw8IHN0ZDo6ZW5kbDsK
CglydiA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9jaGFubmVscyhwY21faGFuZGxlLCBod19wYXJh
bXMsIDY0KTsKCWlmKCBydiA8IDAgKSB7CgkJc3RkOjpjZXJyIDw8ICJDb3VsZG4ndCBzZXQgY2hh
bm5lbHMgdG8gNjQ6ICIgPDwgc25kX3N0cmVycm9yKHJ2KSA8PCBzdGQ6OmVuZGw7CgkJcmV0dXJu
IDE7Cgl9CgoJLyogY29tbWl0IHRoZSBwYXJhbXMgYW5kIHByZXBhcmUgdGhlIGNhcmQgKi8KCXJ2
ID0gc25kX3BjbV9od19wYXJhbXMocGNtX2hhbmRsZSwgaHdfcGFyYW1zKTsKCWlmKCBydiA8IDAg
KSB7CgkJc3RkOjpjZXJyIDw8ICJDb3VsZG4ndCBhcHBseSBwYXJhbWV0ZXJzOiAiIDw8IHNuZF9z
dHJlcnJvcihydikgPDwgc3RkOjplbmRsOwoJCXJldHVybiAxOwoJfQoKCXNuZF9wY21faHdfcGFy
YW1zX2ZyZWUoIGh3X3BhcmFtcyApOwoKCXZvaWQqIGJ1Zls2NF07CglzaXplX3Qgc2J1ZiA9IDQ4
MDAwICogMzIvNDsKCWZvciggaW50IGkgPSAwOyBpIDwgNjQ7IGkrKyApIHsKCQlidWZbaV0gPSBt
YWxsb2Moc2J1Zik7CgkJaWYoIGJ1ZltpXSA9PSBOVUxMICkgewoJCQlzdGQ6OmNlcnIgPDwgIkNv
dWxkbid0IG1hbGxvYygpIiA8PCBzdGQ6OmVuZGw7CgkJCXJldHVybiAxOwoJCX0KCX0KCgl1bnNp
Z25lZCBsb25nIGk9MzAwOwoJd2hpbGUoaS0tKSB7CgkJcnYgPSBzbmRfcGNtX3JlYWRuKHBjbV9o
YW5kbGUsIGJ1ZiwgNDgwMDAvMTApOwoKCQlpZiggcnYgPT0gLTMyICkgewoJCQlzdGQ6OmNlcnIg
PDwgIm92ZXJydW4iIDw8IHN0ZDo6ZW5kbDsKCQkJc25kX3BjbV9wcmVwYXJlKHBjbV9oYW5kbGUp
OwoJCQljb250aW51ZTsKCQl9CgkJaWYoIHJ2IDwgMCApIHsKCQkJc3RkOjpjZXJyIDw8ICJyZWFk
bigpIGZhaWxlZDogIiA8PCBydiA8PCAiICIgPDwgc25kX3N0cmVycm9yKHJ2KSA8PCBzdGQ6OmVu
ZGw7CgkJCXJldHVybiAxOwoJCX0KCQkKCQl3cml0ZSgxLCBidWZbMTBdLCBydiAqIDMyLzgpOwoJ
fQoJc3RkOjpjZXJyIDw8IHN0ZDo6ZW5kbDsKCglzbmRfcGNtX2Nsb3NlKHBjbV9oYW5kbGUpOwoJ
Zm9yKCBpbnQgaSA9IDA7IGkgPCA2NDsgaSsrICkgewoJCWZyZWUoIGJ1ZltpXSApOwoJfQp9Cg==
--001a1133225281fcf004e7575279
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a1133225281fcf004e7575279--
