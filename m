From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: What-did-you-plugin-dialog
Date: Sun, 1 Dec 2013 10:15:58 +0800
Message-ID: <CAN8cciYnQZQzyRmz_=gLLF6w7p3CZbZPKwYZtJpTHEaN3UOt_Q@mail.gmail.com>
References: <52947A6E.6010302@canonical.com>
	<1385470453.2226.26.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52949CCA.2060601@canonical.com>
	<1385473638.2226.48.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52951347.9000200@canonical.com> <5295A121.2010202@gmail.com>
	<5295A7C2.2090100@canonical.com>
	<CAN_LGv1F4cTB2cK+rL30N3nbbwyxi23cLYHR6emMC5CbNLP4jQ@mail.gmail.com>
	<CAN_LGv0y2WcYMn8M5rjT1d-2jahh_u-W2D_LnRkMsXXD=ENzdA@mail.gmail.com>
	<CAN8cciZ-y397dLGV_xC3xibo3PY9aE-RYQEB4_dkwRtzN+JnqQ@mail.gmail.com>
	<CAN_LGv02cPydDkvP-AZ+EzkF9TVvm1ij0-6vjzp0YWbieg7_fQ@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0112c7fee995d804ec6fa401
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN_LGv02cPydDkvP-AZ+EzkF9TVvm1ij0-6vjzp0YWbieg7_fQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--089e0112c7fee995d804ec6fa401
Content-Type: multipart/alternative; boundary=089e0112c7fee995d204ec6fa4ff

--089e0112c7fee995d204ec6fa4ff
Content-Type: text/plain; charset=UTF-8

:

>
> > can post the output of alsa-info.sh after jack retasking ?
>
> Before retasking:
>
> http://www.alsa-project.org/db/?f=fd97b8194e205b4f91127bca74ad7c9b2cd93ab9
>
> After retasking blue line in, pin ID 0x1a as Line out (Side):
>
> http://www.alsa-project.org/db/?f=d56f9a6d0692c9a8d5c88f43100a6cb78407c163
>
> Note that retasking did not work: attempting to play a 8-channel wav
> file through hw:1,0 resulted in an "Invalid argument" error.
>
> FWIW, here is what hdajackretask printed to the console:
>
> 0x11 0x99430130
> 0x12 0x4037c540
> 0x14 0x01014010
> 0x15 0x01011012
> 0x16 0x01016011
> 0x17 0x411111f0
> 0x18 0x01a19050
> 0x19 0x02a19060
> 0x1a 0x01014413
> 0x1b 0x02214020
> 0x1c 0x411111f0
> 0x1d 0x4045e601
> 0x1e 0x01452140
> 0x1f 0x411111f0
> 1
>
>
you need root privilege for hdajackretask to write the firmware file to
/lib/firmware and modify /etc/modprobe.d/alsa-lbase.conf to use the
firmware file

can you try the patch which add "channel mode" control which allow you to
switch from 6ch to 8ch

it is not clear that the "Line jack" control is used for detect the blue
jack state or reflect the line In is no longer available after it is
retasked as output jack

