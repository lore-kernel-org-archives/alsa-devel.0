From: The Source <thesourcehim@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Sun, 26 Oct 2008 09:56:00 +0300
Message-ID: <49041480.7010506@gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk>	<4900DBBD.2020806@jasonline.co.uk>
	<s5hljwee68t.wl%tiwai@suse.de>	<49017FBF.4030005@jasonline.co.uk>
	<s5hfxmm47kb.wl%tiwai@suse.de>	<20081025130652.GA27621@rzle423.uni-duisburg.de>	<s5hej24psn6.wl%tiwai@suse.de>	<20081025194255.GA27872@rzle423.uni-duisburg.de>	<s5hod18fntg.wl%tiwai@suse.de>
	<49038448.3090704@jasonline.co.uk>
	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070001040907050604030109"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 78B5F10380E
	for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2008 07:56:21 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so18506ugf.24
	for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2008 23:56:03 -0700 (PDT)
In-Reply-To: <5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070001040907050604030109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Bjoern Olausson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Latest unstable (25Oct 19:57) works from command line with mplayer,
>> without the proc oss fix.
>>
>>    =20
> Confirmed.
> The stuttering got better, but is still present.
>
> Xine works flawless.
>
>  =20
>> aplay still works but only with dmix.
>>
>>    =20
> Samplingrate 11025Hz and 8000Hz do not play a clear sinus, sounds a
> bit scratchy..
> All other common samplingrates work flawless. Could someone confirm tha=
t?
> http://tmp.olausson.de/30days/0_16_s_8000.wav
> http://tmp.olausson.de/30days/0_16_s_11025.wav
> http://tmp.olausson.de/30days/0_16_s_96000.wav
>
> Just using "aplay file.wav"
>
> More noticable ist it when using mplayer. Crackles a lot with 8000Hz an=
d 11025Hz
> "mplayer file.wav"
>
> mmh, xine crackles too. Please someone confirm, otherwise the files may=
 be bad.
