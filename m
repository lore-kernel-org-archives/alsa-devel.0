From: Akshay Mishra <akshaymishra@gmail.com>
Subject: Re: Fwd: Overrun Errors - SAM9G
Date: Tue, 22 Jul 2014 08:08:06 +0530
Message-ID: <CABSY_ZuyQU0LX3Qb7sxfH+Xm-Za_syijnDOYz7sBoF9-g3_5+Q@mail.gmail.com>
References: <CABSY_ZsjSaZQA+KadBWnzR-9=YQby-Fnb9ZpBGZpXHtVsZZXMw@mail.gmail.com>
 <CABSY_Zsh44D19KtDYkc6ozSsxKpTk+cQJiy4rEGKqWgbv_a=tQ@mail.gmail.com>
 <53CDCC2C.1010400@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11337a7844209504febf1efe
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C1C902654C2
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 04:38:27 +0200 (CEST)
Received: by mail-qg0-f45.google.com with SMTP id f51so6279549qge.18
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 19:38:27 -0700 (PDT)
In-Reply-To: <53CDCC2C.1010400@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001a11337a7844209504febf1efe
Content-Type: text/plain; charset=UTF-8

On 22 July 2014 07:57, Bo Shen <voice.shen@atmel.com> wrote:

> Hi Akshay,
>
>
> On 07/17/2014 08:54 PM, Akshay Mishra wrote:
>
>> Hello,
>>      I am trying a simple alsa capture on the Atmel ARM9 (SAM9G45). While
>> only capture runs fine, putting any os call on the same thread gives
>> XRUNs.
>>
>> Even a innocent usleep(1) seems to lead to regular XRUNs. Eventually I
>> want
>> to dump this capture on the serial port and I am not able to get past
>> this.
>>
>
> Do you test with alsa utils. If yes, where you add the usleep(1) in code?
>
>
>  I have tried on AT91 linux as well as on kernel 3.10.10-rt7 with no
>> success.
>>
>
> I try both kernel and don't reproduce this issue with alsa utils.
>
>
Bo, I put usleep(x) after the snd_pcm_readi. I also tried with this code
(attached).
usleep at Line 88 gives the error.

Another observation is, disabling HRTimer the -EPIPE error was not seen but
I need further tests to be sure about this behaviour.

