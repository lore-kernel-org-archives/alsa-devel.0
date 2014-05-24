From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Sat, 24 May 2014 13:10:41 +0800
Message-ID: <CAN8cciaAazGX4HZet+UgbWGN4iOk9hknCjYTtdwD+k+ptqakOw@mail.gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
 <535A6C96.7040109@gmail.com>
 <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
 <535B83E4.5050303@gmail.com>
 <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
 <535E908C.4030509@gmail.com>
 <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
 <535FDEA8.7010206@gmail.com>
 <CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>
 <5364CE4D.7040506@gmail.com>
 <CAN8cciYB-vD0Oeigv=rGt1XDSZvqGm_KpyV_HwARCg8LLFEQjg@mail.gmail.com>
 <536E26A4.1060002@gmail.com>
 <CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>
 <53705396.3070406@gmail.com>
 <CAN8cciZGaFs2dPq0FJzhqyrtn9-irGBv6wmTjG1aRcJcCviuHg@mail.gmail.com>
 <537F9AAC.2030204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c252c62209b704fa1e5ef9
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 28D862650DB
 for <alsa-devel@alsa-project.org>; Sat, 24 May 2014 07:10:43 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id r5so960616qcx.10
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 22:10:42 -0700 (PDT)
In-Reply-To: <537F9AAC.2030204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: sergemp@mail.ru, artur.stat@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

--001a11c252c62209b704fa1e5ef9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>
>>
>> The appl_ptr  can be placed in any position in the ring buffer for the
>> application to write data but the sound card fetch data from this ring
>> buffer sequentially, however snd_pcm_write() assume the maximum distance
>> between appl_ptr and hwptr is only one buffer
>>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/p=
ci/hda/hda_intel.c?id=3D2ae66c26550cd94b0e2606a9275eb0ab7070ad0e
>>
>> Do you mean hwptr does not decrease by one period when you use arbitrary
>> period sizes for hda-Intel  ?
>
>
> I cannot comment on this commit. But "snd_hda_intel.align_buffer_size=3D1=
"
indeed existed on my kernel command line (for no good reason now - so
removed), and I don't use a strange period size.

3.6.2 Buffer Descriptor List

There must be at least two entries in the list, with a maximum of 256
entries.

3.6.3 Buffer Descriptor List Entry

the buffers described by BDLE must start on 128 bytes boundary

refer to azx_setup_periods, if one period  represent one BDLE ,  the
buffers described by two periods must start on 128 bytes boundary

with default prealloc_max =3D 64,  pulseaudio are forced to use maximum
buffer size / period size which are also 128 bytes aligned

 when you specifiy prealloc_max =3D 4096,  one second 48000Hz is also align=
ed
to 128 bytes boundary but one second 44100 Hz is not

>
>
> Still, the bug (negative reported rewindable amount) also exists without
align_buffer_size=3D1.
>
>
>>
>> e.g.  48 samples (192 bytes) when using 1ms period time and  stereo
>> instead of 4 channels
>
>
> Not tested.

The implementation dependent FIFO Size  affect the number of the bytes that
could be fetched by the controller at one time.

3.3.40 Offset 90: {IOB}SDnFIFOS =E2=80=93 Input/Output/Bidirectional Stream
Descriptor n FIFO Size

FIFO Size (FIFOS): Indicates the maximum number of bytes that could be
fetched by the controller at one time. This is the maximum number of bytes
that may have been DMA=E2=80=9Fd into memory but not yet transmitted on the=
 link,
and is also the maximum possible value that the LPIB count will increase by
at one time.

>
>
>
>>
>> you program seen hang when using pulse plugin
>
>
> I am not interested in any more rewind-related bug reports for the pulse
plugin. This particular bug will be fixed, together with many others, by
always returning 0 from the .rewindable callback for ioplug if mmap_rw is
false.

why do you assume rewind is supported if mmap_rw is true ? any example

