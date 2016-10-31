From: Kai Riedel <kairiedel@yahoo.de>
Subject: BeagleBone with TLV320AIC3100
Date: Mon, 31 Oct 2016 09:07:45 +0000 (UTC)
Message-ID: <1786779841.1841022.1477904865509@mail.yahoo.com>
References: <1786779841.1841022.1477904865509.ref@mail.yahoo.com>
Reply-To: Kai Riedel <kairiedel@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_1841021_2112800894.1477904865509"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm49.bullet.mail.gq1.yahoo.com (nm49.bullet.mail.gq1.yahoo.com
 [67.195.87.85]) by alsa0.perex.cz (Postfix) with ESMTP id 67B1E26663B
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 10:10:45 +0100 (CET)
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
Cc: peter.ujfalusi@ti.com, kai.riedel@turck.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

------=_Part_1841021_2112800894.1477904865509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

perhaps you could help me, I try to use a TLV320AIC3100 with the BeagleBoneBlack, kernel 4.4.28-bone14 and the dts file in the attachement. The dts file based on the instructions from Robert Nelson on https://github.com/beagleboard/bb.org-overlays. I have to uncomment the line clocks = <&clk_mcasp0>; in the dts file, because I get error otherwise. Enable the device with slots delivers:

[  386.783276] bone_capemgr bone_capemgr: part_number 'BB-BONE-AUDI-04', version 'N/A'
[  386.791191] bone_capemgr bone_capemgr: slot #4: override
[  386.796670] bone_capemgr bone_capemgr: Using override eeprom data at slot 4
[  386.803724] bone_capemgr bone_capemgr: slot #4: 'Override Board Name,00A0,Override Manuf,BB-BONE-AUDI-04'
[  386.847899] bone_capemgr bone_capemgr: slot #4: dtbo 'BB-BONE-AUDI-04-00A0.dtbo' loaded; overlay id #0
[  386.876502] 2-0018 supply HPVDD not found, using dummy regulator
[  386.891280] 2-0018 supply SPRVDD not found, using dummy regulator
[  386.903157] 2-0018 supply SPLVDD not found, using dummy regulator
[  386.910660] 2-0018 supply AVDD not found, using dummy regulator
[  386.917471] 2-0018 supply IOVDD not found, using dummy regulator
[  386.923560] 2-0018 supply DVDD not found, using dummy regulator
[  386.932676] asoc-simple-card sound: tlv320aic31xx-hifi <-> 48038000.mcasp mapping ok

So I think this should be OK. In the alsamixer I can change the volume and on the I2C I see telegrams
by changing the volume. But if I try to play sound with speaker-test I get errors again:

>
> >speaker-test 1.0.28
> >
> >Playback device is default
> >Stream parameters are 48000Hz, S16_LE, 1 channels
> >Using 16 octaves of pink noise
> >Rate set to 48000Hz (requested 48000Hz)
> >Buffer size range from 16 to 32768
> >Period size range from 8 to 16384
> >Using max buffer size 32768
> >Periods = 4
> >Unable to set hw params for playback: Invalid argument
> >Setting of hwparams failed: Invalid argument
>
> dmesg delivers:
> >[  106.776874] Division by zero in kernel.
> >[  106.780963] CPU: 0 PID: 606 Comm: speaker-test Tainted: G           O    4.4.28-bone14 #1
> >[  106.789321] Hardware name: Generic AM33XX (Flattened Device Tree)
> >[  106.795654] [<c0013e85>] (unwind_backtrace) from [<c0011f39>] (show_stack+0x11/0x14)
> >[  106.803580] [<c0011f39>] (show_stack) from [<c037070f>] (Ldiv0+0x9/0x12)
> >[  106.810510] [<c037070f>] (Ldiv0) from [<bf9952df>] (aic31xx_hw_params+0x96/0x370 [snd_soc_tlv320aic31xx])
> >[  106.820849] [<bf9952df>] (aic31xx_hw_params [snd_soc_tlv320aic31xx]) from [<bf88d3bf>] (soc_dai_hw_params+0x16/0x34 [snd_soc_core])

Quite fatal error even because of division by zero in aic3 1xx_hw_params(). I guess it either doesn't validate its parameters or gets values that should not happen.

By the way with an original Audio_Cape_Rev B and Kernel 3.8.13 everything works fine. The TLV320AIC3100 is connected to the BeagleBone in the same way, but in the Kernel 3.8.13 is no support for this device so I have to use a Kernel >4.1.

