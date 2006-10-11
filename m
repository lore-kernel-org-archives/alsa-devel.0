From: <mariook@wp.pl>
Subject: Re: [PATCH] Asus A6RP and ALC861 headphones problem
	solved
Date: Wed, 11 Oct 2006 18:36:02 +0200
Message-ID: <015701c6ed53$575da060$83030a54@MIREK>
References: <005701c6eb15$be16e590$83030a54@MIREK>
	<s5hlknpr4y0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0154_01C6ED64.1A504AE0"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0154_01C6ED64.1A504AE0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de>
To: <mariook@wp.pl>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Monday, October 09, 2006 3:31 PM
Subject: Re: [Alsa-devel] [PATCH] Asus A6RP and ALC861 headphones problem
solved

> At Sun, 8 Oct 2006 22:10:02 +0200,
> <mariook@wp.pl> wrote:
>>
>> Hi!
>>
>> I finally made it, now can use headphones with my laptop :)
>>
>> My last thread (started on 23 Sep 20:08) about my problem is quite long,
>> so
>> I decided to make a new one with result of my work - patched
>> patch_realtek.c
>> file.
>>
>> The patch I posted least time was good. The only thing that had to be
>> changed is to remove this line:
>> .need_dac_fix = 1,
>> from alc861_presets. With this line of code the patch doesn't want to
>> work.
>
> This implies that the headphone jack is connected to another DAC, most
> likely the side one (0x04).  The right fix would to add .hp_nid = 0x04
> in the preset table.  If 0x04 doesn't work, try 0x05 or 0x06 instead.

.hp_nid = 0x06 worked (as I understood it's surround nid  - I wrote earlier
that in my case hp jack is surr-out (0x09))

>> There is only one thing that I'm not sure...
>> When channel mode is changed to 6ch the sound is in built-in speakers,
>> line-in jack and mic jack, but not in hp jack (of course when i plug
>> something to hp jack the sound in built-in speakers disappears). Is that
>> correct?

Even with fix described above this is still a problem - when channel mode is
set to 6ch the sound in hp jack is not present (the surround output goes to
line-in jack, there is also clfe output in mic jack and no output is in hp
jack).

>> Because each time I make a patch file it doesn't want to work (I make it
>> with this command: diff -Nuar old.file new.file), I'm sending in
>> attachment
>> compressed patch_realtek.c file (I patched final version 1.0.13 of
>> patch_realtek.c). The only important changes are those connected with
>> asus-a6rp model, please ignore changes made in parts of code connected
>> with
>> other models.
>
> Oh no, please send a patch instead.  Otherwise we cannot review and
> check your changes.
>
> What do you mean "it doesn't want to work"?  If you changed a single
> file, you can just create a diff for that file, simply by
> diff -u orig-alsa-kernel/pci/hda/patch_realtek.c \
> new-alsa-kernel/pci/hda/patch_realtek.c

Ok, patch is in the attachment :)

> Takashi

Mariusz 

------=_NextPart_000_0154_01C6ED64.1A504AE0
Content-Type: application/octet-stream;
	name="asus-a6rp.patch.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="asus-a6rp.patch.tar.bz2"

