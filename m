From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Tue, 07 Jun 2005 21:44:03 +0800
Message-ID: <42A5A4A3.7040108@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <200506061049.40902.alien999999999@users.sourceforge.net> <42A42D80.2020505@netvigator.com> <200506061635.12201.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050908090706040501020403"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200506061635.12201.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050908090706040501020403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 From your png, it seem that you are not using the alsamixer in the 
latest version of alsa-utils.

The alsamixer or amixer are unable to display EQ Peaks correctly, the EQ
Peaks is a volatile read-only kcontrol which return 20 EQ peak values 
from the 10-bands stereo hardware equalizer in au8810/au8830.

The graphic equalizer in vortexcontrol use a timer callback to read and 
display the EQ peaks when EQ Enable switch is on. (attached vc_eq.png)

Alien wrote:
> 
>>What do you mean when you say "the equalizer sliders look odd" ?
> 
> 
> i'll show you: see png file, notice that the first 2 peaks are stereo, and the 
> last 2 peaks are mono... ???
> 
> 
>>Would you post the settings of the equalizer from "/data/path/mixer" or
>>/etc/asound.state ?
> 
> 
> I must also say that when restoring, i always get one warning: something with 
> bad value for... somethingorother


When you upgrade from ALSA 1.0.8 to ALSA 1.0.9 ,the SPDIF sample rate 
control ( ALSA 1.0.8 ) has been replaced by the IEC958 control ( ALSA 
1.0.9 ).

You will need to delete old setting in "/data/path/mixer" and use
alsactl to store the new setting, otherwise error will occur if you try 
to use alsactrl to restore the value of emunerated spdif sample rate 
control settings saved by the previous ALSA version to the au8810 in 
ALSA 1.0.9 driver.

Your /etc/asound.state seem OK and the equalizer is OFF.

