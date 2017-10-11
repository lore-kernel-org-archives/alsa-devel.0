From: =?UTF-8?B?0JLQu9Cw0LTQuNC80LjRgCDQnNCw0YDRgtGM0Y/QvdC+0LI=?=
 <vilgeforce@gmail.com>
Subject: Click sound when playing "silence" buffer
Date: Wed, 11 Oct 2017 22:16:50 +0300
Message-ID: <CAL5iTPJNUC7EHUdPNWq4+xfU-8eHm7N1ee34aguxOQ_=PF9CWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a114d7f6e0ab487055b4a440c"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id BB3A02675CB
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 21:16:52 +0200 (CEST)
Received: by mail-qt0-f171.google.com with SMTP id z28so5981614qtz.13
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 12:16:52 -0700 (PDT)
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

--001a114d7f6e0ab487055b4a440c
Content-Type: text/plain; charset="UTF-8"

Hello! I'm completely new to ALSA and I tried to do a simply buzzer using it.

During the debug I noticed a strange behaviour: I used
SND_PCM_FORMAT_S8 format, tried to play the buffer filled with zero
bytes and I heard click sound when my program starts and end playing
the buffer. When I filled the buffer with 0x80 bytes I didn't hear any
clicks. The closer the bytes value to 0x80, the quieter the click is.

I tried snd_pcm_format_set_silence() instead of memset() and got
clicks too. Why I got them?

Does it mean what when I use some formats, the values in buffer for
zero output voltage are not 0x00?

My source code is in attachment, my sound card is Intel HDA.

--001a114d7f6e0ab487055b4a440c
Content-Type: text/x-c++src; charset="US-ASCII"; name="main.cpp"
Content-Disposition: attachment; filename="main.cpp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j8nf2elv0

I2RlZmluZSBBTFNBX1BDTV9ORVdfSFdfUEFSQU1TX0FQSQoKI2luY2x1ZGUgPGFsc2EvYXNvdW5k
bGliLmg+CgppbnQgbWFpbigpCnsKaW50IGVyckNvZGU7CnVuc2lnbmVkIGludCB2YWw7CmludCBk
aXI7CnNpemVfdCBzaXplOwp1bnNpZ25lZCBsb25nIGxvb3BzOwpjaGFyKiBidWZmZXI7CgpzbmRf
cGNtX3QqIGhQQ007CnNuZF9wY21faHdfcGFyYW1zX3QqIHBhcmFtczsKc25kX3BjbV91ZnJhbWVz
X3QgZnJhbWVzOwoJCgllcnJDb2RlID0gc25kX3BjbV9vcGVuKCZoUENNLCAiZGVmYXVsdCIsIFNO
RF9QQ01fU1RSRUFNX1BMQVlCQUNLLCAwKTsKCWlmIChlcnJDb2RlIDwgMCl7CgkJcHJpbnRmICgi
RXJyb3Igc25kX3BjbV9vcGVuOiAlc1xuIiwgc25kX3N0cmVycm9yKGVyckNvZGUpKTsKCQlyZXR1
cm4gMTsKCX0KCQoJc25kX3BjbV9od19wYXJhbXNfYWxsb2NhKCZwYXJhbXMpOwoJc25kX3BjbV9o
d19wYXJhbXNfYW55KGhQQ00sIHBhcmFtcyk7CglzbmRfcGNtX2h3X3BhcmFtc19zZXRfYWNjZXNz
KGhQQ00sIHBhcmFtcywgU05EX1BDTV9BQ0NFU1NfUldfSU5URVJMRUFWRUQpOwoJLy9zbmRfcGNt
X2h3X3BhcmFtc19zZXRfZm9ybWF0KGhQQ00sIHBhcmFtcywgU05EX1BDTV9GT1JNQVRfUzE2X0xF
KTsKCXNuZF9wY21faHdfcGFyYW1zX3NldF9mb3JtYXQoaFBDTSwgcGFyYW1zLCBTTkRfUENNX0ZP
Uk1BVF9TOCk7CglzbmRfcGNtX2h3X3BhcmFtc19zZXRfY2hhbm5lbHMoaFBDTSwgcGFyYW1zLCAy
KTsKCQoJdmFsID0gNDQxMDA7CglzbmRfcGNtX2h3X3BhcmFtc19zZXRfcmF0ZV9uZWFyKGhQQ00s
IHBhcmFtcywgJnZhbCwgJmRpcik7CgkKCWZyYW1lcyA9IDI1NjsKCXNuZF9wY21faHdfcGFyYW1z
X3NldF9wZXJpb2Rfc2l6ZV9uZWFyKGhQQ00sIHBhcmFtcywgJmZyYW1lcywgJmRpcik7CgkKCWVy
ckNvZGUgPSBzbmRfcGNtX2h3X3BhcmFtcyhoUENNLCBwYXJhbXMpOwoJaWYgKGVyckNvZGUgPCAw
KXsKCQlwcmludGYgKCJFcnJvciBzbmRfcGNtX2h3X3BhcmFtczogJXNcbiIsIHNuZF9zdHJlcnJv
cihlcnJDb2RlKSk7Cgl9CgkKCXNuZF9wY21faHdfcGFyYW1zX2dldF9wZXJpb2Rfc2l6ZShwYXJh
bXMsICZmcmFtZXMsICZkaXIpOwoJc2l6ZSA9IGZyYW1lcyAqIDIgKiA0OwoJYnVmZmVyID0gKGNo
YXIqKW1hbGxvYyhzaXplKTsKCQkKCW1lbXNldChidWZmZXIsIDB4MDAsIHNpemUpOwoJCglzbmRf
cGNtX2h3X3BhcmFtc19nZXRfcGVyaW9kX3RpbWUocGFyYW1zLCAmdmFsLCAmZGlyKTsKCWxvb3Bz
ID0gMTAwMDAwMCAvIHZhbDsKCQoJd2hpbGUobG9vcHMgPiAwKXsKCQlsb29wcy0tOwoJCWVyckNv
ZGUgPSBzbmRfcGNtX3dyaXRlaShoUENNLCBidWZmZXIsIGZyYW1lcyk7Cgl9CgkJCglzbmRfcGNt
X2RyYWluKGhQQ00pOwoJc25kX3BjbV9jbG9zZShoUENNKTsKCWZyZWUoYnVmZmVyKTsKCXJldHVy
biAwOwp9
--001a114d7f6e0ab487055b4a440c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a114d7f6e0ab487055b4a440c--