--089e0112c7fee995d204ec6fa4ff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">:<br>
<div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div class=3D"im"><br>
&gt; can post the output of alsa-info.sh after jack retasking ?<br>
<br>
</div>Before retasking:<br>
<br>
<a href=3D"http://www.alsa-project.org/db/?f=3Dfd97b8194e205b4f91127bca74ad=
7c9b2cd93ab9" target=3D"_blank">http://www.alsa-project.org/db/?f=3Dfd97b81=
94e205b4f91127bca74ad7c9b2cd93ab9</a><br>
<br>
After retasking blue line in, pin ID 0x1a as Line out (Side):<br>
<br>
<a href=3D"http://www.alsa-project.org/db/?f=3Dd56f9a6d0692c9a8d5c88f43100a=
6cb78407c163" target=3D"_blank">http://www.alsa-project.org/db/?f=3Dd56f9a6=
d0692c9a8d5c88f43100a6cb78407c163</a><br>
<br>
Note that retasking did not work: attempting to play a 8-channel wav<br>
file through hw:1,0 resulted in an &quot;Invalid argument&quot; error.<br>
<br>
FWIW, here is what hdajackretask printed to the console:<br>
<br>
0x11 0x99430130<br>
0x12 0x4037c540<br>
0x14 0x01014010<br>
0x15 0x01011012<br>
0x16 0x01016011<br>
0x17 0x411111f0<br>
0x18 0x01a19050<br>
0x19 0x02a19060<br>
0x1a 0x01014413<br>
0x1b 0x02214020<br>
0x1c 0x411111f0<br>
0x1d 0x4045e601<br>
0x1e 0x01452140<br>
0x1f 0x411111f0<br>
<div class=3D"HOEnZb"><div class=3D"h5">1<br>
<br></div></div></blockquote><br></div>you need root privilege for hdajackr=
etask to write the firmware file to /lib/firmware and modify /etc/modprobe.=
d/alsa-lbase.conf to use the firmware file<br><br>can you try the patch whi=
ch add &quot;channel mode&quot; control which allow you to switch from 6ch =
to 8ch<br>
<br></div><div class=3D"gmail_extra">it is not clear that the &quot;Line ja=
ck&quot; control is used for detect the blue jack state or reflect the line=
 In is no longer available after it is retasked as output jack<br></div><di=
v class=3D"gmail_extra">
<br><br></div></div>

--089e0112c7fee995d204ec6fa4ff--

