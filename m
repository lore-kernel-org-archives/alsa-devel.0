From: =?ISO-8859-1?Q?=DClo_Mets?= <umets@osa.pri.ee>
Subject: Re: Conexant 5051 lenovo-x200 fixes
Date: Sat, 20 Aug 2011 18:14:20 +0300
Message-ID: <4E4FCF4C.5070402@osa.pri.ee>
References: <4E4C60AD.2090806@osa.pri.ee>	<s5hzkj7t4ju.wl%tiwai@suse.de>	<4E4DA7BA.5020704@osa.pri.ee>
	<s5h62lulzx2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030302050201020003020907"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from polaris.osa.pri.ee (polaris.osa.pri.ee [194.204.58.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 689C324417
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 17:15:00 +0200 (CEST)
In-Reply-To: <s5h62lulzx2.wl%tiwai@suse.de>
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
--------------030302050201020003020907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08/19/2011 08:43 AM, Takashi Iwai wrote:

> At Fri, 19 Aug 2011 03:00:58 +0300,
> Ulo Mets wrote:
>> On 08/18/2011 01:08 PM, Takashi Iwai wrote:
>>> At Thu, 18 Aug 2011 03:45:33 +0300,
>>> Ulo Mets wrote:
>>>> Hi,
>>>> I am not a kernel developer, but occasionally dig into it if something gets in my way.
>>>> On Lenovo X200 Tablet none of the mixers showed Mic Boost adjustments, but HDA-Analyzer found them
>>>> and adjusted properly. So I inserted the corresponding controls, and it worked.
>>>> Then, during testing I found that the labels of External and Docking Mic are swapped,
>>>> so I exchanged these too. Since I could not test it on other hardware, I put it all on lenovo-x200 branch.
>>>> The patch applies to 3.1-rc2, I hope it is sufficiently recent.
>>>> The Mic Switches don't have any effect on my unit (X200T without modem)
>>> Could you try model=auto instead of patching?
>>> The recent auto-parser should work better.
>> Model=auto seems to give a very generic configuration, which indeed does 
>> include working
>> Mic boost for Internal Mic. (Ext?) Mic Boost and gain are also present, 
>> but jack sensing does not work,
>> so these cannot be tested.
> The automatic mic-switch by jack-sensing works without model=auto,
> right?  Then we need to fix it.  Could you give alsa-info.sh output?
>
Right. The alsa-info.sh output is attached.

>> It would be nice to get the mute switches to work as well.
> Which mute switch do you mean exactly?
I see the "Mic Switch" controls in the input nodes 0x14 and 0x15, and some Mute controls

with hda-analyzer. But it may well be just wishful thinking. I wonder if anybody has seen the 
datasheet of CX20561?

Regards,

Ulo


--------------030302050201020003020907
Content-Type: application/x-gzip;
 name="alsa-info-x200t.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="alsa-info-x200t.txt.gz"

