From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Fw: Fw: Using loopback card to Connect GSM two way
	call	to the real sound card UDA1345TS
Date: Mon, 30 Mar 2015 11:40:31 +0000
Message-ID: <1427715629620.42885@tataelxsi.co.in>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,	<54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>
 <1425964490006.15084@tataelxsi.co.in>, <54FECC69.9020600@ladisch.de>,
 <1427510661706.37789@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_003_142771562962042885tataelxsicoin_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0138.outbound.protection.outlook.com [134.170.140.138])
 by alsa0.perex.cz (Postfix) with ESMTP id DBB7E260533
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 13:40:35 +0200 (CEST)
In-Reply-To: <1427510661706.37789@tataelxsi.co.in>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "clemens@ladisch.de" <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-audio-dev@lists.linuxaudio.org" <linux-audio-dev@lists.linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

--_003_142771562962042885tataelxsicoin_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Dear Clemens

Could you please provide any inputs w.r.t the below queries


Kindly do the needful as early as possible

Many Thanks in Advance,


________________________________________
From: Srinivasan S
Sent: Saturday, March 28, 2015 8:13 AM
To: Clemens Ladisch
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: Fw: [alsa-devel] Using loopback card to Connect GSM two way ca=
ll   to the real sound card UDA1345TS

Dear Clemens,


Thanks a lot for your inputs w.r.t the below issue, Now I tried playing 48K=
hz mono that works fine,

Could you please clarify the following points

1) CPU consumption is 18%, with above asound.conf & the app alsa_loopback_m=
in_mono.c for establishing my GSM two way call (ie., VINR to VOUTR & VINL t=
o VOUTL) , this is very huge & I want to reduce this CPU consumption drasti=
cally, Is there any other ways in alsa where I can do this two way GSM call=
 (ie., VINR to VOUTR & VINL to VOUTL) without using alsa_loopback_min_mono.=
c application

Could you please let me know if there is anything that can be done in using=
 alsa plugins in order to reduce CPU consumption???


2) And am hearing echo, when I do GSM calls when using the above attachd as=
ound.conf & the app alsa_loopback_min_mono.c, could you please help me out =
is there any options to do echo cancellation in alsa??


3)Am trying to completely understand the above attched asound.conf, but am =
not still very clear w.r.t the understanding of bindings in alsa plugins as=
 am confused, Could you please clarify the doubt that

i) Does the below lines correspond to VINL to VOUTL or VINL to VOUTR??

    bindings {
        0 1
    }


ii) & similarly does the below lines correspond VINL to VOUTL??

    bindings {
        0 0
    }

iii) similarly does the correspond VINL to VOUTL??


    bindings.0  0

iv) similarly does the correspond VINL to VOUTR or VINR to VOUTR??

    bindings.0  1



Kindly do the needful as early as possible, as only this is pending from my=
 side w.r.t AUDIO in my project

Once again really appreciate & Thanks a lot for your prompt responses


Many Many Thanks in advance again,


________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Tuesday, March 10, 2015 4:20 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org; linux-audio-dev@lists.linuxaudio.org
Subject: Re: Fw: [alsa-devel] Using loopback card to Connect GSM two way ca=
ll   to the real sound card UDA1345TS

Srinivasan S wrote:
> $ aplay -f dat -D VOUTL new.wav
> Playing WAVE 'new.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Ster=
eo
> aplay: set_params:1087: Channels count non available

You are trying to play a two-channel file on a single-channel device.


Regards,
Clemens

--_003_142771562962042885tataelxsicoin_
Content-Type: application/octet-stream; name="asound.conf"
Content-Description: asound.conf
Content-Disposition: attachment; filename="asound.conf"; size=743;
	creation-date="Sat, 28 Mar 2015 02:41:40 GMT";
	modification-date="Sat, 28 Mar 2015 02:43:22 GMT"
Content-Transfer-Encoding: base64