> 
> /etc/asound.state:
> state.au8810 {
> 	control.1 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'EQ Enable'
> 		value false
> 	}
> 	control.2 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ0 31Hz'
> 		value.0 16375
> 		value.1 16375
> 	}
> 	control.3 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ1 63Hz'
> 		value.0 16392
> 		value.1 16392
> 	}
> 	control.4 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ2 125Hz'
> 		value.0 16375
> 		value.1 16375
> 	}
> 	control.5 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ3 250Hz'
> 		value.0 16022
> 		value.1 16022
> 	}
> 	control.6 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ4 500Hz'
> 		value.0 16022
> 		value.1 16022
> 	}
> 	control.7 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ5 1KHz'
> 		value.0 16022
> 		value.1 16022
> 	}
> 	control.8 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ6 2KHz'
> 		value.0 16022
> 		value.1 16022
> 	}
> 	control.9 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ7 4KHz'
> 		value.0 16022
> 		value.1 16022
> 	}
> 	control.10 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ8 8KHz'
> 		value.0 16022
> 		value.1 16022
> 	}
> 	control.11 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ9 16KHz'
> 		value.0 16022
> 		value.1 16022
> 	}
> 	control.12 {
> 		comment.access read
> 		comment.type INTEGER
> 		comment.range '0 - 32767'
> 		iface MIXER
> 		name 'EQ Peaks'
> 		value.0 0
> 		value.1 0
> 		value.2 0
> 		value.3 0
> 		value.4 0
> 		value.5 0
> 		value.6 0
> 		value.7 0
> 		value.8 0
> 		value.9 0
> 		value.10 0
> 		value.11 0
> 		value.12 0
> 		value.13 0
> 		value.14 0
> 		value.15 0
> 		value.16 0
> 		value.17 0
> 		value.18 0
> 		value.19 0
> 	}
> 	control.13 {
> 		comment.access 'read write'
> 		comment.type IEC958
> 		iface PCM
> 		name 'IEC958 Playback Default'
> 		value 
> '0082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
> 	}
> 	control.14 {
> 		comment.access read
> 		comment.type IEC958
> 		iface PCM
> 		name 'IEC958 Playback Con Mask'
> 		value 
> ffffff0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
> 	}
> 	control.15 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Master Playback Switch'
> 		value true
> 	}
> 	control.16 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Master Playback Volume'
> 		value.0 24
> 		value.1 24
> 	}
> 	control.17 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Master Mono Playback Switch'
> 		value true
> 	}
> 	control.18 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Master Mono Playback Volume'
> 		value 24
> 	}
> 	control.19 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'PC Speaker Playback Switch'
> 		value false
> 	}
> 	control.20 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 15'
> 		iface MIXER
> 		name 'PC Speaker Playback Volume'
> 		value 0
> 	}
> 	control.21 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Phone Playback Switch'
> 		value false
> 	}
> 	control.22 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Phone Playback Volume'
> 		value 0
> 	}
> 	control.23 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Mic Playback Switch'
> 		value false
> 	}
> 	control.24 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Mic Playback Volume'
> 		value 0
> 	}
> 	control.25 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Mic Boost (+20dB)'
> 		value false
> 	}
> 	control.26 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Line Playback Switch'
> 		value true
> 	}
> 	control.27 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Line Playback Volume'
> 		value.0 24
> 		value.1 24
> 	}
> 	control.28 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'CD Playback Switch'
> 		value true
> 	}
> 	control.29 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'CD Playback Volume'
> 		value.0 24
> 		value.1 24
> 	}
> 	control.30 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Video Playback Switch'
> 		value false
> 	}
> 	control.31 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Video Playback Volume'
> 		value.0 0
> 		value.1 0
> 	}
> 	control.32 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Aux Playback Switch'
> 		value false
> 	}
> 	control.33 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'Aux Playback Volume'
> 		value.0 0
> 		value.1 0
> 	}
> 	control.34 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'PCM Playback Switch'
> 		value true
> 	}
> 	control.35 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 31'
> 		iface MIXER
> 		name 'PCM Playback Volume'
> 		value.0 24
> 		value.1 24
> 	}
> 	control.36 {
> 		comment.access 'read write'
> 		comment.type ENUMERATED
> 		comment.item.0 Mic
> 		comment.item.1 CD
> 		comment.item.2 Video
> 		comment.item.3 Aux
> 		comment.item.4 Line
> 		comment.item.5 Mix
> 		comment.item.6 'Mix Mono'
> 		comment.item.7 Phone
> 		iface MIXER
> 		name 'Capture Source'
> 		value.0 Line
> 		value.1 Line
> 	}
> 	control.37 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		iface MIXER
> 		name 'Capture Switch'
> 		value true
> 	}
> 	control.38 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.range '0 - 15'
> 		iface MIXER
> 		name 'Capture Volume'
> 		value.0 12
> 		value.1 12
> 	}
> 	control.39 {
> 		comment.access 'read write'
> 		comment.type ENUMERATED
> 		comment.item.0 Mix
> 		comment.item.1 Mic
> 		iface MIXER
> 		name 'Mono Output Select'
> 		value Mix
> 	}
> 	control.40 {
> 		comment.access 'read write'
> 		comment.type ENUMERATED
> 		comment.item.0 Mic1
> 		comment.item.1 Mic2
> 		iface MIXER
> 		name 'Mic Select'
> 		value Mic1
> 	}
> }


After eight instances of "mplayer" playing stereo music concurrently in 
my 32-bits machine and start an instance of aplay.

aplay outls.wav
Playing WAVE 'outls.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, 
Stereo
aplay: set_params:935: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: 11
BUFFER_TIME: (510839 510840)
BUFFER_SIZE: 11264
BUFFER_BYTES: 45056
TICK_TIME: 10000


aplay abort as there is no more SampleRateConvertors available.

There is no deadlock or hang. After the "mplayer" finish playing and 
release the SRCs, I can start another instance of ALSA application to 
play music.