--089e0112c7fee995d804ec6fa401
Content-Type: text/x-diff; charset=US-ASCII; name="ch6_ch8.patch"
Content-Disposition: attachment; filename="ch6_ch8.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_honnme0m0

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2dlbmVyaWMuYyBiL3NvdW5kL3BjaS9oZGEv
aGRhX2dlbmVyaWMuYwppbmRleCAzMDY3ZWQ0Li5jNjRhZDk1IDEwMDY0NAotLS0gYS9zb3VuZC9w
Y2kvaGRhL2hkYV9nZW5lcmljLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfZ2VuZXJpYy5jCkBA
IC0xMzc1LDYgKzEzNzUsOCBAQCBzdGF0aWMgaW50IGZpbGxfbXVsdGlfaW9zKHN0cnVjdCBoZGFf
Y29kZWMgKmNvZGVjLAogCQkJaWYgKHNwZWMtPm11bHRpX2lvcyA+PSAyKQogCQkJCWJyZWFrOwog
CQl9CisJCWlmICgoY2ZnLT5saW5lX291dHMgKyBzcGVjLT5tdWx0aV9pb3MpID09IDQpCisJCQli
cmVhazsKIAl9CiAgZW5kX2ZpbGw6CiAJaWYgKGJhZG5lc3MpCkBAIC0xMzg1LDcgKzEzODcsNyBA
QCBzdGF0aWMgaW50IGZpbGxfbXVsdGlfaW9zKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCQll
bHNlCiAJCQlyZXR1cm4gYmFkbmVzczsgLyogbm8gYmFkbmVzcyBpZiBub3RoaW5nIGZvdW5kICov
CiAJfQotCWlmICghaGFyZHdpcmVkICYmIHNwZWMtPm11bHRpX2lvcyA8IDIpIHsKKwlpZiAoIWhh
cmR3aXJlZCAmJiBzcGVjLT5tdWx0aV9pb3MgPCAxKSB7CiAJCS8qIGNhbmNlbCBuZXdseSBhc3Np
Z25lZCBwYXRocyAqLwogCQlzcGVjLT5wYXRocy51c2VkIC09IHNwZWMtPm11bHRpX2lvcyAtIG9s
ZF9waW5zOwogCQlzcGVjLT5tdWx0aV9pb3MgPSBvbGRfcGluczsKQEAgLTE1ODMsNyArMTU4NSw4
IEBAIHN0YXRpYyBpbnQgZmlsbF9hbmRfZXZhbF9kYWNzKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
LAogCQkJCSAgIHNwZWMtPm1haW5fb3V0X2JhZG5lc3MpOwogCiAJaWYgKCFzcGVjLT5ub19tdWx0
aV9pbyAmJiBmaWxsX21pb19maXJzdCAmJgotCSAgICBjZmctPmxpbmVfb3V0cyA9PSAxICYmIGNm
Zy0+bGluZV9vdXRfdHlwZSAhPSBBVVRPX1BJTl9TUEVBS0VSX09VVCkgeworCSAgICAoY2ZnLT5s
aW5lX291dHMgPT0gMSB8fCBjZmctPmxpbmVfb3V0cyA9PTMpICYmCisJICAgIGNmZy0+bGluZV9v
dXRfdHlwZSAhPSBBVVRPX1BJTl9TUEVBS0VSX09VVCkgewogCQkvKiB0cnkgdG8gZmlsbCBtdWx0
aS1pbyBmaXJzdCAqLwogCQllcnIgPSBmaWxsX211bHRpX2lvcyhjb2RlYywgY2ZnLT5saW5lX291
dF9waW5zWzBdLCBmYWxzZSk7CiAJCWlmIChlcnIgPCAwKQpAQCAtMTY1MCwxMSArMTY1MywxMSBA
QCBzdGF0aWMgaW50IGZpbGxfYW5kX2V2YWxfZGFjcyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywK
IAlzcGVjLT5leHRfY2hhbm5lbF9jb3VudCA9IHNwZWMtPm1pbl9jaGFubmVsX2NvdW50ID0KIAkJ
c3BlYy0+bXVsdGlvdXQubnVtX2RhY3MgKiAyOwogCi0JaWYgKHNwZWMtPm11bHRpX2lvcyA9PSAy
KSB7Ci0JCWZvciAoaSA9IDA7IGkgPCAyOyBpKyspCisJaWYgKHNwZWMtPm11bHRpX2lvcyA+IDAp
IHsKKwkJZm9yIChpID0gMDsgaSA8IHNwZWMtPm11bHRpX2lvczsgaSsrKQogCQkJc3BlYy0+cHJp
dmF0ZV9kYWNfbmlkc1tzcGVjLT5tdWx0aW91dC5udW1fZGFjcysrXSA9CiAJCQkJc3BlYy0+bXVs
dGlfaW9baV0uZGFjOwotCX0gZWxzZSBpZiAoc3BlYy0+bXVsdGlfaW9zKSB7CisJfSBlbHNlIHsK
IAkJc3BlYy0+bXVsdGlfaW9zID0gMDsKIAkJYmFkbmVzcyArPSBCQURfTVVMVElfSU87CiAJfQpA
QCAtMTg5MSw3ICsxODk0LDcgQEAgc3RhdGljIGludCBjcmVhdGVfbXVsdGlfb3V0X2N0bHMoc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMsCiAJaW50IGksIGVyciwgbm91dHB1dHM7CiAKIAlub3V0cHV0
cyA9IGNmZy0+bGluZV9vdXRzOwotCWlmIChzcGVjLT5tdWx0aV9pb3MgPiAwICYmIGNmZy0+bGlu
ZV9vdXRzIDwgMykKKwlpZiAoc3BlYy0+bXVsdGlfaW9zID4gMCkKIAkJbm91dHB1dHMgKz0gc3Bl
Yy0+bXVsdGlfaW9zOwogCiAJZm9yIChpID0gMDsgaSA8IG5vdXRwdXRzOyBpKyspIHsK
--089e0112c7fee995d804ec6fa401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--089e0112c7fee995d804ec6fa401--