cGNtLmNhcmQwIHsKICAgIHR5cGUgaHcKICAgICAgY2FyZCAwCiAgICAKfQoKY3RsLmNhcmQwIHsK
ICAgIHR5cGUgaHcKICAgICAgY2FyZCAwCiAgICAgIAp9CgpwY20uVk9VVEwgewogICAgdHlwZSBk
c2hhcmUKICAgICAgaXBjX2tleSA2Njc4MjkzCiAgICAgIGlwY19rZXlfYWRkX3VpZCB5ZXMKICAg
ICAgc2xhdmUgewogICAgICAgICAgcGNtICJodzowIgogICAgICAgICAgY2hhbm5lbHMgMgogICAg
ICB9CiAgICBiaW5kaW5ncyB7CiAgICAgICAgMCAxCiAgICB9Cn0KCnBjbS5WT1VUUiB7CiAgICB0
eXBlIGRzaGFyZQogICAgICBpcGNfa2V5IDY2NzgyOTMKICAgICAgaXBjX2tleV9hZGRfdWlkIHll
cwogICAgICBzbGF2ZSB7CiAgICAgICAgICBwY20gImh3OjAiCgkgIGNoYW5uZWxzIDIKICAgICAg
fQogICAgYmluZGluZ3MgewogICAgICAgIDAgMAogICAgfQp9CgoKcGNtLlZJTkwgewogICAgdHlw
ZSBkc25vb3AKICAgICAgaXBjX2tleSAzMgogICAgICBzbGF2ZSB7CiAgICAgICAgICBwY20gImNh
cmQwIgogICAgICAgICAgICBjaGFubmVscyAyCiAgICAgIH0KICAgIGJpbmRpbmdzLjAgIDAKfQoK
cGNtLlZJTlIgewogICAgdHlwZSBkc25vb3AKICAgICAgaXBjX2tleSAzMgogICAgICBzbGF2ZSB7
CiAgICAgICAgICBwY20gImNhcmQwIgogICAgICAgICAgICBjaGFubmVscyAyCiAgICAgIH0KICAg
IGJpbmRpbmdzLjAgIDEKfQoKCgoKcGNtLiFkZWZhdWx0IFZPVVRSCnBjbS4hZGVmYXVsdCBWT1VU
TAo=

--_003_142771562962042885tataelxsicoin_
Content-Type: text/plain; name="alsa_loopback_min_mono.txt"
Content-Description: alsa_loopback_min_mono.txt
Content-Disposition: attachment; filename="alsa_loopback_min_mono.txt";
	size=4017; creation-date="Sat, 28 Mar 2015 02:42:44 GMT";
	modification-date="Sat, 28 Mar 2015 02:43:22 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGFsc2EvYXNv
