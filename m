From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [BUG] (via82xx) no sound on VIA 8235 sound card with CMI9739 codec
Date: Fri, 26 Nov 2004 20:32:45 +0100
Message-ID: <m2d5y0tnhe.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

--=-=-=

Hardware:
=========
this card is managed by the snd-via82xx driver.
it's named "VIA Technologies|VT8233 [AC97 Audio Controller]".
according to /proc/asound/cards, this is a VIA 8235 card with CMI9739
codec.

its pci ids are (in hexa):
- vendor:1106
- device:3059
- subv:1071
- subd:8355

here's the relevant part of "lspci -vvvv" output:

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Mitac: Unknown device 8355
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at e100 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

it was tested on a 64bit laptop both ia32 and amd64 kernels.



The problem:
============

the card does not produce any sound (interestingly, it does neither
with the OSS driver) whatever muted/unmuted mixer combinaison we use.

both alsa-1.0.2 and alsa-1.0.7 drivers display :
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.



/etc/asound.state sample:

--=-=-=
Content-Disposition: inline; filename=asound.state

state.V8235 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 25
		value.1 24
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Center Playback Volume'
		value 24
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'LFE Playback Volume'
		value 24
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 24
		value.1 24
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 24
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 12
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value true
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 24
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 24
		value.1 24
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 24
		value.1 24
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 24
		value.1 24
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value true
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 24
		value.1 24
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 12
		value.1 12
	}
	control.30 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.31 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.32 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.33 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.34 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.36 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 0
	}
	control.37 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Analog
		comment.item.1 Digital
		iface MIXER
		name 'IEC958 Playback Source'
		value Analog
	}
	control.38 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Valid Switch'
		value true
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Monitor'
		value false
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Switch'
		value true
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line-In As Surround'
		value true
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier Power Down'
		value false
	}
	control.43 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Line
		comment.item.1 Mic
		iface MIXER
		name 'Input Source Select'
		value Line
	}
	control.44 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Line
		comment.item.1 Mic
		iface MIXER
		name 'Input Source Select'
		index 1
		value Line
	}
	control.45 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Output Switch'
		value true
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		value.0 24
		value.1 24
	}
	control.47 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		index 1
		value.0 24
		value.1 24
	}
	control.48 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		index 2
		value.0 24
		value.1 24
	}
	control.49 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'VIA DXS Playback Volume'
		index 3
		value.0 24
		value.1 24
	}
}

--=-=-=