>
>  =20
>> Now also almost working in gnome with pulse, sound is recognisable but
>> with lots of interference/corruption.
>>
>>    =20
> No pulseaudio on my machine. Sry.
>
>  =20
>> Machine did not crash at any point!
>>
>>    =20
> Just observed a X crash when using smplayer to play a avi. When I
> closed smplayer while the movie was playing X crashed. (But could be
> unrelated to audio, I could not reproduce it)
>
> But no crash or freez so far.
>
>  =20
>> This was running on 2.6.26... is this a problem? SUPPORTED_KERNELS say=
s
>> 2.6.25 or earlier?
>>
>>    =20
> I am using vanilla 2.6.27.3
>
> Thanks for you awesome work!
>
> By the way, what's next on your plan when stereo output and recording
> is working flawless?
>
>
> kind regards
> Bjoern
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>  =20
--Tried the latest driver.
--All is fine (haven't tested recording however) except pulseaudio
--(doesn't work) and wine (sound is mega-glitchy, possibly because of
--strange period and buffer sizes it uses: period=3D544, buffer=3D8704).
--System is stable. OSS works fine.

--Also dmix causes horrible glitches everywhere. Was anyone able to make
--good dmix config?

Hmmm.. Looks like it is not dmix fault. wine requested something of
driver that caused all sound to be glitchy until driver is reloaded.
dmesg output with debug=3D3 is attached.
Here's some wine output:
fixme:wave:ALSA_ComputeCaps Device has a minimum of 2 channels
fixme:wave:ALSA_ComputeCaps Device has a minimum of 2 channels
fixme:wtsapi:WTSRegisterSessionNotification Stub 0x1004e 0x00000000
fixme:dsalsa:IDsDriverBufferImpl_SetVolumePan (0x1ac8c8,0x1ad118): stub
fixme:dsalsa:CheckXRUN Unhandled state: 0
mixer.c:305: DSOUND_BufPtrDiff: Assertion `ptr2 < buflen' failed.
wine: Assertion failed at address 0x60000812 (thread 001c), starting
debugger...
Unhandled exception: assertion failed in 32-bit code (0x60000812).
Register dump:
  CS:0023 SS:002b DS:002b ES:002b FS:0063 GS:006b
  EIP:60000812 ESP:7db9e740 EBP:7db9e74c EFLAGS:00200206(   - 00      -
-IP1)
  EAX:00000000 EBX:00001605 ECX:0000161a EDX:00000006
  ESI:602a607a EDI:602d2ff4
Stack dump:
0x7db9e740:  60198660 602d2ff4 7db9e86c 7db9e874
0x7db9e750:  6019a028 00000006 7db9e7ec 00000000
0x7db9e760:  602d2ff4 00000043 7d394298 00000068
0x7db9e770:  601db11f 7db9e7b0 7d3942a0 7d3942a0
0x7db9e780:  601ac78b 602d2ff4 00000043 7d3942a0
0x7db9e790:  7db9e85c 601d444b 7d3942a0 00000043
Backtrace:
=3D>1 0x60000812 (0x7db9e74c)
   2 0x6019a028 (0x7db9e874)
   3 0x6019157e (0x7db9e8b8)
   4 0x613afc86 DSOUND_timer+0x1336() in dsound (0x7db9e9a8)
   5 0x60a88bc8 in winmm (+0x28bc8) (0x7db9ea18)
   6 0x603471fe call_thread_entry_point+0xe() in ntdll (0x7db9ea28)
   7 0x60348832 in ntdll (+0x58832) (0x7db9eac8)
   8 0x60348a2d in ntdll (+0x58a2d) (0x7db9f3b8)
   9 0x6015b32f (0x7db9f4b8)
0x60000812: ret=09
Modules:
Module	Address			Debug info	Name (124 modules)
ELF	  1dd000-  20c000	Deferred        libgssapi_krb5.so.2
ELF	  227000-  24e000	Deferred        libexpat.so.1
ELF	  250000-  27f000	Deferred        libfontconfig.so.1
ELF	  281000-  28a000	Deferred        libxrender.so.1
ELF	  28c000-  38d000	Deferred        libx11.so.6
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
PE	  400000-  723000	Deferred        qip
ELF	  ab5000-  abd000	Deferred        libsm.so.6
ELF	  abf000-  ac3000	Deferred        libuuid.so.1
ELF	  ae9000-  aec000	Deferred        libcom_err.so.2
ELF	  af5000-  afc000	Deferred        libxrandr.so.2
ELF	  b1d000-  b20000	Deferred        libxcomposite.so.1
ELF	  b22000-  b3c000	Deferred        libice.so.6
ELF	  bf4000-  bf7000	Deferred        libkeyutils.so.1
ELF	  bfa000-  c18000	Deferred        ld-linux.so.2
ELF	  c1a000-  d83000	Deferred        libc.so.6
ELF	  d85000-  d8a000	Deferred        libdl.so.2
ELF	  d8c000-  da5000	Deferred        libpthread.so.0
ELF	  da7000-  dd0000	Deferred        libm.so.6
ELF	  dd2000-  dee000	Deferred        libselinux.so.1
PE	  ff0000- 1465000	Deferred        flash10a
ELF	 5ca1000- 5cb6000	Deferred        libresolv.so.2
ELF	 5d41000- 5d66000	Deferred        libk5crypto.so.3
ELF	 5d99000- 5dcb000	Deferred        libcrypt.so.1
ELF	 5f01000- 5f0a000	Deferred        libkrb5support.so.0
PE	10000000-10010000	Deferred        docking
ELF	6001e000-60155000	Deferred        libwine.so.1
ELF	602dc000-6038b000	Export          ntdll<elf>
   \-PE	602f0000-6038b000	\               ntdll
ELF	603b4000-604ff000	Deferred        kernel32<elf>
   \-PE	603d0000-604ff000	\               kernel32
ELF	604ff000-60558000	Deferred        advapi32<elf>
   \-PE	60510000-60558000	\               advapi32
ELF	60558000-60679000	Deferred        ole32<elf>
   \-PE	60570000-60679000	\               ole32
ELF	60679000-606e4000	Deferred        rpcrt4<elf>
   \-PE	60680000-606e4000	\               rpcrt4
ELF	606e4000-60704000	Deferred        iphlpapi<elf>
   \-PE	606f0000-60704000	\               iphlpapi
ELF	60719000-60733000	Deferred        version<elf>
   \-PE	60720000-60733000	\               version
ELF	60733000-607ff000	Deferred        comctl32<elf>
   \-PE	60740000-607ff000	\               comctl32
ELF	607ff000-60820000	Deferred        imm32<elf>
   \-PE	60810000-60820000	\               imm32
ELF	60820000-60944000	Deferred        shell32<elf>
   \-PE	60830000-60944000	\               shell32
ELF	60944000-609a3000	Deferred        shlwapi<elf>
   \-PE	60950000-609a3000	\               shlwapi
ELF	609a3000-60a52000	Deferred        comdlg32<elf>
   \-PE	609b0000-60a52000	\               comdlg32
ELF	60a52000-60ae9000	Export          winmm<elf>
   \-PE	60a60000-60ae9000	\               winmm
ELF	60b9f000-60c3f000	Deferred        winex11<elf>
   \-PE	60bb0000-60c3f000	\               winex11
ELF	60d79000-60d7b000	Deferred        libxcb-xlib.so.0
ELF	60d7b000-60d97000	Deferred        libxcb.so.1
ELF	60da0000-60da5000	Deferred        libxxf86vm.so.1
ELF	60dc7000-60dfa000	Deferred        uxtheme<elf>
   \-PE	60dd0000-60dfa000	\               uxtheme
ELF	60dfa000-60e34000	Deferred        libcups.so.2
ELF	60f2b000-60fa9000	Deferred        libgnutls.so.13
ELF	60ffb000-6100c000	Deferred        libtasn1.so.3
ELF	6100c000-6107b000	Deferred        libgcrypt.so.11
ELF	6107b000-6107f000	Deferred        libgpg-error.so.0
ELF	6109b000-610d2000	Deferred        winealsa<elf>
   \-PE	610a0000-610d2000	\               winealsa
ELF	610d2000-611b4000	Deferred        libasound.so.2
ELF	611be000-611d6000	Deferred        msacm32<elf>
   \-PE	611c0000-611d6000	\               msacm32
ELF	611d6000-611ff000	Deferred        msacm32<elf>
   \-PE	611e0000-611ff000	\               msacm32
ELF	611ff000-61214000	Deferred        midimap<elf>
   \-PE	61200000-61214000	\               midimap
ELF	61214000-61227000	Deferred        olepro32<elf>
   \-PE	61220000-61227000	\               olepro32
ELF	61227000-61255000	Deferred        d3d8<elf>
   \-PE	61230000-61255000	\               d3d8
ELF	61255000-61383000	Deferred        wined3d<elf>
   \-PE	61270000-61383000	\               wined3d
ELF	61383000-613d1000	Export          dsound<elf>
   \-PE	61390000-613d1000	\               dsound
ELF	613d1000-613e4000	Deferred        security<elf>
   \-PE	613e0000-613e4000	\               security
ELF	613e4000-6140b000	Deferred        netapi32<elf>
   \-PE	613f0000-6140b000	\               netapi32
ELF	6140b000-61439000	Deferred        ws2_32<elf>
   \-PE	61410000-61439000	\               ws2_32
ELF	61439000-6148b000	Deferred        wininet<elf>
   \-PE	61440000-6148b000	\               wininet
ELF	6148b000-614ae000	Deferred        mpr<elf>
   \-PE	61490000-614ae000	\               mpr
ELF	614ae000-61524000	Deferred        crypt32<elf>
   \-PE	614c0000-61524000	\               crypt32
ELF	61524000-61567000	Deferred        urlmon<elf>
   \-PE	61530000-61567000	\               urlmon
ELF	61567000-61585000	Deferred        mscms<elf>
   \-PE	61570000-61585000	\               mscms
ELF	61585000-615bd000	Deferred        liblcms.so.1
ELF	615bd000-615ff000	Deferred        shdocvw<elf>
   \-PE	615c0000-615ff000	\               shdocvw
ELF	63ef9000-63f05000	Deferred        libnss_files.so.2
ELF	66685000-66699000	Deferred        lz32<elf>
   \-PE	66690000-66699000	\               lz32
ELF	6c32d000-6c3d5000	Deferred        gdi32<elf>
   \-PE	6c340000-6c3d5000	\               gdi32
ELF	6c3e1000-6c53d000	Deferred        user32<elf>
   \-PE	6c400000-6c53d000	\               user32
ELF	6fbfd000-6fc34000	Deferred        winspool<elf>
   \-PE	6fc00000-6fc34000	\               winspool
ELF	735b3000-736af000	Deferred        oleaut32<elf>
   \-PE	735d0000-736af000	\               oleaut32
ELF	73903000-7392c000	Deferred        secur32<elf>
   \-PE	73910000-7392c000	\               secur32
ELF	7bf00000-7bf03000	Deferred        <wine-loader>
Threads:
process  tid      prio (all id:s are in hex)
00000008 (D) C:\Program Files\QIP\qip.exe
	0000001c   15 <=3D=3D
	0000001b    0
	0000001a    0
	00000019    0
	00000018    0
	00000009    0
0000000c
	00000014    0
	00000013    0
	00000012    0
	0000000e    0
	0000000d    0
0000000f
	00000015    0
	00000011    0
	00000010    0
00000016
	00000017    0
Backtrace:
=3D>1 0x60000812 (0x7db9e74c)
   2 0x6019a028 (0x7db9e874)
   3 0x6019157e (0x7db9e8b8)
   4 0x613afc86 DSOUND_timer+0x1336() in dsound (0x7db9e9a8)
   5 0x60a88bc8 in winmm (+0x28bc8) (0x7db9ea18)
   6 0x603471fe call_thread_entry_point+0xe() in ntdll (0x7db9ea28)
   7 0x60348832 in ntdll (+0x58832) (0x7db9eac8)
   8 0x60348a2d in ntdll (+0x58a2d) (0x7db9f3b8)
   9 0x6015b32f (0x7db9f4b8)


--------------070001040907050604030109
Content-Type: application/x-bzip;
 name="dmesg.out.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.out.bz2"

QlpoOTFBWSZTWc0qaasAcuXfgHAQQG9/8z/v/uq/59/QYAz/AA+lAolQKooAACioAFShFFVQ
5piZMmjCYJiaYBMAhgjAjAc0xMmTRhMExNMAmAQwRgRgOaYmTJowmCYmmATAIYIwIwHNMTJk
0YTBMTTAJgEMEYEYBNUlE0xNI00mQYmnqTPKmPSQYyJ5RtCaeoFJURGp5Q1PUyp6aaI0GQxp
tU8miDTTT1A08VUr91j3rYsltfqxxn25cYudbKfvfezyfHvVsK/Z9H1OzyfidH431P3vyM93
udnud6h47tw6PDo8PDu8M7+Nmdnh3qHseHDo8Ojw8O7wzu8M7PDuoey8OHR4dHh4d3hnd+FI
n3XS8+8tvQ29KOM7KfJTlO3XicccVOONGx1m2OXpVb5+DWnGi0dQmVZKr89x+GtTbaZraxo2
aZtjyk4U5vuU7qdEidFWDHaTQvK1OYrBhgYOKnBTFwVxJNKnBk1WrNEMqwebiBnBRwGGBg9n
FytsOKsU45JjSSwag1ZSmZUwZCyuV9F+W8VE/6iA9bX5ykXFhiEw1heKVU/bfZdRRcoDyRam
pJN9JJ20qq8UwlLuafG5XN2uJE+VQ1Ej2wl1KfOU5SJ9ZToq/KqwYNIYUxRorBgwwwMDBgwT
VRhaLWsRaSZU0qwYMzFGKMMMGDbCwtVqsqZU1r+EkL2VF+8Kf7oTBTKpYKZSHnRKfIqgfror
gpinrfSE+kGJmAzKJhRoLBhTA1FsU2EsFov65k0MSWDJSsoWIeR5NeN+1vC3yUuf0WFZYMzg
+qNmYP7DK7BzXBzVkuR+gYdBhwOKObyi1FqmRaGGVZuZGytmhsao5NaTyVaquoeQOhTykmLq
Oow0TodDqcGMODm6lwnAuC4K4HUZ0OThyNI5OpjoY4OeUzqWq4LLFwMY4uoYo6DqHQXVU6jq
MNE5uZPK8jyOpwcDqXUuhycpyV2qq9/hkVO7ZRd7+XfxrhHEazGY1ZWpPV9YZbLVYU8WqT0D
LL6uM83bzTh16BHMUvFaFWWCrLIGYV7WqOVVoUZT7b+XEQHw9HUV/8U1QymkVfrIrTJkMq1F
mqli0B3L0JaFW6YCPB3+XWtaasTMyxazViEe6oeQPC9OBUu1RdNUXaov5VFhLVF3cMzMzNUN
UMzMzMzMzMzMzMzMzOsPlXqys4U8iS7egeVRedSnYJ63P1kT2ipZTEJlMDFkC9hVeqUHMMpy
VXB5urMzMwjVDWMzMzMzMzMzMzMzOg6VVL0PqcjkCwwJP2+YnI7HY7VFqlO4TlyYxjGMZlQ0
oY1YxjGMYxjGMYxjGMYxjJ0Sh5ye80nNVS7neuD787u0Pe8KvCr815D0GA+LtX9A+InZV2qv
h7x9I6K92TTa2DK7gPdD2yZ4DoPOT2eo7KefF+HXlmZmsz3x2Op3HEnRPgnB2X0eX4h1U9in
QcD5h7ASeUU0T0HgdR9NQ5jkJ86rBOQnCrlVwzVqPMfNJ38xrrgXCrA8lXllfJz06hT4hFgL
5ziiryE7jmTF04dfaOyqL2jwPMe6+B69w9jvUPh60qPOPb5m1GxEfQkon2FP01DiiVdnKchT
wCnzzQpoU7tVS1VH5FXxVdOgToE6Kuir4kkv0Eu6i66LfVXZRZTSSemeyf1FX5T1Cr+8W2i9
oK9LppVVqgqr1Cr1iKT85/hA4TSK3TVFhKXCi2wq91F7aLTnlPeIpNlF56Lnm18809ySTjMl
QVvouNFtV/yY3CrcCttRXiwqQ4SmRfrF7wvpFW+aot81BS4ttRckDqFXQKuZwouLbFsUnoch
FJvbAvCwoVxi521jjFvouYUVWosotoXALVF73xiKTcCtkkn/bJJOytjvqE+mhT6u5V20WRMJ
/lH23+D9MfYOQn3BPYPl96onyKfZy+1UE6espF6qLmoKaFIeQl0qGolPl7ah7Qmj3XSPXoPV
UT/v2FSnV1ZmZmVPmSVc9W+G+GiFbqLykKaVz01O17hUupTuU93BTXwe1mZmZxRKdPA7DR4V
aTqO94qH7O697uZmZnW/gkT4Kr30TUmkxJTwqo9o/d9pT+aoeVQ+P3UFNYwpF21fB9ak5ikX
k6eVCL3fMKvHxnMKRfXJS5PO3/nVS66soemBWxCL4UIvP0SSp6/V6SRPmSJ01RKfq/GEHr6d
m7RKWySlp4xVrXU9ZKXfUJ5oVdHob6LKCnofy4aJS7ak3FIuRCm0LdtoU+j+mzElLva8fz7U
qLkRinkU+lJKe5zdUKc27dRcVCj5J09BKW2SRZImwjpUP7dRKcVD4FPH5th1UWyaFIvByhS2
0FOj4Qj/fvKdIgPZZVFr2FPeU7CJtCXThSL5pu6ZKXyovBJS6qEXGeHY7McX3SCXKFX/xdyR
ThQkM0qaasA=
--------------070001040907050604030109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070001040907050604030109--