H4sICKbGT04AA2Fsc2EtaW5mby1ub2F1dG8udHh0AO08a3PjOI6fw1/Bna3bdPbimJTlZ1Wu
zmOnu32b18Xp7pnKply0RDuc6DWSHCd7Nf/9AOph2bHsPG/2elbtjiU+ABAAAZCENQscX9iH
cTiTf4msUAVxcm+J0FbexD8kf/rTn7dc0KR7POzSAbQPXREr36NDDYveUXZgHjTYU6BAm7RX
KDzqex06FDHtzqbUYJQbHaPeqdXol8sePHNOsP2x8mb3tK+iOFTjGSKGwsqji5BuaN3QpPXf
Q/rh794e/HH2NJD+yaBI+mMIhJwIbzYRVjwLZdih+jo+Oj37ekbOQ9+eWTE9Fa5Ma5pmvfbt
6Fte9VWGkcLhUHp5o7zbc2HTnwzG6KUYOzLWNPxNhp50NpOhKUkbhtKRIkow1g5YpXvR+0zO
AhlCX29Khw9RLF2o/XT6paqHrTmgYqnHkBJ632qMGibSacko8rORwTXwYul8uNijPT+UHy5P
9gzan/m0d/6FfmnXgPT/pPzAYJ8+/4MMT87pkYcjsbP+P8tID0orRTr6leEQ0g/VnQzp3YI5
FGCyA8Mkx2ocivBhqS6pOuDkS6wcFSsZFarTSiPRCdBnaVON3AUJOEDNOl4CDZFnj25sMVI4
XBKjcAJhj4QVKA1q6M88mw5liKhAIyk0iWikmbseZgH4fwnrtkMyfkaxcIBFtILcoR+qsyis
jpVX/QVa2Xtps4uZ56H4KvTUXxCAUzECiVv+1FMRwBg/6NFtoQBIoIxeaVHmgqXXHfq5360k
pRW8T4RN6Norr6cwFdn9xGiA4oL8VfgrNevEaNOrTKePehmCXMuhqLJ46vle5DsSZrStfHyK
Q78M7+ZOSAzADuUUaKqxfTqZ0+a3z5e8/e1bBZShoZl33hvQAgNVLgOFgpRPk2ORnYx1+PiA
pbTY8k5ZMJUS9sBECfwwsX0to8X4gH4Y9D636UfhKudhDzi5PAYHlP9DKMFA1hIz1LXvhGdp
8hZmtEJxFF+lZ/thta8xVoezcUI6HfR3S3T7mSNiJqt1aIu1Gh2jXZMLwnZyZB3Km0J0DDZZ
mmaRniLJPKN+gERvJgn7nujmHbo8/3bGtjMK/Ggk7F8ooNuvvOMHsEkZjIBwqXG96h/ZkdoC
AqSf91/1L4M0ciMF0JBOZcPNB2/mOHv73+sXjNKz5b0e8TuLHSXu/BE4GogYYp4/wkD9SKHd
GU0UahDbf9U/hDeX4SgSdzifl55H1sJ2w1SHqtAfw1wV0e3/heom2HzPeXiLYUYQaYChsVy0
L6dFs7wcCO2MQzW9iT0IEUe5mTOWilMrahbtINzfQzyqXOmB2004ORFexkKNcwccnSVHuAJJ
nm/8+FY+jEIJvjTOwLLUBi4CjYK5qNcarSZrcyDozndmLgxIBGKcxYi6d1ZRxJyWpShq2qUt
AqMeFFtFR7zZy5JKBWKLMLZANUQQSfRyGkQHvb28F15MexDy1xucfvgsQ9ePxB7p2nYI3EMS
ux8/0Y8zz9I+fwCBNLuHljMMfSjfI4n/zyrMCa+zOieFOCCpAP9scD4mFxAnRAVIGLExcupT
EDC0zhF9Cv1ZQCfowUlfTsTMiSHcOEmCVohlgH9X0L3BIKYzTQBDzRYGf+0GwsNGYxXrNhJa
8Aau0yB8x4qEcUl/qAOoOYauGwCXKYgJhn5a7S5VnM3iQs2n88FZhyr/0Nyn/iHEeQr/aLYo
CxYz9iHfp3NxKw+RnMHZFVKaqCA2tFWIX0mDfRrFyrp90BUiFjmkrC9/RV/jFX1rL+t7ipqL
wqVXSVwJrAtm8TWdI/+gxuIg/WEsQ+nnrL2oHgPSNALtUA8WrYc/nAhQopCeO+JhDKsR+lVP
jR+A2zjJNG4deB4mMk97A8gOtW6iw1pCNICHHrZu708i3bifhsgJnt7Z6dFP3dNL2vWE408B
QfwQQLkm/4clLMuqoMHdm2KfQggvg+xB36t/QI97BkS4s3i5851woDOqYM3GdYJ9nYwdFnMx
LuOjOJTCRXqtG+HBqlr3fjwB6usnAOVt4yXzAFCgQwH0iAAI7DPa57QPS+xaVgnEyRhX8od9
IA83HoQDt7nQ+fOF/sYsNQXFP98PS40yloJJzVnaV1MF3uzxHBoc9dr11mIOQTWFeXVbMou2
9D4P/Vf0Tu3pyzoP5wrCxmf1LbiOJ8JZsQuZi0y5mxuG4Xl/8HFhGPhTdC2F0VncgsbHcuqH
D+gL16vja11cPdFD2u3Vcn2q0asfYYVJP0kPd+XAfX9T9lQWFKuJbhlChBPfyyfrYyZrIC+1
zbzcNm9Es1F6z0KzzuygacnNDj4UzA5vbjQ7jF3nHDazGTvwliYsSNHm4yUzCPHGWteH0V4I
3oieKOuFfm/gbWPtEpJncvbJSF4/AL4R9uvo5m8UE+Rx4xr/VWeb/Rf0LbgvE92XeV28f4p5
GfYHlaF0pBVj2P4etuQtfJoeiCd1lI9rNb2lCqDtv+plQj6D6q+fQX3fusUt6/ecQEUcbzZ/
3kWdvlcV4rkKtXLladCrc+VBMzdw5P1CeUzG6q08ZEI8yoMqdL764uDyzr5c0s/nYAvwQCpp
kocR0M40uMkmrEOv8BDlGpuiG8Bd/3uIZ3HfIZO2Rw8pr7b24d4BH3sIi1opPV0LALtR5Fsq
2Uo/xPOLfTqUv86kZ0n9zBLcFStGSSKFKIoviwVmh8ZielgDp5Qs0Wwdhbz9zGR6ZvKcuc1y
5pqt1Zm5XpsZK3pZc0mbjVUvu6TNrIasqF2vyo4bhtmhg9OF3Cj9GspJirbOaIs9EmaDC95O
hAlL+ms9iUGQQwg3LqQIS+UIUG5fKsaUzK8XRx9HmqTHEm29lUQzibW+G4kxM5dYMv1SkW2f
e+8ss/Zby6z9UhNmJiasxH41eG6/tMovzNdWrX+V9TKZJuufw4KJDbxlZbzl+El4e9Q970Mt
fqF2dLKCZVa3GW8yrln9Ud1L+5oOAyluYWzAbQi89TZigdlJmLng9xfv1vPnz+I4hfkQWfB4
ejY6vzgaHp32jkoF8f58Hm/iM0tWl6/lMipzymWt0GfxTcJhNAkrHE45+j2x2CpncZOt2xxa
NRcLWv94bF2EjkbOUHuDr2Rv4CsnL/GVjBkMXdAaGyMayzYmdYhr7EuqA+8tpgWlr/aBkl6l
x0tAnvKk/WifaqKZk1qSSgUaF8+5sjyvZF1PPQC7NgGEECucV+AD179TTkPfB5eoV5+cN/Yp
beapfvWOYdIqrOuqkWdX02O7HtsGwNgCwGhvg9AogXAz77H+Vvz1kt6B5WJ3a1t/c3P/YFv/
2sb+vNifruvPS/pH8tctqGtlqGPlypCQ/Hn8UAlEfNMhsY87s4zY4fw+rOAHxKfB6j8Qli5D
PCi2rBVaGsZqywPiYFP9yWhNgPIVDQksVdGqnaVBVf4DuhcUrhTQyngDR8S4/q4snZyvgAP1
05MFGj9Uu5jOF9rU14cNj5Iju+fH3Z8J+Stc9FhFMRg9ikU/dnt/o59FaM9FKNMpF1FsRjDJ
jbIsHe0qT9y7znZIsHJlu41erRSgURzOxkkHMCi8yosl9M8AIyo8PQErL5yBZzvyV6slz8ZL
uhdHvbOL/gqPet3zyy8XR/9ULEKZu+A3wvXC1glx6e2JbpYqTIRbOjShOU3jvCakh8838w6j
u7pot7q7OUdzl6A/Qbi4mbbTobvlKQm72ne7ATTw4gjbAuxOlnCwnyUY7OsQEq7dxV5dlORt
4qYUskOhZ6dWHGJFh7ZIWuIWR0h3k6Pn3X0dNBTyNjo0SBI0aBDpDb/su/KLr31UIL2Ziy4u
O7FId9ig58cQoNNjOYlpJX3IVq3HylUxNMl7wZSnTdw/Q9+GWz+LzoVWwKKrlvFv1/SqwmsH
jNk/wq3vXeftNfyndFjPhfPeyUYWvN1YjXp922ChCb0C8SL1LKG9dJzr2pYIWlnrhrgq5BeN
FEBiUvvz2ILc0NsMRSY0WiC3upZbIxVbTso6gW9tv54ZybnpWpE/W9vT5Z0WaRH5ZLIZe/HU
9n0pKWUDHjlu1PvkO0f9UorWzoTaY1LByrJkzra2z9nCmcS/FDtXrcJJ5x+RK9s9+fIPJgr+
HCp2FxXg1V/5C4jHbr/4q4xHTZe9/lq/vsat8xI9SEl+d7uiYysngkWtUxpcPU7N1KvlgyRi
+h+yk1J9wPFhR00EhG0ng5+OLuAJebes1ukh5y5U3glnJmHV0GjlDzx5sHwX0141wB1h4a+r
6G4ogffzUMW68w6ec8Ma/vLok8YEfWbQw8DbUHhTQJvorG5sj13l0UrTZCx9FPe0kT1khFRW
SnhW8hvBTzZQ42kDTU5aiwPFHwYWhpo+PnmwP56dHR91T5cHu0xarZS074P15sbx/R4cr5dS
9Phk//8z5xtPGufvIYFmuU6sTcxdkgIvSoG/qRSaZrkUVmXAa4+EkBYtj7X15LGuSOL1jOeP
iGmX28GSbM4FObtsMkn2Rf91vcu1WyJslPVCh7WcNsmYsycLOUu6XRLy782G7/t6KyFvCN3W
50YXZWz+3lz4vq8yGa93SttlvSF6XZvKvhD1RDjRW/sQXh6xbs+Of1fvxstjzXUp5Qta2Kui
CL4SRdSKQQRvbQwiWmsiBl4eoK5LWX9flpYHkUvSfRyn4b7rIlBLnrZQRmeRDJ8RrgHQpLVz
BwXJxdPvFgQrE2nx1NTxpciuzjcIZSWqy+XzW7qKLrz84UlL6Wwz4yViW/IK5eL6bf0ZtePQ
9JUFJxteCkJIUktEaJn5+0Es/C0n/n5Un5sQ1eZ1ouaOmHrEFVaLGZyvvEvEmkyXizUIYofu
6NaNRjfSCWRIxvEsGidN5rYM9F1gudiMjIEbse/HNyvvJbFsayQxUYREUwLdPRnrsrnt6m8B
/SUKXpK5C81Dizc04OQsFu5IELk+aBdxlSLqsncGfePk5k5nAoyiWYA/wCXyzpZ3RL/iwfJD
mdAnpnIkHMe3iB7qSEwDogxA7Ez90VjFafE0jkkcuIA2wm99P1Z+RLy7ULgkyF46Q8LJrXLw
7SsydIVDxiKGhcADuVO29ImwyHgWxz4wWioSWFFwC2OQofJHoZhrvKrFuL7RJMr7uEZ+GdvE
HVvCugGabfyRL5ndWGp0Y9lEwA1x1Dj/jgWJrEjpVjJrBYzV4PRLWB6iSUQ/qkc6Q0g1eoiq
liOiqKq5lGYKVJWn4lGg9K+dJ2oadYhOmF6kNhOd47vIjiU6g3SRe0l0duIilZDojLpFvhvR
mV+LFCKi05SWn+1C7ko5qbZ+D88ysaWN0SY9salmAUAeY6M0SaSKR5W2K0Fz10++K9xrbBy0
zAY369c0m0Ud2gONw0V67wIgxD6dBTaYHzr3Q8fGXdCZgz+xeqC27wrl5XDqDd6uXRfeYoPm
Lzvu7+h3q4BhpT/iUf2n4YCCTD448k46+9Tx53tYPLj4byguQKyxZjnE5MxV7/eeDAdV+F/5
qdi3zsr7pnk6FIYiPeuB6gmLg22YGYg2gOCta5oYn87iPU3fFL4RCozkN/VR4Yuubmn30ylN
hKvJ0W+Bwp9NVOJQyg4YyRxos95u1DOgKVE1oCsfUGPdgJoQYtTabeyIvx7R7xXKT/jPe9o7
i0jnguBJeTWwVDreanHcVd07+dtcQK43DXMJcsIxnXn1BKCJKuKWe4qgVQDdqhlvCbpdAN02
+RrQn8FzBTfgPl6GgLMFhgYzW++AgRcwtOrIefBxuX4yA1UhWOSa6e35afoqqt75ALW0D0aG
/C+VZvTWT04AAA==
--------------030302050201020003020907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030302050201020003020907--