--------------050908090706040501020403
Content-Type: image/png;
 name="vc_eq.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vc_eq.png"

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
nXA6DHm5+fTGyg5jTk4evQtzxKbMTnM2MvhzOy1Z6A7OLktmZrYLiRjSM7PcNLSlZ2SgTiIt
Ld2NuJBUNGLwOpJTUr3I9ptJyam0N/K5kpKSw2GSj9oMwudzJyYmwp0j/H5PfEJCAMKANz4u
HkYMgYA3Ni4ervkYDPpiYuMQGIhBvG8wFIiJviIMhYLMaGYoiAQQUUx0sWqMwQA4CndcfnYH
iciM4zgjioGHdr5QRDWuXudg0B8TGxt2+zFxweDOjRPRdH6/JyEhAbazz+dOTEr0070Q0Snh
XRbRv+HxYoQyRKhKhCJ5XNaMzCzXFZTQ7TRnIZvIX6bAYertchhzc/LgZEaEaUQaTrhZOWw6
Fou2wQiTjLRfi7qwmG2lrNtmUbPZJeYrUIHVpCgtLYdjiUgaiSAZg5RTUWVACaqyGoURbFZZ
VQ25zqwXVyH7lZv0ourqOhh8RNKmVlBb1wiDD6OGX9fQDCnXoOY3IIRsUPMam2j21qt4zc1t
cICnU262tiLMr9hsbePCWESnWG/ldkKvoZWvtXV0Ka7gcTSySx2dPQgMd08Rzkt6sbO7n/Z0
8rWWtk6l1glwHAe4zaRkl5SZbN6jf37xuZ/fD/6WpbU2l4wh4J6nH1EOfv5bo3sPA0A/O2EA
DPkPYNgHbCa4K7uyK7uyK7vyty6Ep8OJKT6c/C9EBOw4wAF4543fvvirh69zLT+aNJSnkwvL
PPP8mx9Xoc88OPtxFbUru7Iru7Iru/J3KUUtn/kYPe/1EqyiZWb74msqFf029Te/+c3rWKH/
a/KjH/3oeldhV3ZlV3ZlV3blLxYWi7Xznlu//vWvP+Gq/B+UixcvPvroo7sR267syq7syq58
dLkuI1LmlV7fVqvVn3BV/m/Kbrj2tyhE/PfJ9N0nea2/WvlbaYS/lXr+tcnfQbtd31sgrn5d
Lr3zfhm78onJhQsXrncVduUvFgaDAT6pvvskr/VXK38rjfC3Us+/Nvk7aLfrewvE1a/Ppa/x
G7Bd2ZVd2ZVd2ZVd2RVUGLvTELuyK7uyK7uyK7vyIWR3HmJXdmVXdmVXdmVXPowwsN15iGsT
HMcDgcD1rsX1ERzHg8Hg9a7FruzKJyFyudzr9V7vWuzKrvxtCOOTnIYoKio6ffr0J3jBj1NO
nz5dXFx8vWtxfWRpaamzs/N612JXduWTkIWFhbW1tetdi0jp6OhYWlq63rXYFVo+So/8PfXm
zutDRAiLxXr88cfn5ubQIz//+c9nZmb+oosFg0G4GeD/f8JisSKO1NbWvvPOOx9X+adOnTpw
4AC6KtfHJe+9994zzzwjFAo9Hk9SUlJRUdEdd9zR1dV14cKF2267bXFx8eO6kFAoPHz48OXH
b7nlljvuuOMjVjg7O/sDC/+v//qvX/3qV7/5zW+qq6thBhzH33nnnRdffJHH47nd7uTk5JKS
kjvuuIPL5W5sbDzwwAMSiaSiouL73/8+m82Wy+ULCwto+Tk5OX/6058cDseDDz548uTJ+Pj4
z33uczfeeCMAQCqV/uQnP1lfX/d4PGVlZV/72tdaW1vRc996663FxcWVlZW77767vb39Kgev
JFwuNyoq6o033sjIyCCOhEKh+fl5lUpFdByXy33wwQfHx8eJ30QeBoORlZXF5XJvueWWkpKS
iGx/UbN3dXWhJROFp6enT01NfeUrX2EwGNd4UbQEQu699975+fmIm/3ASkql0rvvvvvFF18E
ALz11lvPPfccn88HAFRWVt50002jo6NXOffkyZO1tbWwJf/SRvirksvbisvl/vCHPxwZGfmL
ygmFQp8AeV5dja9ORB8vTd16661CoTAYDLJYrK9+9as9PT3gqoaDyiejG9fYIzty3UfszWsx
kE9MrimG+JuTiIjn45X6+vqXXnrpYy9WpVLdc889d9999/T0dFxcnNFo5PF4ycnJAIDKyson
n3zyY7wWh8OBpn4t/uAvqvAHFh4IBF599dWMjIw//OEP3/rWt+DxX/ziF08//fRXvvKVhx9+
OCUlRafTra2txcbGBoPBb37zm1/84henp6cfffTRe+6554UXXsjNzf3tb38Lz33qqaeIHw89
9JDZbP7zn/+sUqm+8IUv5OXlDQ8Pf+Mb3/jyl7/86KOPBoPB559//p//+Z/ffvtttEoajaa3
t/fll19GDXvHg1eX119//eabbyZ+nz9/Xqu94lZ2Dz744OjoqNvtFgqFP/vZz26++eannnqq
srLyAy9xFT2BJY+Pj4dCIYfD8e677z7wwANtbW29vb3XftEPpw8Rcvz48b6+PgDAs88+++ST
T95zzz1E3PD2229/97vf1Wg0N91005XOveuuu5588smrUOQHNsKufBS5khpfnYg+Xpq64447
GhsbGQzGY4899r3vfQ8a7Afq8F+VblyJ6z6ifKCBfJLyUT8q/eUvf9nT01NZWdnY2Pj8888T
B1ks1mOPPdbY2HjixImNjY0bbrhhbGwMhpAjIyO/+c1vAAB2u53NZj/yyCMAgFAo1NDQsL29
/YEFXrhwYXp6uqmpqb29HfUi1yIikejw4cPV1dUFBQUsFuvUqVNE4cQP9PeO1SBkbW3twIED
AIDXX3+9mhI2m11eXk5k2LGG6C3sWDeNRhMKhcbHxxMTE6OionJycvr7++vq6gAAfD7/tttu
I7Jtb2/fdttthw4dmpiY4HK5RG25XO6rr766f//+3t7el1566fTp08PDw8PDw8eOHSPOev75
5xcWFvr7+8fHx1955ZWrt9Lq6urnPve58fHxmZmZV1999UrZrlLhq8vx48ezs7PvuuuuN954
w+Mhd/bT6XS//OUv77jjjs985jMZGRlMJpPFYo2Pjzc0NIhEIo1GMzk5GRUV9Q//8A8ikYjH
48XExHAoCQQCy8vL3/rWt8xm81tvvXXrrbfGx8dzOJypqSki2tPpdDk5OQwGIzo6uqamJiUl
JaJKn/3sZ/v7+6/l4FWkv7//lVdegQHHyy+/PDAQuccuKgwGIzExsbGx8T//8z/T09Mff/zx
a7nKNTY7g8FISUmZmJgAAFgslo940asIl8t966237rzzzs7Ozq9//esharPyEydO9Pf3m0ym
xx9//M4775yfn09KSkpKSlpYWLjzzjsfe+wxs9lMnA4/qSd+E5NVd91111XWzLl6I3C53Jde
emn//v1DQ0OvvfYacXBHrb6KXYRCoVtuueWFF164yulcLvfZZ58dHx8/d+7ch2i6Ha+Olsnn
87/4xS/eeOON09PTROqnPvWpl19+GQDgdDq7urqeeOIJoqpjY2NisfgDC7wW076KGkMieuml
l4aGhvR6PQDg2LFjhw4dCgQCKE3tqBU7cteVpLW1lclkMhiMuro6LPytvavr8NV1QyaTffnL
Xx4cHBwfH//pT3/q9/vBTkp4pVu4vEeuLjtyHSEKheLTn/50T0/Pj370I6Lwa6zbtRjIJykM
8NE+zKiurn7ttde2trZuv/32+++ntzF96aWXnnvuuerq6htvvHF2dvbtt9+GY9POzs6zZ88C
AI4dOxYdHU341PX19djY2PLy8qsXyOFwbrrppi984QsrKyvPPPPMPffcIxQKr7GqgUDg5ptv
Li8vX1tbE4lEH+6+UJmenubxeDwe78iRI8nJybfeeisAwGq1XqmGxC38f+3daXwUVdr4/dOd
ToIsAQlCbAibrDchJgQiRlAWWZRdYEYEwbBE9oGAAcQRBBHNQAiLMCAMS4AbAQVCdEY2BQUi
yCL7quyEQBBjFiTb86L+00/fSXenutLprip+3xd+YnVxzrlq69PnXFVVaBTdomnTpsHBwYMH
D/78889v3Lhhc53s7OzRo0e3a9du48aN33zzjY+Pj+WjzZs3z50796233oqPj//3v/+9YcOG
F198cc2aNdKnzzzzzMqVK/fu3TtgwID58+c7CDw9Pf1vf/vbX//61x07dsydO3fWrFlXr15V
3GCbtm7d2q9fv5dfftnX13f37t3Swp9++ik/P79z585F15fOJSmhtUyZMkKIX3/91fJpbm7u
jBkzJk6c6Ofnd+HChYKCgoYNG0ofNWzY8OzZs0KIMWPGDB06NC4ubuvWrUuWLJG6rS7XvXv3
K1eunDx5Ughx//795OTkV155Rc4/9PX1ffnll48dOyZnZZmbPT8//+bNm7Gxsb6+vjYnYpyq
1LHFixf3799/+fLl33///blz54QQ6enpV65cadq06aFDh3Jycjp06GC9focOHR49enT48GF7
pQkh4uPjo6Oj7dVY7EZYv3799OnTe/fu/dFHH6Wnp9s7qh2cFwkJCSaT6S9/+YtweFJ89dVX
CxcuDAoKcmqLSezVLpVZr169MWPGdOzYcf369V999ZX0UWho6PHjx4UQBw8e9Pb2lvouFy5c
8PHxqV27tuMCa9WqJefUlnMYv/baa/Xr1589e/aff/4ZFxc3adIkk6nwkHaho8LBtcumR48e
XblyZffu3evWrZs+fbrNdWweww6Ojdzc3LFjx9asWXPXrl1r16797rvvli9f7qANRUMoukcc
s3mtk6xYsWLcuHFz587dvHnznj175LdNzgniTkaZz6kcMWKE2YpleatWrSpXrpyZmVmzZs3f
f//dsjw6OjooKOjw4cP379/v16+fdVGWPsTOnTvHjh17/PjxjIyMvXv3tmnTxmAwOC4wOTn5
4cOHNWrUOHToUFZWVpUqVX744YeirR05cmSgldOnTwshjh079uuvv44ePdpkMvn6+jqO114z
isrJyXn77bcbN248ceJEIcTu3bvttVAKoVy5cjbL8fb2Xrp06Ztvvvndd9/16dPntddeW716
9aNHj6zXOXTo0G+//VZocloyZMiQOnXqNG3a9OHDhzExMVWrVg0KCsrI+H+vtw8PD69UqVJ2
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
6tSpY1nSvn37pKSknJycatWqDRo0aOXKlQsWLLhy5UpGRsa1a9c2bdokzQT98ssvubm56enp
CxYs6NKli9RbP3/+vHSfraW0ihUrdu7cefny5dnZ2VevXv3666/79OkTGBjo4+Ozfv36vLy8
7OzsvXv3SoOTsbGxhe7OKLmyZct26NDh66+/7tWrl5xd8+jRoxMnTowbN85gMEj5NMVSsNlL
XqlTTpw48cwzz0h96MqVK48YMeLTTz9NTEzMzMzMyMjYunXr4sWLR4wYIQ0mlS1b9uzZsxcu
XLCe8y5btqzjmY5iN0JOTk5+fv7nn3/+9NNPBwUF2TyqHZwXFStWnDVr1rJly6SEA/knhXzF
npXNmzfPy8uTble27vWGhoZa8hzDw8MTExMbNmzo5+dXbIHyoyj2MH748OHcuXMnTZo0bdq0
ffv27dmzp9h4nb12HTt2LC8vLysra8eOHc8++2yhTx0cww6OjeDg4MDAwFWrVuXl5aWmpm7d
ulVKjbR5EBZlb4/Y5OBaZ73ar7/+eurUqc6dOzvVtmJPEHcq0X0ZLVq06NOnT58+fXr06BER
EREaGtq7d2/rFQIDAz/++OPp06e/9NJL0mibpGXLlnl5eVIfIiIioqCgoE2bNnIK9PX13bhx
Y2ZmZnh4eP369Xv27CklzRVSKHvDbDanpqb6+fnNmzfviy++6N2795AhQywrjxo16uOPP46K
ipo0aZLMuCQbNmzIzMyMi4uz3J3x559/ymxhUX5+fjdu3Jg5c2anTp3Cw8MHDBhQpUqV2bNn
W69TuXLld999d9OmTUOGDOnXr5/RaJQzNhgSEvLqq6++/fbbgwcPbt68eZMmTaKiouyt7OPj
s2TJkqysrK5du7744otDhgy5dOmS4gYXsnXr1vbt21tfO9q2bfvbb79JebUjR46cPn36sWPH
BgwY0KZNm6FDhx45cqR69epCiC+++KJdu3Y9evSoWbOmZTft27evXLlyoaGh1lVMmjSpcuXK
nTt3joqKGjZsWLt27SpXrjxv3rzdu3e3bdu2a9eu+fn5UiM3btxoycbq27evdARGR0e3adPm
5s2b9hYWKzIycsqUKcU+OkWaI2/VqtV7773XoEGDNWvWyBzbV7DZS16pUyx3dUoGDhz4/vvv
b9q0qX379h07dty6desHH3wgzUkJId56663FixdPnjzZevxp0KBB06dPd5C2VuxGkPLbf/rp
p7lz55pMJptHtePzIiQkZNiwYVOnTk1NTZV/UshX7FlpNpunTJkSHx/fp08f68OpWbNm+fn5
0hZu3rx5QUGB9OSDYgt0KgrHh/HKlStDQkKeffbZunXrRkVFffzxx46TxoTz165//OMf7du3
79y5s9FonDlzpmV5scewg2PDZDLNnz//l19+adeu3YABA9q2bTts2DBh5yAsyt4escnxtU4I
MWXKlEGDBk2dOvX9998PDg52qm3FniDuZKjfrMvFo19Zd0hjYmISEhJu377twWa5gdls3rx5
szRC7hEpKSlxcXGWwQ/5pOeTpKend+jQYcuWLYGBgaXRPN3bsGHDgwcPhg8fruDfGo1GZftO
5XW5RO/evefNm+fah7o6tRGaN2++dOlSm4l+pU1zO8vN7F27dLDdPBuCVLvjqeTSYDabSzSX
ATe7dOnS8ePHc3Nz//jjj3nz5tWrV89BxjIcS05OdvZBqyiWNOv32D4VHvZw7dIrufdl6M/C
hQvr16/v6VY4Jz09fc6cOTdv3vT29g4JCYmLi5Mz6Q6b5s2bx9ZzubJly8qcWCk9M2bMsJ6H
hhpw7dIrfT7rWg6bKQ4q16xZM3v3OMFZXMJKQ5UqVSz55J7y6quverYBKIprl14xlwEAAJQo
6fsyAADA48lQv1nXi0eTHsP7MjxOui/D060AAEAu67s/zGbz45sPoQYJCQmebgIAALJYXgpv
QR/CYwICAhjsAQBoQkpKStGF5EMAAAAljII73AAAgPOMouAxfcYUAAAoCeYyAACAEiaZz5iK
iYkp7aYAgFaU9vuNuOTC4+Qc5CZhkDuXofUbEaWbUrQehURPsbiERjeIRpstn14DLHqHW2mI
jo52Qy2lJDQ0VGd7XwpH0ztFPsvuK5Zz93Zq915E65tStBuFRE+xuIRGN4hGmy2fXgO0eYdb
KcnPz3dbXaVHB3vfeqfrY6e4ivFxfW0nAABKxMfH6/i/TpH7rGutPwDb8mBpTUch0VMsLqHR
DaLRZsun1wCluNyQDxEdHa3dn7xhYWGWuQwd7H3LwazpnSJHfHz8uHHjpN1X6CAveuSbzWbu
ywAAwAkKfq9rxbhx45xanz4EAABOcPaLVkOc7R4ZZd7bCQAABOMQVhiHAADACYxDWNCHAADA
CYxDWBgFN3cCACAb4xAWjEMAAOAExiEs6EMAAOAExiEsjNyWAQCAfIxDWBhFAZ0IAADkYhzC
grkMAACcwDiEBfdlAADgBMYhLBiHAADACYxDWPDubwAAnMA4hAX3ZQAA4ATGISyYy3CrK1eu
PHz40NOtsKugoCA3N/dxqxqAtevXr//555+eboWqMQ5hwXs73SoiIuLo0aOeboVdBw8erFmz
5uNWNQBrvXr1OnXqlKdboWqMQ1i49b4Ms9m8bds2t1XnWmYrtWrV6tSp04EDBzzdKIUKCgoS
ExNfe+21Bg0aVK9evXHjxt26ddu/f7+ryj9w4IDZbHZVaW5gvXMDAwNDQkJmzpyZn5/v6XYV
w7rNYWFhY8eOvXTpkqcb5Uqld9Lt2rXr7t27LilKhZo3b75jxw5Pt8IF9uzZM2DAgKCgoOrV
q9epUyciImLw4MGebpQQJRuHaG4lPDy8U6dO8+fPV8/VhvsyStGSJUtu3bp1/fr1AwcOBAQE
jBo1ytMtUiguLm7MmDGdOnXav3//lStXduzYMXTo0DJlyriq/KCgoM2bN7uqNPeQdu6NGzdO
njz5zjvvLFmyZM+ePZ5uVPGWLFly48aNM2fOLF269NatW507dz5z5oynG+VKpXTSDRw48OLF
iy4pCqVk6dKlkZGR4eHh33zzzdWrV48dOxYfHx8SEuLpdglR4nGIjz766Keffjp06NCuXbuG
Dx+ekJCgnl+kmsmHWL58eURERIMGDYKDg//3f/9XCPHVV181+q9atWrVq1fP3kLP8vLyql69
+ssvv/z7779LS3799dd+/fo1atTo2WefnTlzZk5OjhDi0qVLb7zxxjPPPPPMM88MGDDAuoS8
vLzu3buvWLHCA60XIiUlJT4+ftKkSW+//fZTTz3l7e0dGBjYo0ePsLAw69WK7qCCgoI5c+aE
hoY2bNiwcePG69ats7fw1KlTffr0kcqxuR2KFq4SRqOxUqVKPXv2FELcv39f2Nm5ZrN59erV
L7zwQqNGjTZu3OjxNleoUKF58+Zr16719/f/5JNPhJ0tbDabExMTX3/99Zo1aw4aNCgvL0/Y
2UFHjhzp0qXLs88+26JFi88lemHnAAAgAElEQVQ//9xToVkUPemKttDmoWhzzb/85S9CiIED
B06bNs1DAXnAtWvXRo8e3aZNm44dO86fP186kq9cuTJmzJhWrVq1atVq7Nix1uvn5+cPHjx4
w4YNHmnt3bt3P/roo5iYmLFjx1avXt1kMlWqVCk8PNzSSPlH+NmzZ/v06dO2bduQkBCz2fzt
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
vvqqu1tcHDnNfu655zQRi3B4jl+5cmXw4MFxcXEhISHubJIyDo40obVYhBBXr15955131q9f
HxERUegjzcVy+/btgIAAo9FoNBqDg4MrVapk+UgrsRQ9Tex90UjcH5fnxyEePXp06dKlpKSk
pUuXxsfHe7o5yh09erSgoGDfvn0RERHBwcFbt26VlusmQCFEcnJyWFiY5X8/+OCDRYsWqXkk
UOK42adPny4oKAgKCpL+Nygo6MSJE+5vZLHkNFsrsThw//79/v37jx8/vkOHDp5ui9MKHWma
iyUjI2PIkCGzZ88u+hNWc7EIIaZOndqrV69p06atX7/+k08+Wb58ubRci7FY2PuiER6Ky/N9
iJSUlPj4+Llz51aoUKFOnTqebo5yaWlpQghvb+/9+/dPmTJlwoQJmZmZQkcBJiUl7du3b968
edL/btq0qVevXr/99lv79u23b9/u2bY5UGyzMzIyhBDly5eXVqhQocIff/zhqdbaI7PZmojF
saVLl2ZkZHTr1s3TDXFaoSNNaC2W/Pz8UaNG9enT56WXXir6qbZikTRu3Njf3//o0aMTJ06s
Xr26JZFIi7FY2PuiER6Ky/PPqaxZs+aiRYv27NlTqVKlYcOGebg1JeDr6yuEeOONNwwGQ/fu
3bOzsy9evCj0EuDGjRsXLFiQmJho+YHywgsvvPzyy3//+9+HDx8+c+ZMj7bOLjnNloYEpW9f
IURmZmaFChU81F67ZDZbE7E4Fh0d3aBBg/79+2ur91P0SBNai+XChQs7d+6cMWOGJW+3Xbt2
lrRcbcUihMjIyIiMjJw7d25iYmJCQsKhQ4csqSqai8WavS8a4aG41PJ8CIPB0Lp16wsXLni6
IcrVr19f/Pfy7eXlJYR44oknLJ9qOsBNmzYtWLBg48aNNu+/qF69empqqvtbVSyZzW7SpImX
l9epU6ek5adPnw4ODnZrQ53huNnaisUmX1/ff/3rX/n5+YMGDcrOzvZ0c2Sxd6RpK5YGDRr8
akUI8Z///CcyMlL6VFuxCCHOnj374MGD559/3mAwtG/ffvr06Zbb4jQXizUHXzQeicvz79z6
8ccfc3NzMzIytm3b1qJFC882piSCg4MbNmy4YMGCvLy8bdu21axZU8p20XqAUo7V8OHDHz16
lJqaaukuXL9+XQhx586d1atX2xz89Cz5zX7yySd79uwZHx+flZV1+fLlzZs3v/XWWx5suU0y
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
--------------050908090706040501020403--



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