Greetings,

Kai
------=_Part_1841021_2112800894.1477904865509
Content-Type: audio/vnd.dts
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=BB-BONE-AUDI-04-00A0.dts
Content-ID: <lt6D1g5xEbOpSglmHhtS>

LyoKICogQ29weXJpZ2h0IChDKSAyMDEyIFRleGFzIEluc3RydW1lbnRzIEluY29ycG9yYXRlZCAt
IGh0dHA6Ly93d3cudGkuY29tLwogKgogKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsg
eW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogKiBpdCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcwogKiBwdWJs
aXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KICovCi9kdHMtdjEvOwovcGx1
Z2luLzsKCiNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4KI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3BpbmN0cmwvYW0zM3h4Lmg+CgovIHsKCWNvbXBhdGlibGUgPSAidGksYmVhZ2xlYm9u
ZSIsICJ0aSxiZWFnbGVib25lLWJsYWNrIiwgInRpLGJlYWdsZWJvbmUtZ3JlZW4iOwoKCS8qIGlk
ZW50aWZpY2F0aW9uICovCglwYXJ0LW51bWJlciA9ICJCQi1CT05FLUFVREktMDQiOwoJdmVyc2lv
biA9ICIwMEEwIiwgIkEwIjsKCgkvKiBzdGF0ZSB0aGUgcmVzb3VyY2VzIHRoaXMgY2FwZSB1c2Vz
ICovCglleGNsdXNpdmUtdXNlID0KCQkvKiB0aGUgcGluIGhlYWRlciB1c2VzICovCgkJIlA5LjMx
IiwJLyogbWNhc3AwOiBtY2FzcDBfYWNsa3ggKi8KCQkiUDkuMjkiLAkvKiBtY2FzcDA6IG1jYXNw
MF9mc3ggKi8KCQkiUDkuMjgiLAkvKiBtY2FzcDA6IG1jYXNwMF9heHIyICovCgkJIlA5LjI1IiwJ
LyogbWNhc3AwOiBtY2FzcDBfYWhjbGt4ICovCgkJLyogdGhlIGhhcmR3YXJlIGlwIHVzZXMgKi8K
CQkiZ3BpbzFfMTgiLCAiZ3BpbzFfMTkiLAoJCSJtY2FzcDAiOwoKCWZyYWdtZW50QDAgewoJCXRh
cmdldCA9IDwmYW0zM3h4X3Bpbm11eD47CgkJX19vdmVybGF5X18gewoJCQlib25lX2F1ZGlvX2Nh
cGVfYXVkaW9fcGluczogcGlubXV4X2JvbmVfYXVkaW9fY2FwZV9hdWRpb19waW5zIHsKCQkJCXBp
bmN0cmwtc2luZ2xlLHBpbnMgPSA8CgkJCQkJMHgxOTAgKFBJTl9JTlBVVF9QVUxMRE9XTiB8IE1V
WF9NT0RFMCkJLyogbWNhc3AwX2FjbGt4Lm1jYXNwMF9hY2xreCAqLwoJCQkJCTB4MTk0IChQSU5f
SU5QVVRfUFVMTERPV04gfCBNVVhfTU9ERTApCS8qIG1jYXNwMF9mc3gubWNhc3AwX2ZzeCwgSU5Q
VVQgKi8KCQkJCQkweDE5OCAoUElOX0lOUFVUX1BVTExET1dOIHwgTVVYX01PREUwKQkvKiBtY2Fz
cDBfYXhyMC5tY2FzcDBfYXhyMCAqLwoJCQkJCTB4MTljIChQSU5fSU5QVVRfUFVMTERPV04gfCBN
VVhfTU9ERTIpCS8qIG1jYXNwMF9haGNsa3IubWNhc3AwX2F4cjIgKi8KCQkJCT47CgkJCX07CgkJ
fTsKCX07CgoJZnJhZ21lbnRAMSB7CgkJdGFyZ2V0ID0gPCZpMmMyPjsKCQlfX292ZXJsYXlfXyB7
CgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJY2xvY2st
ZnJlcXVlbmN5ID0gPDEwMDAwMD47CgkJCXN0YXR1cyA9ICJva2F5IjsKCQkJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsKCQkJcGluY3RybC0wID0gPCZpMmMyX3BpbnM+OwoKCQkJdGx2MzIwYWlj
MzEwMDogdGx2MzIwYWljMzEwMEAxOCB7CgkJCQkjc291bmQtZGFpLWNlbGxzID0gPDA+OwoJCQkJ
Y29tcGF0aWJsZSA9ICJ0aSx0bHYzMjBhaWMzMTAwIjsKCQkJCXJlZyA9IDwweDE4PjsKCQkJfTsK
CQl9OwoJfTsKCglmcmFnbWVudEAyIHsKCQl0YXJnZXQgPSA8Jm1jYXNwMD47CgkJX19vdmVybGF5
X18gewoJCQkjc291bmQtZGFpLWNlbGxzID0gPDA+OwoJCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiOwoJCQlwaW5jdHJsLTAgPSA8JmJvbmVfYXVkaW9fY2FwZV9hdWRpb19waW5zPjsKCQkJc3Rh
dHVzID0gIm9rYXkiOwoJCQlvcC1tb2RlID0gPDA+OyAgICAgICAgICAvKiBNQ0FTUF9JSVNfTU9E
RSAqLwoJCQl0ZG0tc2xvdHMgPSA8Mj47CgkJCW51bS1zZXJpYWxpemVyID0gPDE2PjsKCQkJc2Vy
aWFsLWRpciA9IDwgIC8qIDA6IElOQUNUSVZFLCAxOiBUWCwgMjogUlggKi8KCQkJCTIgMCAxIDAK
CQkJCTAgMCAwIDAKCQkJCTAgMCAwIDAKCQkJCTAgMCAwIDAKCQkJPjsKCQkJdHgtbnVtLWV2dCA9
IDwxPjsKCQkJcngtbnVtLWV2dCA9IDwxPjsKCQl9OwoJfTsKCglmcmFnbWVudEAzIHsKCQl0YXJn
ZXQtcGF0aD0iLyI7CgkJX19vdmVybGF5X18gewoJCQlzb3VuZCB7CgkJCQljb21wYXRpYmxlID0g
InNpbXBsZS1hdWRpby1jYXJkIjsKCQkJCXNpbXBsZS1hdWRpby1jYXJkLG5hbWUgPSAiQXVkaW9D
YXBlIFJldiBCIjsKCQkJCXNpbXBsZS1hdWRpby1jYXJkLHdpZGdldHMgPQoJCQkJCSJTcGVha2Vy
IiwgIkhlYWRwaG9uZSBKYWNrIjsKCQkJCXNpbXBsZS1hdWRpby1jYXJkLHJvdXRpbmcgPQoJCQkJ
CSJIZWFkcGhvbmUgSmFjayIsICAgICAgICJIUEwiLAoJCQkJCSJIZWFkcGhvbmUgSmFjayIsICAg
ICAgICJIUFIiLAoJCQkJCSJTcGVha2VyIiwgICAgICAgICAgICAgICJTUEwiLAoJCQkJCSJTcGVh
a2VyIiwgICAgICAgICAgICAgICJTUFIiOwoJCQkJc2ltcGxlLWF1ZGlvLWNhcmQsZm9ybWF0ID0g
ImRzcF9iIjsKCQkJCXNpbXBsZS1hdWRpby1jYXJkLGJpdGNsb2NrLW1hc3RlciA9IDwmc291bmRf
bWFzdGVyPjsKCQkJCXNpbXBsZS1hdWRpby1jYXJkLGZyYW1lLW1hc3RlciA9IDwmc291bmRfbWFz
dGVyPjsKCQkJCXNpbXBsZS1hdWRpby1jYXJkLGJpdGNsb2NrLWludmVyc2lvbjsKCgkJCQlzaW1w
bGUtYXVkaW8tY2FyZCxjcHUgewoJCQkJCXNvdW5kLWRhaSA9IDwmbWNhc3AwPjsKCQkJCX07CgoJ
CSAgICAgICAgIHNvdW5kX21hc3Rlcjogc2ltcGxlLWF1ZGlvLWNhcmQsY29kZWMgewoJCQkJCSNz
b3VuZC1kYWktY2VsbHMgPSA8MD47CgkJCQkJc291bmQtZGFpID0gPCZ0bHYzMjBhaWMzMTAwPjsK
CQkJCQkvL2Nsb2NrcyA9IDwmY2xrX21jYXNwMD47CgkJCQkJY2xvY2stbmFtZXMgPSAibWNsayI7
CgkJCQl9OwoJCQl9OwoJCX07CgoJfTsKfTsK

------=_Part_1841021_2112800894.1477904865509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_1841021_2112800894.1477904865509--