>
>
>>
>>  >
>>  >
>>  > How do I test this? Could you please post some userspace test code or
>> a kernel patch, together with the instructions?
>>  >
>>
>> Attach the patch to dump the values of the audio function group
capability
>
>
> There was no attachment.
>
>
>> There are three cases
>>
>> 1) delay in analog output > delay in digital output  e.g, idt codecs
>> 2) delay in analog output < delay in digital output e.g. adi codecs
>> 3) no delay in audio widgets ,  digital output and analog output have no
>> delay difference when output delay in audio  function group is non zero =
?
>
>
> Yes, that's logical.
>
>
>>
>> It is unlikely for ordinary user to measure the delay without using
>> oscilloscope since the Analog speaker and digital receiver also have
delay
>
>
> Correct. Also, while delay in analog speakers can be often rightfully
assumed to be 0 samples, this is not the case for digital receivers. In
other words, the delay on the digital path is in fact unknown.

If  13 samples delay in analog output is due to the five bands equalizer in
IDT codecs, the headphone should not has same delay since equalizer in not
present in the headphone path, may need to implement multi-channel capture
to find out any delay between headphone and line out

--001a11c252c62209b704fa1e5ef9
Content-Type: text/x-diff; charset=US-ASCII; name="afg_cap.patch"
Content-Disposition: attachment; filename="afg_cap.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hvkd5pix1

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX3Byb2MuYyBiL3NvdW5kL3BjaS9oZGEvaGRh
X3Byb2MuYwppbmRleCBjZTVhNmRhLi42NWMxZGE5IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRh
L2hkYV9wcm9jLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfcHJvYy5jCkBAIC00ODIsNiArNDgy
LDE0IEBAIHN0YXRpYyB2b2lkIHByaW50X3Bvd2VyX3N0YXRlKHN0cnVjdCBzbmRfaW5mb19idWZm
ZXIgKmJ1ZmZlciwKIAlzbmRfaXByaW50ZihidWZmZXIsICJcbiIpOwogfQogCitzdGF0aWMgdm9p
ZCBwcmludF9hZmdfY2FwcyhzdHJ1Y3Qgc25kX2luZm9fYnVmZmVyICpidWZmZXIsCisJCQkJc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMsIGhkYV9uaWRfdCBuaWQpCit7CisJaW50IGFmZ19jYXAgPSBz
bmRfaGRhX3BhcmFtX3JlYWQoY29kZWMsIG5pZCwgQUNfUEFSX0FVRElPX0ZHX0NBUCk7IAorCXNu
ZF9pcHJpbnRmKGJ1ZmZlciwgIjB4JTA4eCBPdXRwdXREZWxheT0weCUwMnggSW5wdXREZWxheT0w
eCUwMnggQmVlcEdlbj0leFxuIiwgCisJCWFmZ19jYXAsIGFmZ19jYXAgJiAweGYsIChhZmdfY2Fw
ID4+IDgpICYgMHhmLCAoYWZnX2NhcCA+PiAxNikgJiAxKTsKK30KKwogc3RhdGljIHZvaWQgcHJp
bnRfdW5zb2xfY2FwKHN0cnVjdCBzbmRfaW5mb19idWZmZXIgKmJ1ZmZlciwKIAkJCSAgICAgIHN0
cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBoZGFfbmlkX3QgbmlkKQogewpAQCAtNjgyLDYgKzY5MCw4
IEBAIHN0YXRpYyB2b2lkIHByaW50X2NvZGVjX2luZm8oc3RydWN0IHNuZF9pbmZvX2VudHJ5ICpl
bnRyeSwKIAlwcmludF9hbXBfY2FwcyhidWZmZXIsIGNvZGVjLCBjb2RlYy0+YWZnLCBIREFfT1VU
UFVUKTsKIAlzbmRfaXByaW50ZihidWZmZXIsICJTdGF0ZSBvZiBBRkcgbm9kZSAweCUwMng6XG4i
LCBjb2RlYy0+YWZnKTsKIAlwcmludF9wb3dlcl9zdGF0ZShidWZmZXIsIGNvZGVjLCBjb2RlYy0+
YWZnKTsKKwlzbmRfaXByaW50ZihidWZmZXIsICJBRkcgY2FwczogIik7CisJcHJpbnRfYWZnX2Nh
cHMoYnVmZmVyLCBjb2RlYywgY29kZWMtPmFmZyk7CiAKIAlub2RlcyA9IHNuZF9oZGFfZ2V0X3N1
Yl9ub2Rlcyhjb2RlYywgY29kZWMtPmFmZywgJm5pZCk7CiAJaWYgKCEgbmlkIHx8IG5vZGVzIDwg
MCkgewo=
--001a11c252c62209b704fa1e5ef9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11c252c62209b704fa1e5ef9--