/proc/asound/card0 with alsa-1.0.2 (patched kernel-2.6.3):

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=asound-1.0.2.tar.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWUTU5vQAELV/p/+QAEBYb//yP+//+//v//AABAAAgBAAAIGYYAm+e632N7u+vvZ9
fG9tjrQHdtJ2e555tMTZi4ZFGommj1D1Nom0mjQaGQxNDGiGaIAGIMQYGQRo0jSaKn6nqIDQ0aBo
ABpoDJ6gAAADmPR6qAAAAAAAAAAAAAAASIhCNVPKeTU8p+jJPIo2Seo9QeiaZG1AzUyGBoEeiBFI
TFMhKeaj00p/olPQmjQ00aHqAaNGgAHqAND0EUSCaaMRMkm9BE3qmZQ0ZGjIekepo0aaGmIHqAOv
qRWDqV8i7pL+S8wEB1TD+KB9cXUsj2mISIIgiIVdmSK0BZKxAjCpBpBASKAkMSS4bS+GZ0zwcHDN
HNnMWibDmaWtdVmh6O8O6Vo0OFo7VdxR3oASFBQBCeYIJVUJLNVhgxQ21e26SpShg6JQBZhG8ZKg
Gqs0VmiofaHcpSEhIVVhgQIYBS3TpumAhKaxC+tequnNwV8GecM9InKcYBzmYRS0oqRCA2mXNZXD
RrbvinRLhw4etjSVoavahpu3HrzlsYbMLYOzCx5IFDPT+0z9rNvCF0M5mczVNiM+7WQK5qkpFNzu
GING0kcs4X6IWADyUmjMISB4JJSt1LdMVzFXoRQ7yKwCCmChLam69HHFb+dDAo5WxHAYl2dJld9x
YexkL/bsPRlb7khczWX+lTse7yAD0IMoD5AEhBhIiIEgG9xpJQwbQO2iRSwdkL1TJypIjMjpeXk7
StJ1IpkRERERUAAAAAAc5jGBAxjJkQggEiOCRFxW53Um6HkRtmnbn6yl/Wx7efVecbG0EsvH8WxM
vrqCR3+5PlPQISvL5rOBt1VDI4xHjz4IJHZG9V7CDLrQR9EQJqLLQLskADoIQCUntrDqMCmROH0+
6w6KbXIrxzEKckAWdqQEuZsWGMoISq61hS5mpVMbGMaYxjSCiq61jHWAFAJE5LdebopAq4IiNcpN
aSorGEkMI+kCABoWta2vYycRjhlP86QjfrWSVQGwaSEwTkEjHGAQjF2NDkpIAAUmDIBNLrk+dg7q
KsIkCL2S+jyQZ2PV8IdvvLgolkJByQW9zwcuY8ZBCe9+EeNfFQaA+hNiK4G7CUV6+6mUUIKQjSFE
jjz7k7orFytpEk3duRwQoJHC6Nspd5O1eM6a669Xa0JJOr5XtkDhT7A7V8s1JB7b44a5G6pWNWmd
XckA6PRecHOOnVq5rpAHI3Ir5yacOYsKDJ49E0DZTdzUiBbUrjQUwwhkaIrE4RXEIqOZBJ8wS1KY
lGDDoQHW/XihA6bJa+QvSOt0rXfeZ1x6vWBjhO7CscWrtQClAAfASMLWgBslWuLZN2DM60EMKKvK
+04nT6yW0ITlVW48t/DQis77cVfdKrIM1hl0UJIhDKNTSZLmWZsgJ2ZAWuJYMTq6rVN7hhSOpWSr
pdOckAFCVHi4khK18Kt7699Soq6tNtEXRW6OWqi10hhNHCcoDFAEICCgEw4gkEQbWuIS7Fa2ZqUF
qW+2Bfi/Z3pbE414ZyNYXQgzcQqylbyQWaKyxJGGq84rWpBJeiIQSeMq8aEFXqoZsa0TWHcWDKwx
bRlYdEDII5S8YtXGl0GH0pLK9+ySsEEmhEUFhRHlQLPWAoVKYxENeiuANQQOHjaECMkYYg6b660o
o0GRZciKxd2IM3ai3bL4pa7hU0ecYm1JxTDadWZCIM1m/dqSRj4Js2LVbSlZbGttLTmYaRVyndss
2Jz6L81xjOr8fLzqcwHSpCwphsMcYIiIiYiIiIiIgmUR0CqdzDDBHOKYNWV5jkoRnyonBGuRhg6L
1Z9ECcXjFCVtIdJJDkiOBKUG4ckvAAoAB9evDq1/Bm1ebjVO/9QHlXiK/Cd/oat4WP6xPydj8SYo
2c8we6mydFpDAWlRUl4AZKUYr521Z2cpxCbBPYtoI0AYtgRyA+hQnfQwz2T1KcU728SNBc8AsWyv
TQK7atB5pXDSqRZO3ANEMZG3EMf0s3NLzaulbgxXAuN223ALdmVKg9cTdtms+ySapiptAQRxSvSm
+Uux5y37OjyGzZuql9WhNeGGmeYzJrHEB6kRbpXcCVe5kGyiEAogSbkMwQXqBwNtgvXjIC88gYzz
97bYEhZTe+g2gnZbdFJ/L3R9PcJDgISKlVFXICWkZP4EqRGt9kYgkwV+mByCrZpYw05TDc2HnF6u
DvwIfEKcJtF9KdvtxUiuAviAQni5BTvHa6G8s5s+eqoC/FSC3P/AiWwAvT4SVLDR5Ut3NnenTTTq
1alSW22222227800uNczrgvvxxuxx58cnV7ux8/+ud6D3j/6JpR8vVNv5rcUpEsmYhjiPhfQmRSU
8KEyKS65qbjTzIB6qQKZ8OetJKeupcQ7Yo+BtxKW2kQIb47UemiuqFO61UzKmUJBjVioSsQEAN3t
WZ1M+/fvw7W/flldE+q8EcQ+N9Sj6nQSHQ3cBBUNw5hBByzdWlcS9WLDy8Ze3N1fsYTXHg9Z4NNR
kHLOIpoSucqaVRuDcbJEmMITiDUvHQOO10KV8vLOvUbTXa6zW9NT7K5bOnMIVHDRWqn0U5d/dF0n
J8FSnA8eSmgMHs3MbYvJ7cZZ7Reegpy0Y+S9S0QuK6biFi5WYo1U1veoTFKvPQJgFLEZxLapxqXK
t5FbOsU3VKZUK7SGQtUnlUp5IuiNS3O3UE6w1/M7CpmnIfKXUEV6+OLw1iG5KhFeLrYqY7NXZ3tt
ttttttsQfIThubwlfOIkLfnOPRdFUriezsZTRWZJZC1vOYCF9cLVT9b1NzocJhqZHgRXpRXPLSV3
cgtF3hjEtshTmKdE5CkZhDAo8BsYkqCNApE5F6K197hW664msGoRIUlSEU7FFuEVnUXY0M0Aw7cE
EJTmJDr+erB03yXlVs7iVLL9E5a7MwFqKPFwlIHYdEAdaK25TDx44i7ZKjjwYICAiSx3bDzs8UYj
4keEU7hBJAzi7kinChIImpzegA==
--=-=-=