The code is from here (http://www.linuxjournal.com/node/6735/print).




>  Please advice,
>> Akshay
>>
>
> Best Regards,
> Bo Shen
>
>

--001a11337a7844209504febf1efe
Content-Type: text/x-csrc; charset=US-ASCII; name="cap.c"
Content-Disposition: attachment; filename="cap.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hxwm1oxr0

LyoKClRoaXMgZXhhbXBsZSByZWFkcyBmcm9tIHRoZSBkZWZhdWx0IFBDTSBkZXZpY2UKYW5kIHdy
aXRlcyB0byBzdGFuZGFyZCBvdXRwdXQgZm9yIDUgc2Vjb25kcyBvZiBkYXRhLgoKKi8KCi8qIFVz
ZSB0aGUgbmV3ZXIgQUxTQSBBUEkgKi8KI2RlZmluZSBBTFNBX1BDTV9ORVdfSFdfUEFSQU1TX0FQ
SQoKI2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CiNpbmNsdWRlIDx0aW1lLmg+CgppbnQgbWFp
bigpIHsKICBsb25nIGxvb3BzOwogIGludCByYzsKICBpbnQgc2l6ZTsKICBzbmRfcGNtX3QgKmhh
bmRsZTsKICBzbmRfcGNtX2h3X3BhcmFtc190ICpwYXJhbXM7CiAgdW5zaWduZWQgaW50IHZhbDsK
ICBpbnQgZGlyOwogIHNuZF9wY21fdWZyYW1lc190IGZyYW1lczsKICBjaGFyICpidWZmZXI7Cgog
IC8qIE9wZW4gUENNIGRldmljZSBmb3IgcmVjb3JkaW5nIChjYXB0dXJlKS4gKi8KICByYyA9IHNu
ZF9wY21fb3BlbigmaGFuZGxlLCAiZGVmYXVsdCIsCiAgICAgICAgICAgICAgICAgICAgU05EX1BD
TV9TVFJFQU1fQ0FQVFVSRSwgMCk7CiAgaWYgKHJjIDwgMCkgewogICAgZnByaW50ZihzdGRlcnIs
CiAgICAgICAgICAgICJ1bmFibGUgdG8gb3BlbiBwY20gZGV2aWNlOiAlc1xuIiwKICAgICAgICAg
ICAgc25kX3N0cmVycm9yKHJjKSk7CiAgICBleGl0KDEpOwogIH0KCiAgLyogQWxsb2NhdGUgYSBo
YXJkd2FyZSBwYXJhbWV0ZXJzIG9iamVjdC4gKi8KICBzbmRfcGNtX2h3X3BhcmFtc19hbGxvY2Eo
JnBhcmFtcyk7CgogIC8qIEZpbGwgaXQgaW4gd2l0aCBkZWZhdWx0IHZhbHVlcy4gKi8KICBzbmRf
cGNtX2h3X3BhcmFtc19hbnkoaGFuZGxlLCBwYXJhbXMpOwoKICAvKiBTZXQgdGhlIGRlc2lyZWQg
aGFyZHdhcmUgcGFyYW1ldGVycy4gKi8KCiAgLyogSW50ZXJsZWF2ZWQgbW9kZSAqLwogIHNuZF9w
Y21faHdfcGFyYW1zX3NldF9hY2Nlc3MoaGFuZGxlLCBwYXJhbXMsCiAgICAgICAgICAgICAgICAg
ICAgICBTTkRfUENNX0FDQ0VTU19SV19JTlRFUkxFQVZFRCk7CgogIC8qIFNpZ25lZCAxNi1iaXQg
bGl0dGxlLWVuZGlhbiBmb3JtYXQgKi8KICBzbmRfcGNtX2h3X3BhcmFtc19zZXRfZm9ybWF0KGhh
bmRsZSwgcGFyYW1zLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTkRfUENNX0ZPUk1B
VF9TMTZfTEUpOwoKICAvKiBUd28gY2hhbm5lbHMgKHN0ZXJlbykgKi8KICBzbmRfcGNtX2h3X3Bh
cmFtc19zZXRfY2hhbm5lbHMoaGFuZGxlLCBwYXJhbXMsIDIpOwoKICAvKiA0NDEwMCBiaXRzL3Nl
Y29uZCBzYW1wbGluZyByYXRlIChDRCBxdWFsaXR5KSAqLwogIHZhbCA9IDQ4MDAwOwogIHNuZF9w
Y21faHdfcGFyYW1zX3NldF9yYXRlX25lYXIoaGFuZGxlLCBwYXJhbXMsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmdmFsLCAmZGlyKTsKCiAgLyogU2V0IHBlcmlvZCBzaXplIHRv
IDMyIGZyYW1lcy4gKi8KICBmcmFtZXMgPSAzMjsKICBzbmRfcGNtX2h3X3BhcmFtc19zZXRfcGVy
aW9kX3NpemVfbmVhcihoYW5kbGUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFt
cywgJmZyYW1lcywgJmRpcik7CglwcmludGYoIkZyYW1lcyAlZFxuIixmcmFtZXMpOwoKCiAgLyog
V3JpdGUgdGhlIHBhcmFtZXRlcnMgdG8gdGhlIGRyaXZlciAqLwogIHJjID0gc25kX3BjbV9od19w
YXJhbXMoaGFuZGxlLCBwYXJhbXMpOwogIGlmIChyYyA8IDApIHsKICAgIGZwcmludGYoc3RkZXJy
LAogICAgICAgICAgICAidW5hYmxlIHRvIHNldCBodyBwYXJhbWV0ZXJzOiAlc1xuIiwKICAgICAg
ICAgICAgc25kX3N0cmVycm9yKHJjKSk7CiAgICBleGl0KDEpOwogIH0KCiAgLyogVXNlIGEgYnVm
ZmVyIGxhcmdlIGVub3VnaCB0byBob2xkIG9uZSBwZXJpb2QgKi8KICBzbmRfcGNtX2h3X3BhcmFt
c19nZXRfcGVyaW9kX3NpemUocGFyYW1zLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZmcmFtZXMsICZkaXIpOwogIHNpemUgPSBmcmFtZXMgKiA0OyAvKiAyIGJ5dGVzL3Nh
bXBsZSwgMiBjaGFubmVscyAqLwogIGJ1ZmZlciA9IChjaGFyICopIG1hbGxvYyhzaXplKTsKCiAg
c25kX3BjbV9od19wYXJhbXNfZ2V0X3BlcmlvZF90aW1lKHBhcmFtcywKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmdmFsLCAmZGlyKTsKICBsb29wcyA9IDUwMDAwMDAg
LyB2YWw7CgogIHdoaWxlICgxKSB7CiAgICBsb29wcy0tOwogICAgcmMgPSBzbmRfcGNtX3JlYWRp
KGhhbmRsZSwgYnVmZmVyLCBmcmFtZXMpOwoJdXNsZWVwKDEpOyAvLy0tQWtzaGF5IC0tIFRoaXMg
ZmFpbHMgd2l0aCBteSBjb25maWcKICAgIGlmIChyYyA9PSAtRVBJUEUpIHsKICAgICAgLyogRVBJ
UEUgbWVhbnMgb3ZlcnJ1biAqLwogICAgICBmcHJpbnRmKHN0ZGVyciwgIm92ZXJydW4gb2NjdXJy
ZWQgJWx1XG4iLCh1bnNpZ25lZCl0aW1lKE5VTEwpKTsKICAgICAgc25kX3BjbV9wcmVwYXJlKGhh
bmRsZSk7CiAgICB9IGVsc2UgaWYgKHJjIDwgMCkgewogICAgICBmcHJpbnRmKHN0ZGVyciwKICAg
ICAgICAgICAgICAiZXJyb3IgZnJvbSByZWFkOiAlc1xuIiwKICAgICAgICAgICAgICBzbmRfc3Ry
ZXJyb3IocmMpKTsKICAgIH0gZWxzZSBpZiAocmMgIT0gKGludClmcmFtZXMpIHsKICAgICAgZnBy
aW50ZihzdGRlcnIsICJzaG9ydCByZWFkLCByZWFkICVkIGZyYW1lc1xuIiwgcmMpOwogICAgfQog
ICAvLyByYyA9IHdyaXRlKDEsIGJ1ZmZlciwgc2l6ZSk7Ci8vICAgIGlmIChyYyAhPSBzaXplKQog
Ly8gICAgIGZwcmludGYoc3RkZXJyLAogIC8vICAgICAgICAgICAgInNob3J0IHdyaXRlOiB3cm90
ZSAlZCBieXRlc1xuIiwgcmMpOwogIH0KCiAgc25kX3BjbV9kcmFpbihoYW5kbGUpOwogIHNuZF9w
Y21fY2xvc2UoaGFuZGxlKTsKICBmcmVlKGJ1ZmZlcik7CgogIHJldHVybiAwOwp9Cg==
--001a11337a7844209504febf1efe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11337a7844209504febf1efe--
