From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Mon, 29 Mar 2010 11:09:12 +0300
Message-ID: <hopn7r$cul$1@dough.gmane.org>
References: <hm5aba$p65$1@dough.gmane.org>
	<hm5u2i$2h7$1@dough.gmane.org>	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>	<hm8cus$56i$1@dough.gmane.org>	<1267193154.29204.0.camel@localhost.localdomain>	<4f3252891002271729p6eb66724v62ce97ea9a6eb577@mail.gmail.com>	<hohr62$f78$1@dough.gmane.org>	<4f3252891003280552y29015aeav7b68e9972371325b@mail.gmail.com>	<hooi7i$fd4$1@dough.gmane.org>
	<4f3252891003281810r38e61306w83ebfe9ad2b8c69f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050206070407040003070408"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id F043E2414F
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 10:09:54 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NwA2h-0002UR-Ty
	for alsa-devel@alsa-project.org; Mon, 29 Mar 2010 10:09:51 +0200
Received: from 212.73.151.246 ([212.73.151.246])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2010 10:09:51 +0200
Received: from fn42551 by 212.73.151.246 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2010 10:09:51 +0200
In-Reply-To: <4f3252891003281810r38e61306w83ebfe9ad2b8c69f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050206070407040003070408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Raymond Yau wrote:
> 2010/3/29 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
>=20
>> Raymond Yau wrote:
>>> 2010/3/26 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
>>>
>>>> Hello again!
>>>>
>>>> I've recently had some time to investigate this problem further on a=
nd
>>>> here's what I've discovered:
>>>>
>>>> Raymond Yau wrote:
>>>>> 2010/2/26 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
>>>>>
>>>>>> El vie, 26-02-2010 a las 13:57 +0200, Angel Tsankov escribi=F3:
>>>>>>> Raymond Yau wrote:
>>>>>>>> 2010/2/25 Jaroslav Kysela <perex@perex.cz>
>>>>>>>>
>>>>>>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>>>>>>>>
>>>>>>>>>> Jaroslav Kysela wrote:
>>>>>>>>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Hello,
>>>>>>>>>>>>
>>>>>>>>>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a
>>>>>> built-in
>>>>>>>>>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Contro=
ller
>>>>>> (rev
>>>>>>>>>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Aud=
io
>>>>>>>>>>>> Controller] (rev 03) -- and get the following message:
>>>>>>>>>>>>
>>>>>>>>>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84"
>>>>>> "AC97a:83847600"
>>>>>>>>>>>> "0x1073" "0x000d"
>>>>>>>>>>>> Hardware is initialized using a guess method
>>>>>>>>>>>>
>>>>>>>>>>>> As a consequence the volume levels of the Yamaha card do not=
 get
>>>>>>>>>>>> restored to the levels stored in /etc/asound.state.  The vol=
ume
>>>>>> levels
>>>>>>>>>>>> of the built-in card however are properly restored.  The
>>>>>> asound.state
>>>>>>>>>>>> file has been created by executing 'alsactl store'.
>>>>>>>>>>>>
>>>>> your problem is "alsactl restore" become "alsactl init" when the nu=
mber
>>>> of
>>>>> controls is more than those in state file.
>>>> I'm not quite sure that the case is this since 'alsactl restore' doe=
s
>>>> restore the values of the Yamaha sound card (and those of the other
>>>> card, too) and 'alsactl restore 1' seems to just initialize the Yama=
ha
>>>> card.  This is with alsa-utils version 1.0.22.
>>>>
>>> "Hardware is initialized using a guess method "  is the message used =
by
>>> alsactl init
>>>
>>>
>> http://git.alsa-project.org/?p=3Dalsa-utils.git;a=3Dcommitdiff;h=3D9a7=
48178d1c9e783242f0cc794ab3efb27092f34;hp=3D0c02a4e3d23c7b5d03215f1bfaba9f=
70ed11e9b7
>>
>> I don't get what you mean. Could you explain a little bit more?
>>
> post the output of alsa-info.sh after  "alsactl init"
>=20
> and immeditate after the system boot

I'm sending the requested output as an attachment.