/proc/asound/ with alsa-1.0.7 (kernel-2.6.10-rc2):

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=asound-1.0.7.tar.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWRykSiUAE81/r/+QIEBYb//3////6//v//ACRAAEAAWAEAAAgZhgDPz71p2853Z7
unWamnu7nDpqimWdx3FzcqG3cBqgaBkQIhppoaRmplM0TDRkRp6E8kxAaNqA009QAAASiaABEFG1
RnpNCaaAGgAzUAAD0gAAACqn6n+U2qoAaaNAaA0xA0AaAAMjRkBoxAAASIhCBNGqf6hqZRoHqfqg
M1GygBoD1PUaA9RtQaBoNP1Q4GgNBo0DJoADQAGJoaaBpoAaNGgAaNBFICE0BA0aBDJTxTR6mNPV
MjQAD1GRtTR6g0ADTb1gIOuGJdKWuEp+9LsAMOugU/SoTf9Pfko9T8ye+82RIaEUBtDY2NjSS0Sr
msgCCJKMAkQowgwTBVBookAIRXx+R2Q6S8AEFwlSkzmCeIjRAzngFmTAIwJRL2gXtO5Wc51pQtSk
7gjdpCSCF5gBCQCHFZlLYOYGGCaUDReWpQkFOCUAXMI8g0KqGmLTAQkKKfsDy0pCQkCiEBAiQwIx
AJ549WOrXz564CE88V+i/DgIbslywiElGjLww2lpXh6s+cLFJeWXeFAZWW7PpIAlXVcAx0bCHiIQ
GLMGt9w0R5vVOyXDhw+HLSVsaytQ1piM3q6NrktuduUU5aOs9Mx9JiHUcEFPt+WA9/ZU28K0gJBO
hTnU56uXtju3v2s2JMBfjCT0Qh4PtGQVCCIaNSfZJxAjKk0ZhCQOaSUtgpfusausBCAFN5D3gIQA
Ed3p6J9XH5bfRTHzY+3Z0UPRc/1Q1hgnlv27np6Fzc7s13z6VuNW+hOirE+nvkCRBNfwW0om1AAT
zMQAmgFz4MH0AIlAmhtAwviNZ7ITPjpjYhAv2SZwdf8JHZrlLIynl5Nl+iv8mC+J9BOfFJCm3X5d
VU3RhCRgrKT76rLzYh2746Pc3Urzlq50oVvOuQFOJJJJNm2wkkkkmaEIIqEIOQeg4oJQckFZBkGO
WTJdUHWEemNw6o1n4xClSvCUUWq7tkM22UzbYeDVMgFmZxgY8Ez2oy17NQSv+uAL+4vOFo3TfDxi
rK5HW67AW6l2YNAE1J97oNeeeIh+CXppFRXIebrYhak23Mp8cRB7yeAT65s7wsyLsINBq2klRECW
VsoF2SAHxpCHhb0d2+vt3h3ws5HpmWhWCFiB89zxEzay3IC1ovgGKIDfUvRjFtjIFm01LpGMCAkl
C1VMTvtAS5m8vLQQQqtoErO1rpVHSlxcmNjGNMYxpBRVda3E6Y3QEpSEWxbs5g49yYorY9GubSKK
xWQnrAgAZ6CM8b326M/e8IeTIuFLPLz7G2227WKlKN2lK8ryHgDDVatqFFUIgIVGAYoom3ZIUVi2
6Z3zdXTQQEK0iI1gJtYPwMHgAIVhkiQiB2bZkIkSyH3e3c1wOrlJqEgGMIQhraEzG1M+Hpy5MnNV
HZCBCS+f444sKfuX22GwPtTpTOBQ2kEAIQo7uOO3j4ebxgIUqIeghQcei9z0d88slcMSZ04Wr3Z3
lCCEViHjqE4oDu1JqSyrF4Xq2b2vic6tbo1HPznT59EklIae2/WQTTMUm/UrJCjt0WrQ9W9DmDdh
tiKBKpVcuFCS1OfYshjpBO0Bvh3QZaVjEHy7pUexgAux6wEI+50W5dFdlqmHyQXN+GqiFt1ZgVgA
rhLCENFsKUFQ3xEZwKV9mNytgEJHoOKYdryJaR19C8SPSXigTg3LGCBtwa5c7dlWesOsEOrTjy9b
brO9r3xjnrg5RNs2SNbeAw/f9hdkopDFeDKIBREJa6ygXq6tAu6WHTFJVtB8H1gRrHu123ush8Xc
kzGk8Nhn1+pEjVCLuRW6fJWmOl2VQ30H4Cux82NGjFTOisVsAgtW66L2UaSUwEBbGEpDdaWLyRhR
kI5ujxYx77nq1sXm94CIwCAuES3CAy2Q6aunKk8zrzKk45xJ9QECKIlszvYhKTx73UiK6ljDGgDS
AWAtaHZBgoNwythjBiWxmmVBp9iBTc/l3QtWuMbM7ZaGaOXCIkYNSzyzIiLWA8dJBrCxPCMbaKqo
RWWd5TigCGU9lGkJhoAJVREVXLKAyglrEFImZC3KXpAmPc61ldCJWHB8LAu+7uWhsrW2krWnRhTF
EMyvKwyq6LInaRPwZgggsttkBAaaxVzoaQNqjx63prOOjq6sibRlAM/JgvfyU4kvkabo6s6ZhhK2
F6lbaiY3skZTg+b6UhJX6UppNmk6Iy4zDF6Uve0Bt7+/rQU10r6PoEERBVAqWOwaUpSp4VHw30js
nsvresmGqOSTQbnuzbiRHroeu+/KN91YvozelP0cqRxgSkNJpGbE06WNtuYiIiIiIghER3hVPiww
wR0ims63sgV3cXrvqgzUdRCY4ZXdGU7gVpas5lukU6uzi10Sc9ZiBGtSilsoqeyWWUuzhv1YGzFe
YCJTN8EaVMMt0AygH1wJpgCcOiFDkxAA7ujf8HR8urASOS+STwhiryjmAHIT1xDKOLjNfgftgRds
mCE8EHpm191LoSrfrK11SLpe89OUm+AwywrJUuSJSdauWMfJfbDTBRRlSxI0j9zDOYZwlTmNUwc+
DFvhwSPoawmmR2krcao6tW5YssxkC4mCODqkKX6ktB90I1Q0ABYu5NQ4mXIu84SNgbOeXFGuUwhv
RLOZZPOu1czQdW+DGuIYPLuxKWU0B65JOnNKx8JIlSTFEucZjMICNssrNOyTK2HNh6zScezouNjD
TNddZZgT5BmTXXLcFduGMnmtcMpVxcluSN5hJSKi2qIzRV3UU4te0iRvR99BsT1BSTcNNQtnG6K9
NmsACABOdtViKs9WYVKcZNiAIZR3drVwY2BEeTh96DdYBxAkZMqKvzBLEdhxJlezE50ZJAGTKlTg
lrTV/WJykavEdf5hPAX73Fxj8XqlMQ+EU5ZkC3+dPP9TEYsAg0CUSIQTr/vcP14o8LnTB4h7YmlH
yXTb+K3FKRLJmIY4j/b6EjpE1oSOkbdvi27PUv27ej0xI+A5vdfke1n4dXXgVqBcezmUgxsJ9Iif
oQxkArq6SAVxh4UuXtcr5uanN3ObmVJbbbbbbbbcYljWe6+y+eed88/m05atY5eCK9qka/c3IB6h
hR97Dk5LiVJqeCmQhzqjfQwdSlzXOGUCHNy6iZt1SlBMBCYq64U6XBTiLliP4kJI212qEliAg1mp
kKUzJjwAjPHGPjmalIDdG21RYuUUTxWtOViY3dRUSgEXwkE/RVqNBIRomjBAcDIq+6IJtQjYRW2Y
rdBQuW+XEn2SZVgsK69FWxl9Z3edzHezA2IR8idFofNsNnM6sXAJqhd25tgIiahv6t8188M46Obd
NO0Jr4ph24utGp3eSV+MlwkB0nKmDyPI+vfV710797wO0IBWxoL3U6bV5DHEcvML26jk93Efz27T
17FINC5plgxDvdBvH8HwOzBzN2TvE9MbM5aezp6bDJSUHLYU6ik0LO6f4zZhpgwyJQBRczQIWwMi
ci8hRupsfr0JilWTlBOjjHNMxgW5ItDeCXJEulTWpYuFxENMTJXvmdRXfQqptoTMSH8kTDJT353O
tSCvecLKyIxAkMewwiN8NPGt457Iqyk3WOMrQwoAIcNeOsN9hDnAzsAIT/T2eI2AIcNqmeJweNye
g22222222xBwk6OLsiWE7ySFxblDskYdskMYuuGJRd/O5hMBCZIKwPPQXA0U8D1VUQ3DpghclP55
4HB0PzWonA7tjMo/CAh/4BDxuqo6y/i5har2BZ2ZynQ6z35tqwd8xTyGypjBSBSMxDiJvOYnBlQ6
am0BC4ShkKSkZ6DWAhhn8WK5dhnmTuDURIUkpCKZTWZoAQrACFOM0bplXZIGTssNBRBkHK48wUOb
L4JLKZw9hyZjgU45u9hyIUrA1z2cVxrGIGAgN4UkHXBPunvOS3FYUTlQ8sAeT6RT5YQHTwL8Rpkc
u7aLr3vMb6gru8bBAQEduL0mXB4qQ6Hh9U94v2EIdHp1HV7MnWiKf/F3JFOFCQHKRKJQ
--=-=-=--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
