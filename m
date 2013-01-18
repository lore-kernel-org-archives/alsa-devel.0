From: Erik Kazandjian <erik.kazandjian@gmail.com>
Subject: Problems capturing and playback via the loopback device
Date: Fri, 18 Jan 2013 07:41:15 +0100
Message-ID: <CAOePwYNrs+zZ5wrfEZ5zn+Ho-+sU5F_JcvwruNr6PE2BkviEQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae9340ee1ef771b04d38a655b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E98626501C
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 07:41:16 +0100 (CET)
Received: by mail-ie0-f182.google.com with SMTP id s9so5928359iec.27
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 22:41:16 -0800 (PST)
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

--14dae9340ee1ef771b04d38a655b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm new to alsa and I'm trying to do the following. I have configured my
rythm box to use the loopback device. I've written a little program to
capture everything that comes on the other side of the loopback and save
that into a file.
If I play a song on rythm box I see actual packets on the couterside of the
loopback however I save these packets in a file and try to play them back
using my sound card I hear no sound.
I use the following .asoundrc

pcm.loopplayback
{
    type hw
    card 1
    device 1
    subdevice 0
}

pcm.loopcapture
{
    type hw
    card 1
    device 0
    subdevice 0
}

pcm.play48 {
    type plug
    slave {
        pcm loopplayback
        rate 44100
    channels 2
    }
}

attached is my test program to do the capturing. Anyone has any idea what
I'm doing wrong ?

Kind regards

Erik

--14dae9340ee1ef771b04d38a655b
Content-Type: text/x-csrc; charset=US-ASCII; name="test4.c"
Content-Disposition: attachment; filename="test4.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hc2ymijx0