Angel Tsankov

--------------050206070407040003070408
Content-Type: application/octet-stream;
 name="alsa-info.txt.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="alsa-info.txt.tar.bz2"

QlpoOTFBWSZTWUequ7sAJKZ/hP77keR7///3P//f6v////oAAQAIYBn++T41zHuN1h20YQEt
61HJ7eOvNtgB22pIVVFq2yqgAdj26lKclANAKAaKGgAyS0ENT1NITImaT1AeptIekABpo0zU
NAAAAAANAAlBNNEJT9DKnpT0mg/SGp6TQ0AAAAAANAAABwNA0A0DQ0AGhkNNADTQDQABkMQA
Ggk0pEmCak8mpkxonqep6m1GpkehoPUGpo0wAAjBGJgAIpTRU9MjTaTTQmmNTT0E9MiMmQaa
GTTQAGjQAaBoaBUkgCAQJhDRoRqbTFMKeiYmBqeptAmg00DRo0NNFX38ejyygBKEVJCCZ5Ne
0RZE7q5mCJQVCIYjZ70Lr6UpFolRmqRS9AkU/4fsXJ1REJQkUqKiSKKEilJEYUU/oCm2PgB4
BdphEgkSUZZIV4WAIIFvghsdQhJuDiPbyFFBhnGTlkgnKCqqiRESIUJDeUQIajKusERE3ilF
wlGIjWLKiIiIgmjWYMCIiPZcsSmZNxIFVkA0shgIBgYlSqheh3HbTk1bPnYvv8/Q/kkRb939
9scW9aaCIqrtaig3ZjDta8TTKy5u7O43npf7yqOIom3LCijAVgIFuoJaLBBXdgZAnRRQ3Kdf
xRmULa1KO5187OUpohU2ouqRHFKf1a/7UmMtBhBmLjQ5pclV6ufBsUXi4nbVURSgb+55547o
VJYPQep0a2ViuUU2axRhKWugYp/ymOikpRFFzCZKUozoq+6oaGxKbH76lxSGXyU8KFqM9tcP
a6Oi11ve973veb3ve973vuRDmjD3HN/7qL4P6sNHqe71rlvHXQhs6fm+tl/9nPr0Yebj0Utp
Sk4nAy0UMkMHVuBVVWYVwwIZK/fneum+4c2s8LO97T1DWdnLB2Tcd52Ipyjp+OzLBfyPuLg3
bqueZ5/nu07+b5GUPhlSqkmfK0i6kVV2Tm2sbg9A+GFhRRIqp76AW01cR0m6Mv7NKN59tgYp
WmCJ5G8SgjlSB5W/8drGrr9zewl163m8cye5f6s2BkMvhdoaRWaAkIYSSELwkkk6zkO5Uex2
vEczMMzPLAYEESIiqIqrilEM8rhUijLSoIgiCIjBomZe0YMAmQiCMKUoJQtVUYjva4QQyBfW
XADPXscYMS6CIHc7lsjJEEHpReu7qvb4RMnXuvQfE+T2WllR5r3wJHBDjOqdNKKpKSIvNggU
/MtJRZRkDjpQI4oxFaxY8m/HCV8skRRWnRbhSZsopZkPESS5ui7XHgk3Xozpxmv/j0JNSXo9
Q8MnE5y+JwTnWiX3344TG1OCXuSSft2OGrVqa613wSqmBkiIQqICxa1HgOXNSbkRtGQcpe9c
VIAheRRCibMxdBH3GVyOvVHqMYJl3pqKeKeFYjnIKxERB2KzJJJJJJJJJJJJJJJJJJJJMzMz
MzJMyzupMvMVmXKQqxMq8rMFCLY2VeyqscMccfk8WRtdmF61t69/Lm63m6/obyHA+W9tdMJO
mMpT1lSUo5MK2a2tdeMEqlVSlKUmUSPp/ZuucWHwe087Bs7Ibc3ifb+NyeXsWH++7dwkRvga
yIqBiru/z/dyTKopKR4+n6PXrGwqSHv7leT369W2TPNxJucf4eskPKwkHwva28Ww2tsRHm9e
Hr333VXtu9W3486ePR1KUrZtXXPevcnH0VXVnInaeBTFJM9MI8XTbcWv2izr0YnAsCAcEDs4
TcfpM/M/Urraq81rTErlz7Moiztd6O2S4NhS98JpNTYiGgCGvB95qCIGQ+rcHRz4qpwx4Zsm
137sFbE4cWMRMTCRvqMqqoIy8nZ5dHbOXkNOpRAFXuNREHwPBQm0/6XxUxxUgW6BBccxkF/M
MWjKNgujWKKObbKqcJvw4QFgjVtlLZbKRRgVilGKWtKp7/c2O9J7l55tjTRFRKVCoooCIRZ1
MQJOYSkzIZif1CFMRjO7IePwLkvDoqE8XlelcGs9GV92HJsdrOEmG3euxaDPvvZY+nk97NjG
KWhZLFW5pJKRLI11MM9p1ObmScmbVm9CyI12cVIx9HLDGYGRdBBDv+12uO19vWrV+eaVpenW
rWEs9XWa1rZR7xZqLFZu7FGmys7PEVo96ze73dXtW7Qy2KkNaObxgfrqR/gSPsfaSzzkRwZt
9WkJxqpc5m8mCpLolnkdnexiIwvq/mvjtei1VGPntF8oMYAAhAkcWMMkhUTgAUuyCd+fPIZD
GHpkEFMXsqnDDTSCOAwpz7TguKKUwvRddNS3Hnw6WciudnMWia9goLRp87GxbVixbu5yCyIQ
Q+cAqRCIlMKFzLimpbn25GwEJwg4RpEHyD1GoL1FOIujoPcRGAYCCyeteFby6yIV1UCETPbE
TEkfySe4iy81fR/CFJzEaExtZUlSdNiEyNw1i30IioXQDsQtJALAlIs50uqbrQQNbAojKl60
4QO2+JistDMzkIwReckMYClEFAKIdJIFEwkO/gaaoYSUS9cyssn0IZtsSSHwUJHe2Nsjvv6h
raeC1s16L5miwps74s1+ewIJkEJWGCEZEoUsCiCIgwh5jzCSThx6BjKEIgvuy5+7Pup8voLc
1a1na1tB1bvvfd+7mdxUSolKVIURcSaacN7mcXw4Y25mWukNtWCVbK/W2K671kjQUz1ut0Ep
Z7GCTLZMPgYoRnRvbSXbL5ycm8YcWCRF3Sx2BFez8P1P2x9jeplZWsbli+4ZLreJ0rSc8RSM
8eTfVF+rRaM1lxUwlYLmHBffF60Xrntu+JKfbVJzeORpu69wl1KUmxQktQjxxdG5p9tZczSp
So7JKoKJ5aXsbToyXJ5aL4pO+iSeS1+7vOEh1c6L+HNmxcutx2i0iVQ27lqSabVzY0voi2rN
PZ2aZFIy479zY8wxSioK41lES9CpBUgE5LVdAWDZ1HLFBozFC4KFMi4NBJRSEMmKGC6cXOXI
TBcuWzXi2O7dyTFm6KWpt7rpSXL9Yk5q001tsv6ezFSCczlOJxxwZWruN/I9sSPQyyuNNRd2
JBySbsnQpgTF0ujH/YVi7C1qzWYLqiqLM8161StTe810RAdrVMxy0FDWhRzajjoJBQxehRig
7GDWudOiBpY5FOqCkvvyBwVBMRbPjkvm6hfF2VY4L7dUxiZt6zxa7WstiRVliLd1669RTW5Z
0Bcolmy9YpTmRGqxSRZvoUNwKd6HbxNBR1I2b9mWWXK1Nvr6EkFjpnTNdFXUrEy41B4DHUwK
AEdXeMUT/cDZaBao1jJnFqu+ARSg7CJXdlCIPHI7530ZkQKDKLqDucNN2soVteHjoUMgUTeC
jWXfXeUaKo4aXY1sksTFuWaSRZj3yzXIuly/ba3TFlEZRAln0yxz2CEBdRSIjRlubOkZmfAw
sO2BNbLYM7quzuC60mexXlpZhIimWEncXMNKWF97da2echwFNtQrXbjoUh9pQdKK7LuHoFxR
X0Oyg0XOopzuNb9svX63b89kYqUYN8Z5xXtayHXwCFQhBKC9Jy5bQmrtWASrsCYIoxTbLK1Z
qlToCxKiYIcW75XKNiIIdgbazquNTCduRs4hvRETdEzKsKNOG4oywYY8qIByKgL1RZuSSdck
mqGem7dsyQ8HPDfh8w+B7e2qe7weTLyN/vf8LURbbfsN09cAyhvnoGUz592/77e5o1Ebuu5a
i78C+6XJsBraRH4cE16vPd3c7Y4OjVCb5EhOENwRRFQiwQm9kLv2GvbswbMsBAezipvCgIG8
hELqtr591x5u13k3u173ve98dNM888889k+7o1UbFIuqRLZ2NaE+akvgmlgGtJAy6XOpHiQA
DudHP6eOv0d3q8fN+JDoDxWCQ3zvpPzP7HfQweaUSwM4vsBAx5j7ANjAxZLYfdvL03Jp+O8h
cBRt+t1uCqM9wlKKqIno92CkzMHSDZIBokNU2kWKDQL6gwrJvYkRkpSpVFUkgSlsEqAJmBwH
B2zWMMAwS8ncUVqqt97xMOCulscQ4zq4D71JjRyKyss4902EOHCQX9UkjEfwkh+uIjZ+MXza
2tPiVQYSFtsvXIvwYokPFJCnOg0s/PcmVCi4cqJ/Rr/TnhhBfJFKlO6VJDKSIzWi+p89DE/f
fYXBh4t/FHW7DF/2Q0n5UXpekhlUQvThpcqqpe1TuUjMeiJOWMiR5MMrkNSUKRYosUqqSkfc
WTW+liS8ouUkNpCj3SV2yQ8f/SO4XzmIfCQ6G/ZgdmLcnQnDExuKS+FORxtguXXF6VESL5ti
ST7dDTpyxZUyokO3ph97sjkq7BjSq/IpxpGilUpesqEl3kutQwUkkvfgYyeO8HM4cB+eSDF2
m8yUNLCxObMuIQiEOaqJnYdWYaJRnwN2pxAZGSrETxcsQ5ctTCQk8v1+TksOUcqNARAsKXo9
U4OjxtPEOWo1apWsoxH8WFcAgiVwlcLfWSYhhBTIkkwSBoPiFSSbNms5JNV1MULFdYEnE2jR
fMhAy3kDtYThrvUIQ2xGelDxHfuTmM+JRec3tf+ReAUywFPOChyECiYbb/2PEJH1n1c+/6nG
GTIcWSbLMtZEweAUXfQoEU2ufPlDMqFz4SVAwYFFpshZEk43yTdPzRL1T636Gh68265npNaJ
3nRsZvzY7t5i2WKqslZZhq6X8ZhkQ1iJHhg8gagIGIQALWCyqpm7ii7u8EzqgIeXMm7NPRT4
Hhftoe3d6nse729trXMXue5h7s1Zak0pMqH6dNegx3e+KpP49TQxEikEoSK7xDgWEboClqrd
K5Cg0zY8hWU0EpAjOoNPKbCDPW0RJ1dwMCWy5cGrriIS+ElCR5FjD7IkfS8nUkwEYPJSb7lt
gJWPGwJ1benCcJTIWDCYEtpCpnCEEqknFcaCdcRisVBRVEGiqJMINwhR0yYWpU0Pisv4pOjw
Ijec6pLSMYZ7nVx5EZUxN23xYrSfhs+BidSaWKKqqCgsFjicoAk4py9rtoQj5JIZGKqSIpGs
helJayWVa0wYu/weN6Hg9Lcx6iHDYsPBRI5OERHCVK5hlbIJVRJyclSwXQl4XwkxrtxSPjxR
ZTZERaPTSMrWSLNF1q01NhiTMkmbLo4cMtmeLez6ezESOQ9hbHRxly4Z2cIS6+YXEu1si9gx
w2Pqdf9SSGE3qfTQmssqxo2vWl8QXoi7clk8HxLOT/I/T6Dn5k3LWiIT7M3MEvYFKqc7fk6N
qW/VaUqIINEVc3TJycitUaa86/EwrMJb69NUxCWQTQpEJOG42r4SKcVyZpKpBOSVI7qh1B0B
8vmPgUnne9fJ8S9fdvrCT4VLSSTlCR6tZE9jyNgtjaSSa5O7zdLRUdRoSHVdoq5gtJD1U3NZ
IjHHEMXoctqqUJKohVSEuhonnXRB4z62K6w8+ZIaPbhO39FrPN8Pm+hBceiQk3db0nZ3LySa
4CRk8CQ9B0SfGyqElljfILSJOtsIc+OslmI7ZJHp3Xu3Zvu6jNiR5cSqSqKKltzqgVMFbIrF
qkMsNdUAw0RMLYFZFIK47BxBj2hdCSiueSR09yQccbHmUEmc/J2DHB2IkpSpcVJG2i512vXC
R33Fn0sTwvw8CJHj8S6RJaXwxX0XO7BOHoJJ8203KKwzxueVg51NsQX51Imx4UspSRJhJEZg
ouTFdWxUkLSMfHMoX2NI3kL2cKEikkKzYp1xEJZf5vtHjzIYSDhCThwiISyrpElyzm7dqXRn
islEKk3Wt9KqUtQmD9XFq2NQkNUnH4BBkkTSTYbIFBNgqxBGSRr3KqILl/J9hiyUqmsI3sTP
ow2YyQVqIb/s2a420kxEiwkLKqqiIS9IvLS4EUypLl6y/7+qJcwSXUtvvi1TAksS9VpJL1vG
miryh2O072M3jY8BD2pJJmy/lJIyEhYoetIeyIUTtL4iE2zgTbZabKSq2SHrHgxEL2OxEhWc
JKKRIqlSnq5OD6jFJ1Hhvd/UrlTg28cI3r3k1Q3tqezZVqaiRYLG2Ov0nX5Wtr9fblct0lQA
6Ci5O9n2DmGUFG4pbvgKY4Fc9G3T2bZEm8pVPE2t7jmWkknnmxqvRJM3DzwyIaxlrTKqkmdp
LUSrLJBXG1pUux+SSHZfgrLecM5JhUXQnlUuuWBNJ+aIj22ywLNzWMrk/QVw7574iPn6b2+N
D5ONLwR8qJDVJuk9QZtI3w1k4XqaE7L/nScUmGOLA9XTp2XviWUutERdhTvMG3hjLb8cXkTi
2y+RSaRBSJaElmz8VpE4OkqzXndymfC+o0BlPxd6SmVIqpkcrvJllhIkdJq6GHiatOhNCWWy
siMuPDxEWkkpCilSJ5UwVP5sZ8ciN00OfouasTnPTIjguEjJRIYUSGJzJMGTfgrRlLlSsKhC
BNWxVVEVAQERWDBERFVVVdHT2hqAZIAbTSWEIMU1iGiJhL0k+ZLSk3rSX1VFU9UuaZMmrkyu
JJ+rY6+jNz0oqTRzfcvhrc4Ajaj9qzdIBuNRCSaDXzwJDBt1yHBIIqqqqqqiKqqqqqoioqqq
qEOTFJ8KjrdSOdElKJJv7H5c02+rR8zJM5ISvhg+vcmAU0CAC8HLMEgVdotLZlNWAHk/+5Qx
vM4951OKk6u15KkPWkSdfwzyh2KCqy0ZzMiTyy1TgpSSqRYpGBJ6mqu2InRJJUhMWzjaIja8
6ivDBI3RSSmN+BRSU+/PlKqMHNQMcUkl6zs++dfPzVtt7ViJHpMhI5Q5qa/XzokcUiMog2RE
pT/i7kinChII9Vd3YA==
--------------050206070407040003070408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050206070407040003070408--