dW5kbGliLmg+CiNkZWZpbmUgQlVGX0JZVEVTIDEyOAogCmludCBtYWluICgvKmludCBhcmdjLCBj
aGFyICphcmd2W10qLykgewoJaW50IGVycjsKCXVuc2lnbmVkIGNoYXIgYnVmX3JpZ2h0W0JVRl9C
WVRFU107Cgl1bnNpZ25lZCBjaGFyIGJ1Zl9sZWZ0W0JVRl9CWVRFU107CgkgLy9jaGFyICpidWY7
CglpbnQgc2l6ZTsKCglzbmRfcGNtX3QgKnBsYXliYWNrX2hhbmRsZV9yaWdodDsKCXNuZF9wY21f
dCAqY2FwdHVyZV9oYW5kbGVfcmlnaHQ7CgkKCXNuZF9wY21fdCAqcGxheWJhY2tfaGFuZGxlX2xl
ZnQ7CglzbmRfcGNtX3QgKmNhcHR1cmVfaGFuZGxlX2xlZnQ7CgoKI2lmIDAJCgljaGFyKiBkZXZp
Y2UgPSAiZGVmYXVsdCI7CglpZiAoYXJnYyA+IDEpIGRldmljZSA9IGFyZ3ZbMV07CiNlbmRpZgoJ
Y2hhciogY3JkZXZpY2UgPSAiVklOUiI7CgoJY2hhciogcHJkZXZpY2UgPSAiVk9VVFIiOwoKCWNo
YXIqIGNsZGV2aWNlID0gIlZJTkwiOwoKCWNoYXIqIHBsZGV2aWNlID0gIlZPVVRMIjsKCgoJdW5z
aWduZWQgaW50IHJhdGUgPSA0ODAwMDsKCXVuc2lnbmVkIGludCBuY2hhbm5lbHMgPSAxOwoJc25k
X3BjbV9mb3JtYXRfdCBmb3JtYXQgPSBTTkRfUENNX0ZPUk1BVF9TMTZfTEU7Cgl1bnNpZ25lZCBp
bnQgYnVmX2ZyYW1lc19yaWdodCA9IEJVRl9CWVRFUyAvIG5jaGFubmVscyAvIDI7Cgl1bnNpZ25l
ZCBpbnQgYnVmX2ZyYW1lc19sZWZ0ID0gQlVGX0JZVEVTIC8gbmNoYW5uZWxzIC8gMjsKCi8vLy8v
IFJJR0hUIENIQU5ORUwgCglpZiAoKGVyciA9IHNuZF9wY21fb3BlbiAoJnBsYXliYWNrX2hhbmRs
ZV9yaWdodCwgcHJkZXZpY2UsIFNORF9QQ01fU1RSRUFNX1BMQVlCQUNLLCAwKSkgPCAwKSB7Cglm
cHJpbnRmIChzdGRlcnIsICJjYW5ub3Qgb3BlbiBwbGF5YmFjayByaWdodCBhdWRpbyBkZXZpY2Ug
JXMgKCVzKVxuIiwgcHJkZXZpY2UsIHNuZF9zdHJlcnJvciAoZXJyKSk7IGV4aXQgKDEpOwoJfQoJ
ZWxzZQoJewoJICBwcmludGYoIk9wZW5lZCBQbGF5YmFjayByaWdodCBhdWRpbyBkZXZpY2UgIHN1
Y2Nlc3NmdWxseSAlcyBcbiIsIHByZGV2aWNlKTsKCX0KCQoJaWYgKChlcnIgPSBzbmRfcGNtX3Nl
dF9wYXJhbXMocGxheWJhY2tfaGFuZGxlX3JpZ2h0LCBmb3JtYXQsIFNORF9QQ01fQUNDRVNTX1JX
X0lOVEVSTEVBVkVELCBuY2hhbm5lbHMsIHJhdGUsIDEsIDUwMDAwMCkpIDwgMCkgeyAvKiAwLjVz
ZWMgKi8KCWZwcmludGYoc3RkZXJyLCAiUGxheWJhY2sgcmlnaHQgb3BlbiBlcnJvcjogJXNcbiIs
IHNuZF9zdHJlcnJvcihlcnIpKTsgZXhpdCgxKTsKCX0KCglpZiAoKGVyciA9IHNuZF9wY21fb3Bl
biAoJmNhcHR1cmVfaGFuZGxlX3JpZ2h0LCBjcmRldmljZSwgU05EX1BDTV9TVFJFQU1fQ0FQVFVS
RSwgMCkpIDwgMCkgewoJZnByaW50ZiAoc3RkZXJyLCAiY2Fubm90IG9wZW4gY2FwdHVyZSByaWdo
dCBhdWRpbyBkZXZpY2UgJXMgKCVzKVxuIiwgY3JkZXZpY2UsIHNuZF9zdHJlcnJvciAoZXJyKSk7
IGV4aXQgKDEpOwoJfQoJZWxzZQoJewoJICBwcmludGYoIk9wZW5lZCBDYXB0dXJlIHJpZ2h0IGF1
ZGlvIGRldmljZSBzdWNjZXNzZnVsbHkgJXMgXG4iLCBjcmRldmljZSk7Cgl9CgoJaWYgKChlcnIg
PSBzbmRfcGNtX3NldF9wYXJhbXMoY2FwdHVyZV9oYW5kbGVfcmlnaHQsIGZvcm1hdCwgU05EX1BD
TV9BQ0NFU1NfUldfSU5URVJMRUFWRUQsIG5jaGFubmVscywgcmF0ZSwgMSwgNTAwMDAwKSkgPCAw
KSB7IC8qIDAuNXNlYyAqLwoJZnByaW50ZihzdGRlcnIsICJjYXB0dXJlIHJpZ2h0IG9wZW4gZXJy
b3I6ICVzXG4iLCBzbmRfc3RyZXJyb3IoZXJyKSk7IGV4aXQoMSk7Cgl9CQoKLy8vL0xFRlQgQ0hB
Tk5FTAoJaWYgKChlcnIgPSBzbmRfcGNtX29wZW4gKCZwbGF5YmFja19oYW5kbGVfbGVmdCwgcGxk
ZXZpY2UsIFNORF9QQ01fU1RSRUFNX1BMQVlCQUNLLCAwKSkgPCAwKSB7CglmcHJpbnRmIChzdGRl
cnIsICJjYW5ub3Qgb3BlbiBwbGF5YmFjayBsZWZ0IGF1ZGlvIGRldmljZSAlcyAoJXMpXG4iLCBw
bGRldmljZSwgc25kX3N0cmVycm9yIChlcnIpKTsgZXhpdCAoMSk7Cgl9CgllbHNlCgl7CgkgIHBy
aW50ZigiT3BlbmVkIFBsYXliYWNrIGxlZnQgYXVkaW8gZGV2aWNlIHN1Y2Nlc3NmdWxseSAlcyBc
biIsIHBsZGV2aWNlKTsKCX0KCQoJaWYgKChlcnIgPSBzbmRfcGNtX3NldF9wYXJhbXMocGxheWJh
Y2tfaGFuZGxlX2xlZnQsIGZvcm1hdCwgU05EX1BDTV9BQ0NFU1NfUldfSU5URVJMRUFWRUQsIG5j
aGFubmVscywgcmF0ZSwgMSwgNTAwMDAwKSkgPCAwKSB7IC8qIDAuNXNlYyAqLwoJZnByaW50Zihz
dGRlcnIsICJQbGF5YmFjayBsZWZ0IG9wZW4gZXJyb3I6ICVzXG4iLCBzbmRfc3RyZXJyb3IoZXJy
KSk7IGV4aXQoMSk7Cgl9CgoJaWYgKChlcnIgPSBzbmRfcGNtX29wZW4gKCZjYXB0dXJlX2hhbmRs
ZV9sZWZ0LCBjbGRldmljZSwgU05EX1BDTV9TVFJFQU1fQ0FQVFVSRSwgMCkpIDwgMCkgewoJZnBy
aW50ZiAoc3RkZXJyLCAiY2Fubm90IG9wZW4gY2FwdHVyZSBsZWZ0IGF1ZGlvIGRldmljZSAlcyAo
JXMpXG4iLCBjbGRldmljZSwgc25kX3N0cmVycm9yIChlcnIpKTsgZXhpdCAoMSk7Cgl9CgllbHNl
Cgl7CgkgIHByaW50ZigiT3BlbmVkIENhcHR1cmUgbGVmdCBhdWRpbyBkZXZpY2Ugc3VjY2Vzc2Z1
bGx5ICVzIFxuIiwgY3JkZXZpY2UpOwoJfQoKCWlmICgoZXJyID0gc25kX3BjbV9zZXRfcGFyYW1z
KGNhcHR1cmVfaGFuZGxlX2xlZnQsIGZvcm1hdCwgU05EX1BDTV9BQ0NFU1NfUldfSU5URVJMRUFW
RUQsIG5jaGFubmVscywgcmF0ZSwgMSwgNTAwMDAwKSkgPCAwKSB7IC8qIDAuNXNlYyAqLwoJZnBy
aW50ZihzdGRlcnIsICJjYXB0dXJlIGxlZnQgb3BlbiBlcnJvcjogJXNcbiIsIHNuZF9zdHJlcnJv
cihlcnIpKTsgZXhpdCgxKTsKCX0KCgoKCXdoaWxlKDEpIHsKLy8vLy8gUklHSFQgQ0hBTk5FTCAK
CQlpZiAoKGVyciA9IHNuZF9wY21fcmVhZGkgKGNhcHR1cmVfaGFuZGxlX3JpZ2h0LCBidWZfcmln
aHQsIGJ1Zl9mcmFtZXNfcmlnaHQpKSAhPSBidWZfZnJhbWVzX3JpZ2h0KSB7CgkJZnByaW50ZiAo
c3RkZXJyLCAicmVhZCBmcm9tIGF1ZGlvIGludGVyZmFjZSByaWdodCBmYWlsZWQgKCVzKVxuIiwg
c25kX3N0cmVycm9yIChlcnIpKTsgZXhpdCAoMSk7CgkJfQkKCgkJaWYgKChlcnIgPSBzbmRfcGNt
X3dyaXRlaSAocGxheWJhY2tfaGFuZGxlX3JpZ2h0LCBidWZfcmlnaHQsIGJ1Zl9mcmFtZXNfcmln
aHQpKSAhPSBidWZfZnJhbWVzX3JpZ2h0KSB7CgkJZnByaW50ZiAoc3RkZXJyLCAid3JpdGUgdG8g
YXVkaW8gaW50ZXJmYWNlIHJpZ2h0IGZhaWxlZCAoJXMpXG4iLCBzbmRfc3RyZXJyb3IgKGVycikp
OyBleGl0ICgxKTsKCQl9Ci8vLy9MRUZUIENIQU5ORUwKCQlpZiAoKGVyciA9IHNuZF9wY21fcmVh
ZGkgKGNhcHR1cmVfaGFuZGxlX2xlZnQsIGJ1Zl9sZWZ0LCBidWZfZnJhbWVzX2xlZnQpKSAhPSBi
dWZfZnJhbWVzX2xlZnQpIHsKCQlmcHJpbnRmIChzdGRlcnIsICJyZWFkIGZyb20gYXVkaW8gaW50
ZXJmYWNlIGxlZnQgZmFpbGVkICglcylcbiIsIHNuZF9zdHJlcnJvciAoZXJyKSk7IGV4aXQgKDEp
OwoJCX0JCgoJCWlmICgoZXJyID0gc25kX3BjbV93cml0ZWkgKHBsYXliYWNrX2hhbmRsZV9sZWZ0
LCBidWZfbGVmdCwgYnVmX2ZyYW1lc19sZWZ0KSkgIT0gYnVmX2ZyYW1lc19sZWZ0KSB7CgkJZnBy
aW50ZiAoc3RkZXJyLCAid3JpdGUgdG8gYXVkaW8gaW50ZXJmYWNlIGxlZnQgZmFpbGVkICglcylc
biIsIHNuZF9zdHJlcnJvciAoZXJyKSk7IGV4aXQgKDEpOwoJCX0KCgl9CiAKCWZwcmludGYgKHN0
ZGVyciwgImNsb3NlIGhhbmRsZXNcbiIpOwoJc25kX3BjbV9jbG9zZSAocGxheWJhY2tfaGFuZGxl
X3JpZ2h0KTsKCXNuZF9wY21fY2xvc2UgKGNhcHR1cmVfaGFuZGxlX3JpZ2h0KTsKCglzbmRfcGNt
X2Nsb3NlIChwbGF5YmFja19oYW5kbGVfbGVmdCk7CglzbmRfcGNtX2Nsb3NlIChjYXB0dXJlX2hh
bmRsZV9sZWZ0KTsKCglyZXR1cm4gMDsKfSAK

--_003_142771562962042885tataelxsicoin_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_003_142771562962042885tataelxsicoin_--