I2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CgppbnQgbWFpbigpCnsKCWxvbmcgbG9vcHM7Cglp
bnQgcmM7CglpbnQgc2l6ZTsKCXNuZF9wY21fdCAqaGFuZGxlOwoJc25kX3BjbV9od19wYXJhbXNf
dCAqcGFyYW1zOwoJdW5zaWduZWQgaW50IHZhbDsKCWludCBkaXI7CglzbmRfcGNtX3VmcmFtZXNf
dCBmcmFtZXM7CglzaWduZWQgc2hvcnQgKmJ1ZmZlcjsKCUZJTEUqIGRhdGE7CgoKCWRhdGEgPSBm
b3BlbigiL3RtcC9zYXZlZF9kYXRhIiwidysiKTsKCgkvKiBPcGVuIFBDTSBkZXZpY2UgZm9yIHJl
Y29yZGluZyAoY2FwdHVyZSkuICovCglyYyA9IHNuZF9wY21fb3BlbigmaGFuZGxlLCAibG9vcGNh
cHR1cmUiLCBTTkRfUENNX1NUUkVBTV9DQVBUVVJFLCAwKTsKCWlmIChyYyA8IDApCgl7CgkJZnBy
aW50ZihzdGRlcnIsICJ1bmFibGUgdG8gb3BlbiBwY20gZGV2aWNlOiAlc1xuIiwgc25kX3N0cmVy
cm9yKHJjKSk7CgkJZXhpdCgxKTsKCX0KCgkvKiBBbGxvY2F0ZSBhIGhhcmR3YXJlIHBhcmFtZXRl
cnMgb2JqZWN0LiAqLwoJc25kX3BjbV9od19wYXJhbXNfYWxsb2NhKCZwYXJhbXMpOwoKCS8qIEZp
bGwgaXQgaW4gd2l0aCBkZWZhdWx0IHZhbHVlcy4gKi8KCXNuZF9wY21faHdfcGFyYW1zX2FueSho
YW5kbGUsIHBhcmFtcyk7CgoJLyogU2V0IHRoZSBkZXNpcmVkIGhhcmR3YXJlIHBhcmFtZXRlcnMu
ICovCgoJLyogSW50ZXJsZWF2ZWQgbW9kZSAqLwoJc25kX3BjbV9od19wYXJhbXNfc2V0X2FjY2Vz
cyhoYW5kbGUsIHBhcmFtcywgU05EX1BDTV9BQ0NFU1NfUldfSU5URVJMRUFWRUQpOwoKCS8qIFNp
Z25lZCAxNi1iaXQgbGl0dGxlLWVuZGlhbiBmb3JtYXQgKi8KCXNuZF9wY21faHdfcGFyYW1zX3Nl
dF9mb3JtYXQoaGFuZGxlLCBwYXJhbXMsIFNORF9QQ01fRk9STUFUX1MxNl9MRSk7CgoJLyogVHdv
IGNoYW5uZWxzIChzdGVyZW8pICovCglzbmRfcGNtX2h3X3BhcmFtc19zZXRfY2hhbm5lbHMoaGFu
ZGxlLCBwYXJhbXMsIDIpOwoKCS8qIDQ0MTAwIGJpdHMvc2Vjb25kIHNhbXBsaW5nIHJhdGUgKENE
IHF1YWxpdHkpICovCgl2YWwgPSA0NDEwMDsKCXNuZF9wY21faHdfcGFyYW1zX3NldF9yYXRlX25l
YXIoaGFuZGxlLCBwYXJhbXMsICZ2YWwsICZkaXIpOwoKCS8qIFNldCBwZXJpb2Qgc2l6ZSB0byAz
MiBmcmFtZXMuICovCglmcmFtZXMgPSAzMjsKCXNuZF9wY21faHdfcGFyYW1zX3NldF9wZXJpb2Rf
c2l6ZV9uZWFyKGhhbmRsZSwgcGFyYW1zLCAmZnJhbWVzLCAmZGlyKTsKCgkvKiBXcml0ZSB0aGUg
cGFyYW1ldGVycyB0byB0aGUgZHJpdmVyICovCglyYyA9IHNuZF9wY21faHdfcGFyYW1zKGhhbmRs
ZSwgcGFyYW1zKTsKCWlmIChyYyA8IDApCgl7CgkJZnByaW50ZihzdGRlcnIsICJ1bmFibGUgdG8g
c2V0IGh3IHBhcmFtZXRlcnM6ICVzXG4iLCBzbmRfc3RyZXJyb3IocmMpKTsKCQlleGl0KDEpOwoJ
fQoKCS8qIFVzZSBhIGJ1ZmZlciBsYXJnZSBlbm91Z2ggdG8gaG9sZCBvbmUgcGVyaW9kICovCglz
bmRfcGNtX2h3X3BhcmFtc19nZXRfcGVyaW9kX3NpemUocGFyYW1zLCAmZnJhbWVzLCAmZGlyKTsK
CXNpemUgPSBmcmFtZXMgKiAyOyAvKiAxIHNpZ25lZCBzaG9ydC9zYW1wbGUsIDIgY2hhbm5lbHMg
Ki8KCWJ1ZmZlciA9IChzaWduZWQgc2hvcnQgKikgbWFsbG9jKHNpemUqc2l6ZW9mKHNpZ25lZCBz
aG9ydCkpOwoKCS8qIFdlIHdhbnQgdG8gbG9vcCBmb3IgNSBzZWNvbmRzICovCglzbmRfcGNtX2h3
X3BhcmFtc19nZXRfcGVyaW9kX3RpbWUocGFyYW1zLCAmdmFsLCAmZGlyKTsKCWxvb3BzID0gNTAw
MDAwMCAvIHZhbDsKCglwcmludGYoIkxvb3BzID0gJWxkIHNpemU9JWRcbiIsbG9vcHMsc2l6ZSk7
Cgl3aGlsZSAobG9vcHMgPiAwKQoJewoJCWxvb3BzLS07CgkJcmMgPSBzbmRfcGNtX3JlYWRpKGhh
bmRsZSwgYnVmZmVyLCBmcmFtZXMpOwoJCWlmIChyYyA9PSAtRVBJUEUpCgkJewoJCQkvKiBFUElQ
RSBtZWFucyBvdmVycnVuICovCgkJCWZwcmludGYoc3RkZXJyLCAib3ZlcnJ1biBvY2N1cnJlZFxu
Iik7CgkJCXNuZF9wY21fcHJlcGFyZShoYW5kbGUpOwoJCX0KCQllbHNlIGlmIChyYyA8IDApCgkJ
ewoJCQlmcHJpbnRmKHN0ZGVyciwgImVycm9yIGZyb20gcmVhZDogJXNcbiIsIHNuZF9zdHJlcnJv
cihyYykpOwoJCX0KCQllbHNlIGlmIChyYyAhPSAoaW50KSBmcmFtZXMpCgkJewoJCQlmcHJpbnRm
KHN0ZGVyciwgInNob3J0IHJlYWQsIHJlYWQgJWQgZnJhbWVzXG4iLCByYyk7CgkJfQoJCXJjID0g
ZndyaXRlKGJ1ZmZlcixzaXplb2Yoc2lnbmVkIHNob3J0KSwgc2l6ZSxkYXRhKTsKCgoJCWlmIChy
YyAhPSBzaXplKQoJCQlmcHJpbnRmKHN0ZGVyciwgInNob3J0IHdyaXRlOiB3cm90ZSAlZCBieXRl
c1xuIiwgcmMpOwoKCX0KCglwcmludGYoIkRvbmUgcmVhZGluZ1xuIik7CglzbmRfcGNtX2RyYWlu
KGhhbmRsZSk7CglzbmRfcGNtX2Nsb3NlKGhhbmRsZSk7CglmcmVlKGJ1ZmZlcik7CglmY2xvc2Ug
KGRhdGEpOwoKCXJldHVybiAwOwp9Cg==
--14dae9340ee1ef771b04d38a655b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--14dae9340ee1ef771b04d38a655b--