QlpoNjFBWSZTWdflkEkACvh/hNc2AgBZf//+/+f/+///3/8ABAAIYAnfeFsevb3Ve3Whz0dAACgA
AchYSRU0IxoRkaaPUA0NDQMjQABo0ANAAANUxCaTwnommo09A1GAgDExGATyAJpo0NNA0Giqf5NK
n6Ih6jQ0BoNAAaBoBiGhoAMhpkaaCTUiEpvRTJtJ6p6T2lP1T1PU0NHqDQaDEABoNAaNB6jQ5k00
MgAYjIMgBpggYgGjTQAZA0ACJJAIJggagIxTTahiempk0xGj1Mj1NA0yaHpDT1Pu+n19tqXS9R8F
53/Da1zviFUwnj6K7UZBKtawpaBECfWWKYwgisCKKKBEVHtbcGmCohW6si/L4tGTo/10UqB0iCkM
v2tbDGjLOpEVwElMBEBgsDUrgJe88Jalgql2SkNQyqHC0oTHRhjgWrPG5vx1WtlkdETiiaQo/zAb
O+XO09xPbh94dAeogunoYRTYezce5ahn6L0Sb6KF9B4jjIzzHK7e7UycptUySc5LaheaIm0rzo0y
bt8qQ50A3MyAFpaAolVTFgUhror3N848A62GXdT3g7hkcsOk2Z2W2fimCb+AsRb/0i/nJY3dHD2a
7uuQJszzxASkARkNiQ8BklsQAeFVr9Fz1Uldow06bXjBERJRoKP5IpKDO1g6MDV/C7V6b5VWCTe5
NPDx12jqmtBUp0H2m3g8d99EQQLIKsnAKYCKdJVMxuoroIi0UFCgIZkuHMflPEJT0vTIzTe6VAQi
J0bKOjW1JATo2eIZDVhfh7da/N8Gk0OIdp4VsQ2Bb2R6vp17+jHs8tFVSVC+1a23MXtmGwnWOHk3
tcLoqiJ9B7LFCM1bQp2BviSC0BBIESI+UN378ezuzZg7w/GHJnjsD35Ipo2b1NUqqqfB3oHAkWSC
E0wk92B0ELb8rBrIOIdqqBygSNgIJthrYd+9kIcFyhGLTXcRPgaRB1jbWnBRGpMJSZQk7MgmnCxY
KZ2ATOZc1gxQ73KrxY6tN9H2ko5Uz8aABQClkakBGcKKcMU4GzMzRON+a19BoUXvimbayG6RvTa2
WPBAmJlwtU0yarZ6uv3Mrt06u/WhO2eTIz4sgUzOZKIol60TqrKOApZry0MJMmFWcOa3AV0CL0sf
UKlB9TUkYiGx4zrhQzsbdvgvceXCqoZRbZ2wN4x+OQrELFqGIc54fm+4S5idkyAulxJrGHUYssPN
yFBmaOfguZCSawDfGHuhRUpFFERGACjFAUSSgiXTlpruOBDyFYrhiXTDBsbeUM89Rsm+q4evr1Xb
CjZVkT6eFF5dRyoo2URV3QkLNryrqMvg4ikJIEuKAGDoh8CIGllf4phpZhxNdBW7+EScMDNsETIN
0MpMQ56XE19PBNL5fp0wm+9C4gkzyKtWrAbi4ml9HLXy7+hUUCtLc9l2rXfnLj0Bv6DzC5ZZ0beA
WosVUrZvC5sSfRTt73HwZxHwCmR07KM9lceOvTLG0uykdATxAv7qBOLhFMpBYL4jiQt8AI9QjN46
KkkmIAQV/RQ/KmagdJlZQfJ4LXlTEX5DO4mH6zQUPkEL1BiYOEO+afXVx6VAxfQIXo5v2HIz/a/i
kgSSSAn3JdQAXjwQOP2jmW5HqP9KDeKHNGI8TRdvTuM3l0nXhebQA2o1btQMRTHf6kcjJppDrACC
Haje9ZvTIz6B7EcsxbHDCdDgnAv4OBwxM31JE0QXaUJBCCBEyNeRHYXDfiC6wNiERiq7LyakDb1o
9SWGxEc0OqLr5hiUWRzDMhEjC7JBb1a93cUkUHVgj7QcE6zUKuZbyX0HALjlCRGhDlEQOBFNyOxQ
bi1I3DS9SagW8OsQ4IgajqQNQYALOBEpHqS9Inz859B/I1ey+WHPxG4OYAUOtApQ7hC3EzADiYIU
IWDqL4dQnWAEMsUMVpQ+pQfuTJsYiETEBaR4A/DeIfOSHmbfm/deW99v9NpPh7PFJoZnpKMafidV
wd41N5a1kPT9WzPMh/0NCjc5rEgWkVAU4O5gy+wi5Ul+R5Em2MptiUIYZeI7jMO+XHrMksnYvIPC
HadOSdZ9pkY8PN9+8HWG01D/zrx76vuvoPG/Mrq9Zu9jFsdwy8PMGuumxZKdUDWg5x7zUkk1lXEN
TvFuAhNU4hegbbkj4jna7cPdDUb6Lom5Oi6x2hszjiOX+CQdkA5lgyOjLfYyvQ4d1N5W8oridErJ
ztC11m4Kq7XW+7HHNKOBmFx+GaGZ8dLa7lhc3YFlKeIfUd49r2Oxzz5hIOA1pZ0TIfObBosXnUbW
HObzu0XXptgbwDxF6Wlsw7hgdPvH8DgWVOmOSWHv1l5Lwv873O2w0p2m46+zMLIbzmTWeNKvfKu4
NwV5zwkiZHUZRKhgNG7wltgGoWcAjs4HEiGvHkgczYd5oC9jR76vjBa8XfPr0Zf4HJryQMk7NZcP
uf+wSyaGrUUlETFnZKGmJyC0pNi64hsvwNzpczUk75YMcohjpisb9DBMEpSIZPyhMQt8ZJEwugGM
TNp6zuNR1wsdb2R7IBv7U3fEm3u4pehE7xojXgAua9jaajVe0nRpYWWXdGBhqsDY5DvOqWKKkkho
Ru0DikCAUkKQ5NQbzsT2W8wN5mnoOJIze7Xzi63N2AZDhpu5R8N106qkktlfFY9QbUEu5wNvCVbw
QoCwOBJeHEmgKaWgQ0hotcuFFBcS2cvVhmkC5UZskyoGNkIZF2PZgaDMFpcVvTAeQwMxzMbxpN77
200sHAc9hBbvXtNhjEZEndCMNlHzRsmowORQ8DRhDnAvdgNHEt+REWmBSPe2K7i36jFYsgSIkIv9
5IKUv2SHsWpZ41+SpCw9DKuXDTUhcRh5KohugkBWQf4u5IpwoSGvyyCS

------=_NextPart_000_0154_01C6ED64.1A504AE0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_NextPart_000_0154_01C6ED64.1A504AE0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_NextPart_000_0154_01C6ED64.1A504AE0--
