From: "guan yim" <guanyim@hotmail.com>
Subject: Re: Test: SBLive! (C) 2003 need extra effort on Rear Analog Output
Date: Sat, 27 Mar 2004 10:48:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F40oHMwVN7miR90002b9ca@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_6805_63af_483e"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pzad@pobox.sk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_6805_63af_483e
Content-Type: text/plain; format=flowed


>From: p z oooo <pzad@pobox.sk>
>Reply-To: p z oooo <pzad@pobox.sk>
>To: guanyim@hotmail.com
>CC: alsa-devel@lists.sourceforge.net
>Subject: Re: [Alsa-devel] Test: SBLive! (C) 2003 need extra effort on Rear 
>Analog Output
>Date: Fri, 26 Mar 2004 13:26:42 +0100

>
>Because Creative uses diffrent AC97 codec and this codec has same
>controls as controls implemented in dsp. then on 9.8 it fails to
>load.
>
>Could you send me output of /proc/asound/card/codec97/ac97 <- this
>is not exact name
>/proc/asound/card/codec97/ac97reg
>where card is card name
>???
>
>Peter Zubaj

Thank you.
Please get the attached file for full listings in /proc/asound.
Here is the files in codec97/ :

=========================
[root@icemountain asound]# ls
card0  cards  devices  hwdep  Live  modules  oss  pcm  seq  timers  version
[root@icemountain asound]# cd Live
[root@icemountain Live]# ls
codec97#0  fx8010_acode  fx8010_gpr        fx8010_tram_data  midi0  pcm0p  
pcm2c
emu10k1    fx8010_code   fx8010_tram_addr  id                pcm0c  pcm1c  
pcm3p
[root@icemountain Live]# cd codec97#0/
[root@icemountain codec97#0]# ls
ac97#0-0  ac97#0-0+regs


[root@icemountain codec97#0]# cat ac97#0-0
0-0/0: SigmaTel id 58

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 20-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x22 Generation=1 
Rate=48kHz


[root@icemountain codec97#0]# cat ac97#0-0+regs
0:00 = 6a90
0:02 = 0000
0:04 = 9f1f
0:06 = 801f
0:08 = 0000
0:0a = 0006
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 0b0b
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0bc7
0:2a = 05c1
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2a20
0:3c = 0000
0:3e = 0100
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 000f
0:4e = ffff
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = d794
0:66 = 0201
0:68 = 2001
0:6a = 0000
0:6c = 0002
0:6e = 1000
0:70 = 0000
0:72 = 0000
0:74 = 0800
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 8384
0:7e = 7658
[root@icemountain codec97#0]#

=========================

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

------=_NextPart_000_6805_63af_483e
Content-Type: application/x-gzip; name="proc-asound-sblive2003.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="proc-asound-sblive2003.tgz"

H4sIAKj2ZUAAA+xc/48exXmfQ8edOSAYAglJSLuOoEBq8M7uzn6hONzruzM+
8OFvGOzYBu+3175wd+/x3p2NK6HiKkZGwmloIcVpKF9aUEAFAVLU8gNSUomq
jhQpiiJUoSii+QMqIvWHJlV7fXZndmd2Z3Zv/b5noOLWWs/tzrOfeebzzD4z
88y86y90luaiTehCHrpu6YQQSNOjnKZ/Y103semYmJhIx1i3TKSRC6oVO5YW
Fv2upqFup7NYJ7dS/v/Tw6f23z59LL5gZejY0B3HOQ/7GwTENSP0u5F+wdSi
x5r9E/unTF8oL3D+77+hm9ba+/9xHAX7T0cXpAwdjGtZVo39Sdn+ZuL/L/Sr
nx6fcfsnjn/kk1Zi7fjEjsL7H88uYf0hvNplrPD+E2Lh0vtvYhBfe/8/hmNi
ai/W78YjI2PQAjTpuE0b68b+YuIkJucW4+6cP6Pdu7s1pd10vNONFm4GAf0R
A4w4MvFIVbabZI9MtNtxuKjtiecibXdnaXF67kiK39qsb9S2bMYbtbHNxkZt
fLOZ6DK/uNSNI23rPm3H0uL80uJCIjuisStN17UDO8emtO1xe/EQv40N7cDU
5Piktjs+FneDQyMjrZmZIgit1YpIOqa3d08fOVq4b9D7e5a63eTFkZ4zS/kS
gMVULD9IMtXLD9gUcSxO+BczHKb51gnxrqsduOOOO8Q7XvkO1qU7WLpTppLn
mCxn7Ginu7Qg5lgSCpHu2NIdR7oDdWiNj6UUaZu0sfHdO4DRTTvHJ7dKFveo
aMpaWbZMpaEnmo+B2Dc7nVntvuko7pQBDWBCyJUggBa1JoaZ50gPSbwYEi+G
xIsh8WJItjUk25qSbc3MtiNMvaxdjOzsdtrxwsJ0J3ltpzpRzF75uc7IPZ1F
rbUUTXe0cX/R594AssY68ye6Kd1FR3EiXhiZmJ0/6i9ML2ilvLnOXDySl1DK
1OF9X4yPdLontDFRJPEd2Bi5M56Lu+CCOnPankV/cWmBZXZAiWnQfGRPZ6kb
xtqUv/BQGfeoPzcXz2j3LM0GcZfnzIDpRvb4s/MzsbYbyi48ZiX+atufjozN
dMKHtFYYLnX98ATPh55Kn5+fLdOJ1+hcTTqNTeYaof0ROjZ+C3eGlWQmtFSx
meT1QqdTyaVZw6XT7p1LTCrJhKwqKjGp4XFp7qG5zvG5rF1uB6k4Eh7utNsj
KWIpJ8ubWFicnoX8SBOLTyoKoyFa0Rltfqk731mI14z0aTRSMg6AnHQk0DPK
Jz3AX+EozP/aMFbH+oNH5rurWsYK8z9Djv+ZxDLW5n+fqmN+AKE3l5cb338M
zp3/y++PIhRdgdCHIP6rAXprAP6hj5Jn0+fnh5Ob/wXnhwhpkHwluV6PLoJz
EK1D6EvpM4n08p8l58mnwyuS89//54N1Fx/+3sVlFbY/7F2UnOX72fNVVc3y
V5L7TBwa2EYr2Hc0OZ3Df/fnyXnVC0c2J+e55w8+mpz/8eCz/5ycILMuOU+/
+8p/Jqf/4rbB5Hxky/5Lk/P5B/7xv5MTvQDYjy0vv/80nIvw98+T8sBn/HR5
Wf8yL/TW3y8vJ2fVtQ5/679XtMMLfLz/9AB6/97l5R//EqEfw9/690GPnw6g
j84uL390biDX88Pf0bN8nen90e/o+XHrr/L/i11/9sEIBhmrVMYK/h8bkv+3
HN1Z8/9rx9qxdqwdF/Ko9P9+FK3WLKAX/4/1Nf+/dqwdF/q4aMNF6CJfmiKt
HZ+RQ+X/w060qpsB6/0/Vuz/Mm17bf/Px3KMo2RCP47GByEdhHQ9pOsgvRrS
yyCFWfzoekgvg/RqSK+F9FpIr4P0unF4dgCNaiy9nqZ/MDCA/uiaAXT/wd+m
138I1+Mau/7uIDqgPY5uaA2g0wMtdOMGdn9wAG19M0KtRP7Rb6PR0QG08a0I
/fEGjtOC/NHHBtFjX3scjT45iE5v+Bf0tVNJ+m3UWg9y6Lfp9Tq4TuROluVu
KMpdAtdJuV/Z0EZfZvqk+ay8Ua2dpqdno1Sfry5FaIvG86+D6yS956iPJgep
3q3rabrl9gG0A8rZOTOAbhp4IE1vvvgBdMvAIBq9aRDtALxbBk6iloCHbo7Q
rRdD/kaaf2spf+CWCG1Kntdp/qby8zhCevK8RfP18vME9AU7I6jXFm0I6rcV
4Q2QulQel+RPexEykvzbab5Rzt8cIZLoAzhmIrePyplluf0Rsi+mclYid5DK
WWW5Q1F634H7Gc+tdYNo5OZx1GJ8Opck1/R5V5S7bBBdeguXcy9PrgfRn1xC
y03kPVEe6v+F/Vze25BcD6LbL+fyt5Xkv3iIy9+2IbmmemwW5dYPosswl9t8
ZXJN5b4hyl09iC4nXO4b1yTXg6h1JS//jhp972D6brmGy4/W6Dsq6Dsmyl07
iD7ncbmxLyXXVG5clLtuEF2xmcuNfzW5pnITotwoKthrooVye20V5cDxiPba
OoFSeyVyd5bwxHrf2UJpvRO5bSU8sb7bJlBe30lRbltRv8lJrt9dotz2on53
TVH9pkA+4/vuGvvczexzzxSX315jn+2CfXaIcvuK+u7Yz/XdKcodLOq78xDV
d89+Xv6uGn13MX3vPcTld9fou1vQd68od7io716f63ufKBcV9b0vpvru93n5
99foez/T95sxl99Xo+8+Qd8DotzRor4Hprm+B0W5maK+B2epvg9O8/IP1eh7
iOl7eJbLP1Cj7wOCvr4oN1/U13+Y6xuIcotFfYMlqm/8MC8/rNE3ZPq2l7h8
VKNvxPRN/PhIi/aLl07Q9LJJml4+RdPP7aLpFXsj9GSLPvPdU0PohVPH0HdO
DqH1J4+hp88MoZfOHEN/+cQQuu809BlwvvREG30PrhP5708Mo59PHEfPtobR
S63j6G+nhtEvpo6jH0wOo/u2DaOtcI5uuzOV/QXoc2aClvPUM0Po7585hv7i
qSF05VPH0DPPDaFXnjuG/uoslPMsYMP5ytk2+uuztJy/2TuMfrn3ODq7axi9
sus4ev7QMHr/0HH03H4oZx+UA+foPlrO+1DfJydZfV4eQj98Gerz4hC66kWo
z+tD6LXXoT6vQjk/BGw4X3sV6vMqq088jP4thvr4w+g1H+ozO4w+mIX6TEM5
R6EcOEeP0nI+AD7PTLH6/GgI/cOPoD5vDaHPvwX1eXcIvfEu1OcdKOefABvO
N96B+rzD6rM0jH61BPV5eBi98TDU59Fh9OtHoT4noJxHoBw4Rx+h5fwa7PXk
Llaf94bQm+9BfX4yhK7+CdTnZ0Po7Z9Bfc5BOf8K2HC+fQ7qc47V59Qw+vAU
1OfkMHr7JNTnzDD6zRmozxNQzmkoB87R07Sc30B7ONKi/VgLxlFHbngcPQFt
evT6rXAOodNgvyMTpfxbhHzg/chkKR8L+cDXkalSPhHyoZ5HdpXyPSE/0W9v
KX+zkL+Xtuf1Jw+n6ZWnDqPpDVx+OpFvCfJPHEbfuoHnfyvJnxDyzxxGs4I+
s+XnYbyavI8PCe9jOn46ezh/Hx9KxlnPIjQn6D1XLofhzJRxnuM4MwnOD1B6
/6oXaf0+/zJNr36Kpe/R9JpnWHqOpl94laZffJ2m175F01Hkr6Vr6Vr6KUhV
8R9/lQNAtfEfjA1smeX4v26urf9+LMfWfYnJtcm5hcXuUphu6ts+vbCo3bhn
i5b8NmyDxiSSNqG1O12ttX1PSzuGbzW04IR2l9/tLMz4x7S7TyzEM/6NIxrd
Mhgtzc6zHXIjyf87dt6kP6JbG5Mts7qeJLpFk+zKulnb9HV6Q093zsGt5Iej
9LAs7eubZCRcQMISEs6RLCsDUiMZBSRLQjJyJNdiYcsKJLOARCQkM0cKGVKV
TlYByZCQrAwJZzy5FUikgGRKSCRHyngKK5DsApItIdk5UsZTlU5OAcmRkJwc
KeOpSidXRMoTjuRmSAblKXFHuhLJWwHJy5GsKiTxWYzjKiT/NtZCwQHGaqR2
+hBxxMRKLYkNmyMFFKmNSUic1KESw67TqV2lUyjo1D4PnVzJdlFZJ0N6W9KH
sEufJQGtliXpFFMk1zZAKGnzntp2We0yQHplEI7UZraD2rlu+tpBdtPaYcPJ
kbAu1Q6yi0g2fSikEOw1weXaYeafbCsAIeZUdBVP1Ghl22GOxPyTazlRbjtc
rVOmGpFaATZznUAo5ek8WgE2Ao5kKXgK6ngquHNRJyLwhNUtU2xPhsvMLyPZ
eXsy3LQ/cCWkUEDKEsOUkJh/Cm2DtifLDdU66UUkTBODI7mZ7XIkYhgqxhkz
GeOW1Aq8jHFw6dQXSK2goJNeqZPPddIrdCoyjqsYDwTGcV+Mh40Z91ZgPMpr
R/pkPG7MuCcmCp3aXCfdU+tki9XCQYVXMZh/soEnHKi9So3PxD5HwrLPxH4D
XyDxZBhSL1Xhn9wVenPDzGtX2ZvbAkESIEeyMq9iR7R2lUiRkCh8ppH7J4fg
6Hx9pm7xVmDYip5T2QoyncKq2jmCTmFN7XTi02erxioG8082tl2rYqyi7KVY
y/Q4kif1UpblNUDypPbkl5FgRIZr3mCrXUgExgP+BlspkhmWGU8HXWbWqYhD
FmgMHIn5JxKDNml7skOiK5HY2+9VIUU5EjE8NRJVRvfFF5ndNCKOxPwT1JiO
xy3QLVIwnkEYxTbe5kiZf8IJAmvj7eZtnNvOlMdPFb6A1q40YRRappmPn1KW
qsfjWA8KPDH+Y45k5DyFjCdixHU8xRU8mabAU9wXT/L4qYqnQKiWiqfcP4Hl
KsZPjJlQ1Z6E2tkZT6aet6d2HU/tKp4cgad2Xzy5jXkKV2hPXsaTiVdoT5Gi
PZkCkp/zZGXtyVT5zAzC1Kt4CjhPpt4XT2FjnqIV2lOU80Sq2lOhN9eLERoB
Kea9eR7qUc7NC914fsX9uJnN77JxgS33nMxasYyETc6Tpee2cxkSZNfZDlfY
zsKC7XA/trOk8VOl7eL6UY+Vz+9Mr2rUw3hqq3jijFtWzlOY86SaI+Q8GVU8
EYEnoy+eVOMnNU/tFXjKx09m5ehQ1TIZeSaPPFhuqWVayQ9cVYxjW8W4yZG8
jHHCW6ZZx7hZxbgvMG72xbgUf6piHKsH+BwpzBgnlS1TyTjzvjwmZkUS48RU
xcQwdlSM80iWlY+fCG/jqkhWzrhVxbgwfjKtfhgnjcdPtHbVjJN8/EQq23ix
dk5F7Ygh1M45/9pxr0LMlWdALFrrFxJD4imPj8Po0E9bgXs+cwQBiSjmCFjp
MxU6ASEcKR8/5Tp5plPHuFvFuDB+Mt2+GFeNn9SMB4XElHji8fFIT6O1usRT
Q8b9xowrdAJCOFKQM57pFJluA6/CbMfjmSSUvIpnBnW286psFwm28/qyXdzU
dljphAXGs/ETeF9ss/FTT7az9aa2U+kEhHAknHvfTCfIbmA71gpCjmRItovM
sM52foXtbGF+Z/r92M5Wze/UtnNU7lxgPF+/IxF2+rKd3dh2Cp2AEI7k5LbL
dILsOsarIg+2KzDeQ+RBYNxr7OnCQiLFM20/YxzG9Ul0zZLjmQ0ZV8Wf1J5O
oRMQwpGy9TuuE2TXMV4Vw7BF/9RDDENgvLF/yuacLCEST7l/gjlnlNbuvCJ+
HMlp7J9UOgEhHCn3T7lOxIwb+Cd6U9RJ8k8YK9cRcttVxVUc0T/1EFfhtnOa
+6cV+haHrFbf4jT3T8q+ReDJUfQt7Qa2o61A5Ema32FS5qkAkS0qybbzuO2s
HmI9gk7+avUtTrBafYsT9tW3CPMWJ5L7ltp5i1U1D3ZigfEe5sEC4+3Gni4u
JHaZJzff/wRjwzhtTz3OW1zc2NMpdAJCOFIeH8918qy6yINVNQ92Bf9k9TAP
5oy7jf0Ti/VkiSPxlPsnGF+009r1OG9xG/snlU5Y2EPj5v4p1ylS7qHJGSdV
jAvjJ4v0xXjz8ZM4D9axtF/FzcdPbB4MteiR8ebjJ4VOQAhHysdPuU6QXce4
XcW4MH6i+3p6Zrz5+EmcB+sYSzzl4yc2D062QvbEuNd8/KTQCQjhSPn4KdeJ
WHYd41XxJ0+IP1l9xZ+8xvGnwghD0cY9qzTq6bmNe43jTyqdgBCOZJdGPUkb
r4s/WVXxJ0+IP6WfpO2d8cbxp8K4QNHGPa80Vum9jTeOP6l0AkI4UlAaqyRt
3K1jvCpq5IUC431FjTzV/swmflyKsXqx5Md7HKt47R79uMFYy5F8XfLjnnKX
Sc54VazHF9bvrL5iPb5q/a6JH5dirL4p+fEexyq+1aMfNxlrHIlIfjyyfFXt
iksRme14DMPP9o9nc6nEdnUxDCuosp3on4K+bNfcP60wD/a9Uo/Q81zKb+6f
VPNgi0e1/aDUIyRzqaCB7Vgr4NEQvxwfT1pB3R4aK6yynTh+CvuyXfP4+Arz
YL9d6lt6tl3QPD6unAfzqHaAS31LYru6qLZVFTUKxPFTX1GjoLf1Ox1L8+Cg
vH6nkx77lqC39TumExZ5Kq/f6cQr81RgnFTFegLBP5G+Yj1Bb+t3OpbmwUF5
/U4nPfYtQW/rd0wnLOyFDMrrdzqJynshlf6J2o7wGEYg+SfikboYBqna1xMI
/on0sK9HsN2qrd8Fq7Z+F/a3fkcEJMX6HcENbMdaAY+GhOX4eNIK6qIhpGqv
USjEn0gPe4247cJVW78LV239Luxv/Y4ItVOs35G6qDapij+FQvyJ9BV/CnuN
P8mMS/Enu1fGe40/McZ5/CmU4k82ZNcxXhV/CkX/1Ff8Kew1/iTt2A+l+JPd
49w86jX+5DHWOJIUf7IJsRv4J2Y7PueMJP8Etqubc2bES7aLRP/UVyQrWrX1
u2jV1u+i/tbvCI9kRYr1O+I0sB1rBXz2GpXX75JWULdTgVTFxCJh/Y64fdlu
1dbvolVbv4v6W78jPCYWKdbvSF1MjFTN8iNh/Y70NcuPmq/fFf24X+Yp1qW+
pcd5S9x8/U6hExDCkQypb/FI3d41UjU3j0X/1NfcPG6+flf044HEE5H6lh7n
LXHz9TuFTlARjuRIfUtEwgb+idlOYFz2Tx6pnXNW7aSKRf/U106quLl/WqFv
iYPV6lvi5v5J2bfwKGQcKfqWqIHtaCuw+ew1jiXbRXbdTgVStScrFvaPk772
ZLVV+8d76lvaeLX6lrbRX9/Co5BtU9G31EUh7apZftvijNt9zfLbpMe+JZR4
sst9i9Mr406PfUvIWONIbrlvcSC7jvGquXlb8E92X3PzdmP/VPLjkcRTUO5b
nB7nLe3G/kmlExDCkaJy3+IQW1m7kn9ituNzzrbkn8B2dXNOu2onVVvwT3Y/
O6mw3tw/1fctmH//qc++BevN/ZOqb7FNjmTKfYttNrAdawU2R7Ik2xG7bveE
XbEnC+vC7+/sfvZkYb3B9wsa9S2Yf/+pz74F625ffYttcSRP7lvsUhSSmV90
nfIvr3D2/ackBpL6zOpvT2DRFyiQghyJ6EEtEl1t1Su+GIH1/Pd3lqfXfTEC
s7W/wo+gC0j574OtKN0XXY0kbolUIWW/D7YI1iu+PcGQ6L7cUpsQkNo5EtEr
vm6lF58VLenmI3ucff+JIiStwYLsIhJtQT61na+LVx7XKfv+k2O7hE0Uiacr
kQrKsCs35khGjoQxRYJsJRK1nW+IVx5v49n3nwAp8o0UKfIs1dvis27cFgE9
7guy7z8BgptGIW3X85TfMsmUERPRdvn3nwCB6eQ2sV2mE/eZ2fefctslOtkq
niJqrUgXrzyfIzH/5DhWOpWCYQHxfCVSQRl25bkcyc2RcFo7SD1XiUStFRni
lSe0Ai9HiiKKFHmxynZRwXYM0BPaePb9AseitnMsz1POXiPxy4n5lcB4Nn4C
JIvy5Jb3+BV8ZgGw0Aq4f8Jp7Zq+wdR2bsSRIukNJm6kfFuoV/Et8crjfUv2
/ScHpuS+RafmHlYiWaIy7MrlfXD2/SdAwukrDKnbViKxxBavvHxMh7PvPwFS
5KfvnRd5yt+b+3bhDaaJx8cq2fefAIG9wZ7nmco3WJGItsu+/2QDAtOp2RvM
dHI4kll+g0EnR/m2UGtFlnjlBRzJyt4WQiIrHT4RL1AiWaIy7MrzOBLJkXBa
u/9r73yb1MaxNZ7XfArfmjeZ2u2M5b+Qqrzo6SR7czc9k0oyU3NramvL2Cah
prvpBTqT3E9/ZYNBGB/oBvU57Or5VSUYcAsh+TmSHslCPw4GnSktHxLz2WB9
FTT7P+mUimKRUjEYdSp4o+6WCQ7W13iz/5NOYangeDDo9DCKjV0HmmdrBTf7
P0XpcteB6rFbwWo7wY2rYLDuqxTJAxQctNvgINtS8IBogxd+f9Y3nxltcLP/
U5pkcdavrqeMaoP7ZmaWz4w2uNn/SaekVN1KZVQbvBjfZZn5zGiDm/2fdEpF
ltUpUW1wtqHgrN0Gr/Z/SrKlgjOqDc62Hzbqruk/6RSWebqfgrN2Gxy2+09V
nrrb4EVtFX3zmdEGN/s/pWkSF1Xd6UeiDe6bmVk+M9rgZv8nnZKqv51+JNrg
RW0VmfnMaIOb/Z90SkWxSIlqgzfqbpmg0QY3+z/V3cNawQnVBm/sAtY8M0q8
8cd1SgsFJ5SCg+0Ezaug2f+pGiMUxLilU8Fhuw1u9n8yFFwQbfBi5Jvl5jOj
DW72f0qTYZxV4xb9SLTBuZmZ5TOjDW72f9IpqXqzJf1ItMGL23ay0nxmtMHN
/k86pSIr65SoNrjcUHDZboOb/Z90CksFD6k2uNx+2Ki7pv+kU1jm6X4KLttt
cNjuP1V56m6DF7VV5OYzow1u9n9Kqwavqjv9SLTBuZmZ5TOjDW72f9Ipqfrb
6UeiDV7UVlGaz4w2uNn/SadUFIuUqDZ4o+6WCRptcLP/k05hqeCUaoM39qRq
nq0V3Oz/FOmUFgpOKQWH2wmaV8F6/6do8e3uq+Co3Qav9n9aKTgmxsHDRb9g
6JvPjDa42f8pTfJ4OX1HtMHDjcwMt8bBzf5POiVV30KrH7vb4OGinIaB+cxo
g5v9n3RKxbBuzXOiDR5ujKWGW+PgZv8nncJSwTnRBjeZMR826q7pP+kUlnm6
l4KHW+PgqN1/qvLU2QaXi9oqffOZ0QY3+z9Vl3hZX5l9og0uNzJTbo2Dm/2f
dEqq/nb6sbsNLhe1VQbmM6MNbvZ/0ikV5SIlog0uN+qu3BoHr/Z/SpceRton
2uByYxxcbo2Dm/2forS/VHCfUnBHguZV0Oz/VHliJTEO7rpzfTm+TtZxvNn/
aX3neqTf7nCQVX+w/NtFgu07r9Rq/6ckiJPa9/W3ZkkiI6UmT8u5pf46jjf7
P+k8LXdODAb9QWc5+caXXKe7Tmm1v2+02L24TvEe5aS2yineKqf4wHJKDiyn
4VY5pVvlVBDlpPaUU39VTvGDyinYKqfBVjkNDiyn7MByyrfKadgup1AR5RTs
KSfDH39QOYVb5bS1P11UHFhO5YHlVGyV02irnGKinMLd5ZT46x7Gg8opapdT
shWf4gPjU3JofCrb5ZRsxaeQik/RnnKK1nH8QeUUb5XTVnyKD4xPyaHxabRV
TlvxKaTiU7ynnFbxKSbj08JxCsyGrqPlbPZ/SvzlLAm5J/pyf35F7ICrmv2f
dEqxInbA7dw9ZjmnaJTTsF13gX57V90NqLrLjbob3L/umnbUyFPRrruoO2b6
wZ6Y2ez/pMvpQTFz+TMJybqfmbT39430t+xapbsqp4wop2b/p7qcsgeUk2qX
U6q2yqk7ZvrBnpjZ7P+ky+mgmLkec6ZhR8zsuoN2VU4FVU6RUU7FMddTGt/z
emr9BkhHOTX+U/MbIB3ltLnmgVg5rFLj/rvkmJXDKr3H/XfLq2D3DrgqXcWn
AbkD7v3WPKT3vf9umaemuJo1D2uHptn/qdqnodkBN9l/f/CqlVqPytKt/TN1
K9W1Mm91ZZbUlVkYV2Z5lILLeyp4/5U5euiVSaywVs3+T/WVecwKa7Xe/2nv
lZluV6H57fqr+DQgdwq+35XZD+99ZaZdV+Z6bN7s/1TtjLG6MvPOb2fO3HR9
u2Z9gb+cuaH7BYsrU4VUSskqpbh2kOmUIiOAd6WUrkp84WSRKYVqT0pN/8nP
490pBbEh3a6U1vEprm9apvMU7Elp1X/KB7tTChYOwcbW6BspDVclvlhPR6e0
GENvbPm9kVK+SmmxuotOaTmPQKqlWf/kD/VJu1La8Om6Umr6T41Pd3hKI1sp
Nfs/WUhJWUspsJZSaC2lyFpKsbWUEmsppdZS6ltLaWAtpcxaSkNrKeXWUiqs
pWQtPg2sxafMWnzKrMWnzFp8yqzFp8xafMqsxafMWnzKrMWnzFp8yqzFp8xa
fMqsxafMWnzKrMWnzFp8yqzFp6G1+DS0Fp+G1uLT0Fp8GlqLT0Nr8WloLT4N
rcWnobX4NLQWn4bW4tPQWnwaWotPQ2vxaWgtPg2txafcWnzKrcWn3Fp8yq3F
p9xafMqtxafcWnzKrcWn3Fp8yq3Fp9xafMqtxafcWnzKrcWn3Fp8yq3Fp8Ja
fCqsxafCWnwqrMWnwlp8KqzFp8JafCqsxafCWnwqrMWnwlp8KqzFp8JafCqs
xafCWnwqrMWn0lp8Kq3Fp9JafCqtxafSWnwqrcWn0lp8Kq3Fp9JafCqtxafS
WnwqrcWn0lp8Kq3Fp9JafCqtxaeRtfg0shafRtbi08hafBpZi08ja/FpZC0+
jazFp5G1+DSyFp9G1uLTyFp8GlmLTyNr8WlkLT6NyPj0BJwu2Wxyd1P8kGfT
wv/helyMffufUV8KUfTEX9B+rPZSeaJPCVWYhioOn1SbF8TxE+8RsrLN3Wye
TT3vyXQyme86b9/7/6a8uvxF+X9X3uW7X84iX3lPfzl///H7Xu/nu/nt3dzz
dRz4+NUbfpuXsyoieFrkvTc3zVvv229Jfx3wQDb0n0+KMh+k3/k/WP2MqiGI
taAp/VfHm/oPIxU98WKruSBwXP9E/Wf1w5n/l2n5aXbsZ+yJ/9Wa1Fb9x6Gf
IP5z4D/3fe+Fl2QDv6ePA31c1Ul1HOnjwUiNquNEH/f9xXHfOCdbHCfVcW6c
U66Plb9ORwXGsZG+qtL3h/6wOjbSV5lxnBvH5fo48I1jI/9BZBwni+Pqs4I6
/WGeVsd1+nGuquMq/eGwX59fro9D3zgOjGMj/TAxjo38h1X6QRbUx0b+wzr/
qj6OjPxHRv4jI/3ISD8y0o+M8ony9XeMqvRHGn0cG+nHRvqxkX5spB8b6cdG
+rGR/9go/8RIPzHST6r0i3QQVcd1+oFflXNSpR/4i2Mj/WSZflAdV+mrxeup
kX5qpJ/W+e8vjo38p0b+UyP9tL4+w36Vn7RKP03ivvMdlj3x38pn7Iv/QZS0
4n8UJgHiPwe6jn/wn3sfxp+us4/llTcuPK2K3kV2mw3HV+P5eNW5P/tcZsXt
58lN6U3u5me9l+cX3rScTa7u5uPJTX1K4J8Nx/Pe+UvqnfClV958zm7y8rq8
mdfvrD5Zv/dq/Z7Owt10Wp00K+d3t73Lce59ysY3XsNz7y9+8aP3e/X/P3rv
fn7n3Wbzz8bbt9NSp9n7ML5+5s3m5bScNO9MdFzsyEn18tvJXXFTzmZGOtXL
l5ObSfWtq3HP8uXLN7/VmZqVV2U+X52tX1JVAfxQFc/VZHI7zPI/lqm8+jov
b4qy8N68bE6vFffC18X15UXgnV+ev/PeVn/5ofrvovrv5Ydz/f6Hdy/fvPZe
vj/3fn1/vk5IX7vzu1ldjO8ufm3/af1HL8IfovqP3l1ceqPpRH/Z6r360+vf
bf7v/6vf+qCLu3mn9dbb169W77TeqqraKKvmrUV2L/SHTSdXi7f0k9nddTn1
qj+7mNx+m44/fZ57F9m8/DSZfnvhf9WN99/Km3KaVVfNC+W912+9iPp/6PSk
VfKfy0b8v82vw1u7Y7+KA8Z/fpxg/MdBR/3P7oap1YvggPpPQ9Q/C1T969Yz
u7qa5DY+Y5//q/v87fF/FKXo/3EAy9ZtKP0vepZ2PmO//tvzP7FK4f+xkF9N
ZmWBIOAqpP7//OdtNs2ubYSAA/SfoP3nAfp3G0r/n4X1H0bQPwfQv9tQ+h/f
jCa2PmOf/gP9Xmv+J1EK+uegqvhq4VZRfhlXN/uFPV39zZO0N5tPy+z6uffu
7fn//nh+8ffeWJ9dXt8p/w/Vu8mu9UnNCrLXv/V1RVd/vnh9lY73XdrLr7LZ
rPoc/ap5vDhj9s9cX4Xz517ffC37ko2vqteky+g/mW79J/L+bwz/lwOq/sX9
X/g/LMD/dRtK/+L+L9b/s4Dxn9uQ+pf2f9H+swD9uw2lf3H/N4T+OYD+3YbS
v7j/60P/HOz0fxNL/m8C//dU6dZ/LO//4v5fFqj6F/d/4f+wAP/XbSj9i/u/
WP/DAsZ/bkPqX9r/RfvPAvTvNpT+xf1f7P/AAvTvNpT+pf1fH/f/sLDT/40t
+b8x/N9TpVv/kbz/G8L/5YCqf3H/F/4PC/B/3YbSv7j/i/U/LGD85zak/qX9
X7T/LED/bkPpX9z/xf3fLED/bkPpX9z/xf0/LOz0fyNL/m8E//dU6dZ/KO//
BvB/OaDqn9f/DeH/CpFECK8uQ+lf3P/F+h8WMP5zG1L/0v4v5n9YgP7dhtK/
uP+L+79ZgP7dhtK/uP+L+39Y2On/hpb83xD+76nSrf9A3v9V8H85oOpf3P/F
+I8F+L9uQ+lf3P/F+h8WMP5zG1L/0v4v5n9YgP7dhtK/tP8b4P5vFqB/t6H0
L+7/Yv0XCzv938CS/xvA/z1VuvWv5P1fH/4vB1T9i/u/GP+xAP/XbSj9i/u/
WP/DAsZ/bkPqX9r/xfwPC9C/21D6F/d/cf83C9C/21D6F/d/sf6LhZ3+r7Lk
/yr4v6dKt/59cf+3mv+F//v4UPUv7v9i/McC/F+3ofQv7f8mWP/DAsZ/bkPq
X9r/xfwPC9C/21D6F/d/cf83C9C/21D6F/d/sf6LhZ3+r2/J//Xh/54qHfq3
Kf2ah+t/sf8D9P/4QP9u09Z/kFud+qk5YP7Hj7D+n4WO+j+J+T+F/X9YoOpf
ev4vwPoPFjD/5zaU/qXn/2L0/1mA/+c2pP6l/X/4fyxA/25D6V96/s/H+h8W
oH+3ofQvPP8XJ9j/h4W2/x90+/8X5+8+/vL+lWn/e+Xoa2sK4NXr347z/1WH
/68QnB6RDv2fxPyfgv/HAvTvNm39qxOZ/wtx/xcLHfV/GvN/mP9lgap/8fk/
+H8sYP7PbSj9i8//4f4fFuD/uQ2pf+n5P8z/swD9uw2lf/H5P+z/xgL07zaU
/sXn/+D/s9D2/9X9/f/rcd7y/y/fXMD///eiQ/+nMf8H/48F6N9t2vr3T2X+
L8H8Dwcd9X8S838+5n9ZoOpffP4P/h8LmP9zG0r/0vN/Edb/swD/z21I/UvP
/2H+nwXo320o/YvP/2H/Txagf7eh9M86/xd2zP9h/M9C2//37+3/b3r/8P3/
PenQP//835b+F/d/QP+PD/TvNlv6vz2N+T/9gPkfBjrqX0sxVDavgofXf+Tj
/j8eyPq3OAG4f/wftMf/Meb/ePDRyjoNqX+LE4AH+H8B7v/jAf6f29D6tzcB
cID+U7T/PED/bkPq3+IE4CH6x/1/PED/bkPq3+IswP77f9TW7/8l6P+zsNP/
D9UDfgCscwZAp3DPKYAw6JgD0C9KF9B/OIT+rd4Acoj/i/s/eCDrX9r/Rfxn
Af6v25D6F/Z/cf8HDxj/uQ2tf2H/F+0/C9C/25D6l/Z/cf8HC9C/25D6F/Z/
Y/T/Wdjt//pH+7/3XgIO/1eEbv0HA2n/V8H/ZYGsf2H/N8T4jwX4v25D6l96
/S/6fyxg/Oc2tP5l/R+0/zxA/25D6l/Y/1Xwf1mA/t2G1L/0+l/0/1nY6f8G
g2P9X50C/N9ThtB/X9z/xf7/LJD1L73+F/GfBfi/bkPqX9r/xf2fLGD85za0
/oXX/6L9ZwH6dxtS/9L+bwT9cwD9uw2pf2n/F/1/Fnb7v/2j/d8+/N+ThtB/
Ku7/xvB/OSDrX9r/RfxnAf6v25D6l/Z/sf6HBYz/3IbWv7D/i/afBejfbUj9
S/u/IfTPAfTvNqT+pf1f9P9Z2O3/pkf7vyn835OG0H8i7v9G8H85IOtf2v9F
/GcB/q/bkPqX9n+x/ocFjP/chta/sP+L9p8F6N9tSP1L+78B9M8B9O82pP6l
/V/0/1nY7f8mR/u/Cfzfk4bQfyzu/4bwfzkg61/a/0X8ZwH+r9uQ+pf2f7H+
hwWM/9yG1r+w/4v2nwXo321I/Uv7vwr65wD6dxtS/9L+L/r/LOz2f+Oj/d8Y
/u9JQ+g/Evd/A/i/HJD1L+3/Iv6zAP/XbUj9S/u/WP/DAsZ/bkPrX9j/RfvP
AvTvNqT+pf1f/P4jC9C/25D6l/Z/0f9nYbf/Gx3t/0bwf08aQv+huP+r4P9y
QNa/tP+L+M8C/F+3IfUv7f9i/Q8LGP+5Da1/Yf8X7T8L0L/bkPoX9n99/P4j
C9C/25D6l/Z/0f9nYbf/Gx7t/4bwf08aQv+BuP/rw//lgKx/af8X8Z8F+L9u
Q+pf2v/F+h8WMP5zG1r/wv4v2n8WoH+3IfUv7f/i9x9ZgP7dhtS/tP+L/j8L
u/3f4Gj/N4D/e9IQ+lfS/m81/wv/9/Eh61/a/0X8ZwH+r9uQ+hf2fyOs/2EB
4z+3ofUv7P+i/WcB+ncbUv/S/i9+/5EF6N9tSP0L+78x+v8s7PZ/1dH+r4L/
e9IQ+vfF/d8E/i8HZP0L+78K8Z8F+L9uQ+pf2v/F+h8WMP5zG1r/wvt/ov1n
Afp3G1L/0v4vfv+RBejfbUj9S/u/6P+zsNv/9Y/2f334vydNt/7VQNr/VfB/
WSDrX3r9L8Z/LMD/dRtS/9L7P6D/xwLGf25D6194/S/afxagf7ch9S/9+2/w
f1mA/t2G1L/0/g/o/7Ow0/9Vg2P9X50C/N9ThtB/X9z/jeH/ckDWv7T/i/jP
AvxftyH1L+3/4v5PFjD+cxta/8L+L9p/FqB/tyH1L+3/htA/B9C/25D6l/Z/
0f9nYbf/2z/a/+3D/z1pCP2n4v5vBP+XA7L+pf1fxH8W4P+6Dal/af8X639Y
wPjPbWj9C/u/aP9ZgP7dhtS/tP8bQP8cQP9uQ+pf2v9F/5+F3f5verT/m8L/
PWkI/Sfi/m8I/5cDsv6l/V/Efxbg/7oNqX9p/xfrf1jA+M9taP0L+79o/1mA
/t2G1L+0/6ugfw6gf7ch9S/t/6L/z8Ju/zc52v9N4P+eNIT+Y3H/N4D/ywFZ
/9L+L+I/C/B/3YbUv7T/i/U/LGD85za0/oX9X7T/LED/bkPqX9r/9aF/DqB/
tyH1L+3/ov/Pwm7/Nz7a/43h/540hP4jcf9Xwf/lgKx/af8X8Z8F+L9uQ+pf
2v/F+h8WMP5zG1r/wv4v2n8WoH+3IfUv7P/6+P1HFqB/tyH1L+3/ov/Pwm7/
Nzra/43g/540hP5Dcf/Xh//LAVn/0v4v4j8L8H/dhtS/tP+L9T8sYPznNrT+
hf1ftP8sQP9uQ+pf2v/F7z+yAP27Dal/af8X/X8Wdvu/4dH+bwj/96Qh9B9I
+7/V/C/838eHrH9p/xfxnwX4v25D6l/Y/42w/ocFjP/chta/sP+L9p8F6N9t
SP1L+7/4/UcWoH+3IfUv7P/G6P+zsNv/DY72fwP4vycNoX8l7v8m8H85IOtf
2P9ViP8swP91G1L/0v4v1v+wgPGf29D6F97/E+0/C9C/25D6l/Z/8fuPLED/
bkPqX9r/Rf+fhd3+rzra/1Xwf08aQv++uP8bw//lgKx/af8X8Z8F+L9uQ+pf
2v/F+h8WMP5zG1r/wv4v2n8WoH+3IfUv7f/i9x9ZgP7dhtS/tP+L/j8Lu/1f
/2j/14f/e9J0639g0/49wP/VB/B/WaDq36L9e4j/G2H9Hw/wf92G0r9F+/eQ
8Z9K0f9jAeM/tyH1b8/+OUT/Cdp/HqB/t6H0b9H+PUj/IfxfFqB/t6H0b9H+
3e//hm39R4nC77+ysNP/HRxr/w7g/p443frvy/u/EfxfDqj6F/d/4f+wAP/X
bSj9i/u/uP+TBYz/3IbUv7T/i/afBejfbSj9i/u/8H9YgP7dhtK/uP+L339l
Yaf/2z/W/+3D/z1xuvWfyvu/IfxfDqj6F/d/4f+wAP/XbSj9i/u/WP/DAsZ/
bkPqX9r/RfvPAvTvNpT+xf1f+D8sQP9uQ+lf3P/F77+ysNP/TY/1f1P4vydO
t/4Tef83gP/LAVX/4v4v/B8W4P+6DaV/cf8X639YwPjPbUj9S/u/aP9ZgP7d
htK/uP8L/4cF6N9tKP1L+78+fv+VhZ3+b3Ks/5vA/z1xuvUfy/u/Cv4vB1T9
i/u/8H9YgP/rNpT+xf1frP9hAeM/tyH1L+3/ov1nAfp3G0r/0v5vAP+HBejf
bSj9i/u/2P+fhZ3+b3ys/xvD/z1xuvUfyfu/PvxfDqj6F/d/4f+wAP/XbSj9
i/u/WP/DAsZ/bkPqX9r/RfvPAvTvNpT+xf1f+D8sQP9uQ+lf3P/F/v8s7PR/
o2P93wj+74nTrf9Q3P+t5n/h/z4+VP3z+r8h/F8hkggx1mUo/Uv7vwnW/7CA
8Z/bkPqX9n8x/8MC9O82lP7F/V/4PyxA/25D6V/c/8X+/yzs9H/DY/3fEP7v
idOt/0De/03g/3JA1b+4/4vxHwvwf92G0r+4/4v1Pyxg/Oc2pP6l9//E/A8L
0L/bUPoX93/h/7AA/bsNpX9x/xf7/7Ow0/8NjvV/A/i/J063/pW8/xvD/+WA
qn9p/xfjPx7g/7oNpX9x/xfrf1jA+M9tSP1L+7+Y/2EB+ncbSv/i/i/8Hxag
f7eh9C/u/2L/fxZ2+r/qWP9Xwf89cbr178v7vxH8Xw6o+hf3fzH+YwH+r9tQ
+hf3f7H+hwWM/9yG1L+0/4v5Hxagf7eh9C/u/8L/YQH6dxtK/+L+L/Z/ZGGn
/+sf6//68H9PnA7925R+zcP1v/j9N+j/8YH+3Wapf638x/uMvfpP27//V00A
QP8c+P6Z768k7a3krI9ur7Jvwyz/Q+tQP8uz2/ndtPRUr/oTtf6T63Fu/Nnl
m4utk4P1yeXoq3Hyq9e/bZ0cdmXm9W99fRGZeeojNFhhqf/5+LqcWrL7t9ij
/1Cptv6DIIH+WfibFv/s22xeXnv1NaA1pqpKeab/3c28p2pZSfrd/I/Z9713
WqJn+m/eXVyuxVi/pv/yw9vzX18tTlGLUxpt1y9tnhF0JBJsnhJ1nBJtnpJ0
nJJsntLvOKXfym3XN1Ltr9SVY9XKsurKs2plWnXlWrWyrbryrVoZD7oyHrQy
HnQWdSvjQVfGg1bGg66MB62MB10ZD1oZD7syHrYyHnZlPGxlPOzKeNjKeNiV
8bCV8bAr42Er41FXxqNWxqOujEftq7vz8m5lPOrKeNTKeNSV8aiV8bgr43Er
43FXxuNWxuOujMetjMddGY9bGY+7Mh63Mp50ZTxpZTzpyniykXG1HZTUZlAK
ts8INs8IO2JfuBn7wo7IFm5GtrAjsoWbkS3siGzhZmQLOyJbuBnZwq7IFrYi
W9gV2cJWZAu7IltoRjbplgwcwrL/9/nPorx9rM/YO/8Tttf/BT76fzwsx3/N
QOvpYqT1PdTsCEv9X0+Ku6vykQaAe/Wvkrb+I/i/PPje7KY4axxd6dwAboz5
n8eyf/bqv/qxL7T/Mvje72/HX0pvzT/WvYEz70N1dXg/XmWzeTn1qjP/q+d1
0XGi93RafnmmOxNeNvf8r3nk+3/1xtN/eQECzcmw1P9y5u1xPmOf/iPVvv8j
iLD/Gw+ep3v/v/tnnq91n8+vtLqj9QufdbPwZzYtPT06LG+K8mau3++v359m
f3rX42Lc89Rg8WqoXy3Gn8bz7MrL7orxZOUX9LzKPazOCbbOWfot+pR4cYqi
T1HJ+vPJT4qoc1bJhOHzZeh6vnC+3YxJS/1/Kaez8eTmcT5j7/zv1v1/AX7/
gYnz4kt2k5eFbrJv7r4um/Hzaf55PC/z2gN9OdWN+dT7dXGFeOqZ/yx81ruY
XN+Or/Tf6ZcudQEGiaerMfJGk6n3Rzm9Ka+84Fn0LPC9px8u333v/Tmef/aW
V5n+q9m36+HkavbMTdGdEEv9z8p/Wb3ld4OH3/+rkjDE/b8cGPVf1EJ/hD7g
Xv8n3lr/F4To/7FguD9ns283889/La9v59/+qnrVO/qyOKv6d6sXpbMLLLPU
/2Q2O634H6WI/xwY9a8FX931bf8z9sX/qrLb8T/G/g8sLDr8iz7+8/BZ/5nK
zgZ9P/UT7+n52w/n3pe6w1+tybzK5tUAIJ8U5fe9v9d9/OfLYcOnIh8kTYf/
O5V4us/vfcjm3v9kN16oKncgjJ7Hynv14eNinDBO+okeRNyMxp+8yW2VcL0y
vPfmRtfHVTWwWHZHnnu9j99uS69ayFBnaJWTXu8imxY6P1Ui+rQHWpC989oQ
WDpfz72ffv7ovfrp/Me3r156b37yLn7+6fWbv/V6H6pGce9Zl7qRXJ3UMyZU
L9/9chb5ynv6y/n7j9/3eh/rhZbPe+nmsrsqha/1t+3+gEerf0P/j+YB7u3/
Be35vzDwsf83C54XrE25lZ0nnSsAAAAAAAAAAAAAAAAAAABwKP8PUClbAgAA
BQA=


------=_NextPart_000_6805_63af_483e--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
