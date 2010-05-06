From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: SPDIF out with HDA/Conexant 20561?
Date: Thu, 6 May 2010 14:02:17 -0500
Message-ID: <p2n6160a5131005061202u38f97418hd4d99fb1a5099012@mail.gmail.com>
References: <y2m6160a5131005041619wc625446dj652bc2f03c304118@mail.gmail.com>
	<1273032853.1653.1333.camel@laptop>
	<o2l6160a5131005050529j9068c371h6caa1f19aa77adb2@mail.gmail.com>
	<1273075140.1653.4259.camel@laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0050450146e3d4b8a20485f1942c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CA7B01037F3
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 21:02:18 +0200 (CEST)
Received: by gyd10 with SMTP id 10so174411gyd.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 12:02:17 -0700 (PDT)
In-Reply-To: <1273075140.1653.4259.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jerone Young <jerone.young@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0050450146e3d4b8a20485f1942c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I managed to have playback working for both PCM and AC3 in passthrough
mode, found out there is a configuration issue in the HDAudio codec.
By default the SPDIF pin isn't enabled, configuring it as PIN_OUT is
required. Also for some reason there's a switch that selects a quirk
for no good reason. I need to look into this, but here's the fix for
now.
The question is if SPDIF pin is never configured as out, did it ever
work for anyone using Conexant codecs?
Cheers
-Pierre


On Wed, May 5, 2010 at 10:59 AM, Jerone Young
<jerone.young@canonical.com> wrote:
> On Wed, 2010-05-05 at 07:29 -0500, pl bossart wrote:
>> > Are you using the Thinkpad Docking station with the S/PDIF on the side=
?
>> > The headphone jack on those doesn't have S/PDIF.
>>
>> Yes I am using the side coax connector on the docking station.
>
> I know the T61 is properly wired for it. Had a chance to try it in
> person. It also had a AD codec as opposed to conexant.
>
>>
>> > I have not been able to verify this so glad your email came.. but it
>> > seems like the T400, T500, & W500 do not actually work with it.
>> >
>> > Did you try under Windows & if so did it work?
>
> This has been the main issue. Can't get a total confirmation that it
> even works to begin with for these machines. Also Lenovo has removed the
> port from the recent line of docking stations.
>
> If I can find anything useful .. I'll reply back soon.
>
> I really wanted to remove the SPDIF port being exposed as it shows up on
> my X301 .. and X200 (They all have the same codec), but don't use that
> docking station. But the use case your trying to do is the only way to
> do it and it would only be with the T400/T500 & W500 .. though no where
> can I find someone clearly saying they got it to work (even with
> Windows).
>>
>> No I don't have Windows on this thing. For now I have no real way to
>> tell if the output is properly configured, if the connector works, if
>> the cable's bad...
>> Cheers
>> - Pierre
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Thanks,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Jerone
>
>

--0050450146e3d4b8a20485f1942c
Content-Type: application/octet-stream; name="cxt5051.patch"
Content-Disposition: attachment; filename="cxt5051.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8vxx1kd0

ZGlmZiAtLWdpdCBhL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyBiL3BjaS9oZGEvcGF0Y2hfY29u
ZXhhbnQuYwppbmRleCAxMTRhZjhlLi42M2UyZmIyIDEwMDY0NAotLS0gYS9wY2kvaGRhL3BhdGNo
X2NvbmV4YW50LmMKKysrIGIvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCkBAIC0xNzg0LDcgKzE3
ODQsOSBAQCBzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGN4dDUwNTFfaW5pdF92ZXJic1tdID0gewog
CXsweDE0LCBBQ19WRVJCX1NFVF9BTVBfR0FJTl9NVVRFLCBBTVBfSU5fVU5NVVRFKDEpIHwgMHg0
NH0sCiAJezB4MTUsIEFDX1ZFUkJfU0VUX0FNUF9HQUlOX01VVEUsIEFNUF9JTl9VTk1VVEUoMCkg
fCAweDQ0fSwKIAkvKiBTUERJRiByb3V0ZTogUENNICovCisJezB4MWMsIEFDX1ZFUkJfU0VUX1BJ
Tl9XSURHRVRfQ09OVFJPTCwgUElOX09VVH0sIAogCXsweDFjLCBBQ19WRVJCX1NFVF9DT05ORUNU
X1NFTCwgMHgwfSwKKwogCS8qIEVBUEQgKi8KIAl7MHgxYSwgQUNfVkVSQl9TRVRfRUFQRF9CVExF
TkFCTEUsIDB4Mn0sIC8qIGRlZmF1bHQgb24gKi8gCiAJezB4MTYsIEFDX1ZFUkJfU0VUX1VOU09M
SUNJVEVEX0VOQUJMRSwgQUNfVVNSU1BfRU58Q09ORVhBTlRfSFBfRVZFTlR9LApAQCAtMTk3NSw2
ICsxOTc3LDggQEAgc3RhdGljIGludCBwYXRjaF9jeHQ1MDUxKHN0cnVjdCBoZGFfY29kZWMgKmNv
ZGVjKQogCQkJCQkJICBjeHQ1MDUxX21vZGVscywKIAkJCQkJCSAgY3h0NTA1MV9jZmdfdGJsKTsK
IAlzcGVjLT5hdXRvX21pYyA9IEFVVE9fTUlDX1BPUlRCIHwgQVVUT19NSUNfUE9SVEM7CisKKyNp
ZiAwIC8vIFBMQgogCXN3aXRjaCAoYm9hcmRfY29uZmlnKSB7CiAJY2FzZSBDWFQ1MDUxX0hQOgog
CQlzcGVjLT5taXhlcnNbMF0gPSBjeHQ1MDUxX2hwX21peGVyczsKQEAgLTE5OTcsNyArMjAwMSw3
IEBAIHN0YXRpYyBpbnQgcGF0Y2hfY3h0NTA1MShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAkJ
c3BlYy0+YXV0b19taWMgPSBBVVRPX01JQ19QT1JUQjsKIAkJYnJlYWs7CiAJfQotCisjZW5kaWYK
IAlyZXR1cm4gMDsKIH0KIAo=
--0050450146e3d4b8a20485f1942c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0050450146e3d4b8a20485f1942c--
