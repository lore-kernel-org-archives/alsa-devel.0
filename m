From: David Jordan <david2@system76.com>
Subject: Re: Fixup set PCM/headphones volume from Master
Date: Thu, 10 Nov 2016 11:16:24 -0800
Message-ID: <1478805384.466181.783885401.3F81262C@webmail.messagingengine.com>
References: <1478537979.2123627.780087305.7503B79D@webmail.messagingengine.com>
 <63dfc720-71c9-9556-61cc-9fec629ddef5@ladisch.de>
 <1478554581.3026158.780400457.4CB1BFD6@webmail.messagingengine.com>
 <s5hinry9gnm.wl-tiwai@suse.de>
 <1478802091.454740.783828673.10EC9220@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_14788053844661810";
 charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 360AB26686A
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 20:16:25 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 2898A21162
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 14:16:25 -0500 (EST)
In-Reply-To: <1478802091.454740.783828673.10EC9220@webmail.messagingengine.com>
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--_----------=_14788053844661810
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

And the alsa-info.txt

-- 
  David Jordan
  david2@system76.com

On Thu, Nov 10, 2016, at 10:21 AM, David Jordan wrote:
> I've attached the patch I've been working with.
> 
> -- 
>   David Jordan
>   david2@system76.com
> 
> On Tue, Nov 8, 2016, at 06:42 AM, Takashi Iwai wrote:
> > On Mon, 07 Nov 2016 22:36:21 +0100,
> > David Jordan wrote:
> > > 
> > > It's HDA, Realtek ALC898.  The headphones jack (analog 3.5mm output)
> > > (0x1b) is connected to a separate ESS DAC, which takes sound input from
> > > the PCM SPDIF output.  
> > 
> > Note that the "Master" volume is a vmaster control, and usually it
> > covers all DAC volume controls.
> > 
> > It'd be better if you provide a patch you're fighting with, together
> > with alsa-info.sh output.  Then other people can track the issue
> > either with the real h/w or hda-emu.
> > 
> > 
> > Takashi
> > 
> > 
> > > 
> > > -- 
> > >   David Jordan
> > >   david2@system76.com
> > > 
> > > On Mon, Nov 7, 2016, at 01:19 PM, Clemens Ladisch wrote:
> > > > David Jordan wrote:
> > > > > I'm working on a kernel-level fixup for a set of hardware
> > > > 
> > > > What hardware?  If HDA, which codec, and how is it connected?
> > > > 
> > > > 
> > > > Regards,
> > > > Clemens
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> Email had 1 attachment:
> + alsa-hda-alc898-pcm-hp-dac-vol-test.patch
>   15k (text/x-patch)

--_----------=_14788053844661810
Content-Disposition: attachment; filename="alsa-info.txt.tar.gz"
Content-Id: <1478805380.466174.e67c56ee46cfe67f3ac8eed8b2a5ff4f86e80bb0.70B8D19D@content.messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: application/gzipped-tar; name="alsa-info.txt.tar.gz"

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
bFDUwNtkvs4vgbEFHjZiratvqnVb1oWUqc01IFldiNUg1w4Tdk3idjglc9YM
X1LFTQudVOVE4p8MqCVl8p68sC15W3H/Evi2i+Ju7MX9E4q7tHY3X2hTFjv5
P5pRWVezwPqA8WDyvPlvoHPRo3u+bolrO3OLWiQmWkR2qEW/JGpUoEXyMi1a
v5PMHL1Ptu352xsOXdkDlDIqJDZznbPCHuDrtXpSs0Q3Efrm0kkI/mv/f1Ed
oy+XXQQFEYwLlFcB5a0lyhv61C/T29oKvRUJx/3bZe/zqI4L1Vf6HtS39Uz1
3SvXd2xzA7UD7N/S+C7XO2Wvd3u9ewO9G2/HXBdMLWzX+ftxdZzkdTw7UrFS
0VcMZXxvmq8GDiojdKn2k9ex9st7uOqS8Up52XhljQt03/EsHtTUlg0DR0OZ
6w4C17AkYVlsRdw86ZaMm3euOoP+2mN0+Y5Wq4xpW+IJ3dHkAiY10Dcpcef5
qtVlndHLk86a+ia9dBxzNxMOOKnAk3KuNuQ1uFqmc3/yGizitaYlaqm6HGxZ
xCYCA1M2ppY+tZgZt1SbTibHohyXTp416SGKGy6y2uqU71ss51m2tCeZftts
aQ9KTxmL0p6l22Zp/NlOsIjSTnFVYlzNfcOSgBdfAp49ib/ESPxJv6ERG/vV
IZEWieHqkPAr1vN7vrPXl2CrN/S1e9Zf91NWvPApq0YxlqWyT1lJwaesrC/z
3E9ZQeEyGhW9pxSJBX3Xn6Xiss9S4y9H09/9lfg0TYn5NHLlJKihXrws52Sw
2CX/U34Q1jvtFiSUMo5fi7kWrVrQTQ26cOjrp0teJVB3sOAMErkObdsk8bAj
roc+NlsvwKtTyiPcdDVKkV+47rRPriedbgxqscus/BKZibBPnP7c8lnq9nyG
1hOGcu/6DfgJvuU63vSmvCyfMd9u1SUvqrob5c5X3Y0y56ru0rzFVbf5U1dd
8WVVt3zGfrvqJr5I3TbKnVe3jTLn1G1p3mJ1k39qdZNepm7lU/t7S7EpL8vn
mfe83JSXSum6d3FczMqh7+oOLewA14vXwEe7bidBz18L31xnLXyzUdu8P10P
+tOocyKtZvTCt4vbYN8OPyH4ztim7tn2HLZpe7ZtwrZKhVpaelOyaKf/cBdz
NmhRuBGzIKjuQwX+4PobIsi1bWjnOecJaRwiJMbHYJC22EBV8ICqnqVVw93i
TvCqAporCiCrCmiUFDB7OMHdVeAJKc9NVuZGtZLcjmoy4Oqq/NLy/M6q/PWl
+cnK/HI6fzObn3SllflbS+CTbnNVfoKX5pdXwi+Tnkf/WJFVKmO9r5vUFYT4
ffzENpmctQXfZi0BFjT34dGtsD9Qfl4sv7GlFpkSj9IppVRKCedTHgkGS8r/
IlyDQkmufjmqXuFzWtGW/5X/hOyp2rZ5QeEJANmCgn0QOw70iaoddmqFqyGb
N7UlGyAKQmdw2vlNEH6BC53qns8GRFnQp87Jr+ir4mr8yJSgwfEQSyaw4x8Q
bvMjKW4yJ1TcRn0pFp3ZHwca/vQrG7gezsdBYuYeVkk6BP0b5PdSb2vBJDHM
yADcZN/zUMlaUEk7OhnjJjklI4EqtQOvG7No9vs82lZAaYZQSAiF7IQWOYQi
hlDEjaEIncveycVlN6dRJ53B1fVl7ztSKFZPTDZPVFJBhCSATyehsI55zJqj
AGN+wsutIJywt9lDG6MDCDioHqx1bMuBgIKZKj4o8a6NDrKbjR5wr8d0bIta
vsfiodh2tJXoYbR16CGfX8FYOkjGOTzeb0LMhWFc0Fk/E6m+yyJAiJIQBplp
ytDBmeKBg3VwyPthiqOMw3N/2si55wvxo9/K7zafuXc8PugS/YbBzKWKRmVC
D82L1wqc6ia4Se0kBUYVJLORPpYgFd6U0U0L//stuqk0jpp17RM82dZtCerx
GsSl2AdoFuP32YWy0Cmd+IBQ8HKpT2f+apzhN8mcSXUT4l8/EkMCJpPbODkv
fo30xRSHy1K+I3rlJroBVWQk4COMY4mV0VuWvphe8JqX0LodGsV6fRWRkCSP
dSmBRWmLiYu+IfrTSPNMV1+NVomsXVOl2lEdb1BTc+lLaQ0+Zyqi+JnqG+1t
uBFXODNyPIhIKdHlfHQxhcFYfKFAN7cQOTuwjLOLW4DuCodSRWa7Uf1pNDnU
uiJ61ZBeNab3WSoaZWLUNvK6GkXWAetmi6Et4mWWdWX6Yio7c9+unM19yles
FBFLrbnJxpN8asLbQVf3+JDNQWyV0YVlPB0k7frfImsd5gJvtCCuxDbYtsNl
Bc6ibk03wyccuU7DjYNWe7jxuYIpJ5eggyAs9HOXnBq46OEWLEQqc3ODZUaR
m0sCNxf+itxckRS4uWVe7m4bq9KGIgJL3gasuCuwvCdleIrqG2VjDULBAQt8
ddUR6x79n/AuxPaIsJd3+kSBPtpZ/396l/DGVCepLPmNsw4gxb1izOkRZj5N
9EKCF9U2TdAqXuo7RWWLlNGBC10F9ODqPs/8jm3bi/rnV70vHBzkmUMOkT26
ijUF2IG/xBNrY1O3EDjoYj18VR7ZgRvsMUIj80r4678E9hdRKW5AZTCrnaaS
naacojN8XZvSTxcXp73OeZbSLH5SKX6lm8ilEcQp7PBbCSEVG+ESBWWJrW1C
7KI0JorhpcURvW9THvVSFEt2k/sRK0VjfSLfok40y+tszjxHeMSTxhsg0ju/
Putddq563QQXwh4hlQl0RoY9DiIpKFmE5VKEC/abfZ3qK5G0uki1Ok7UhYg4
X4OTBHENDoOylLbWo/Rt6i7Bpdjl3MxYbwocw92qUNZpjSPEYkxy9JWb7Oz2
/mnG19M6Vt+ukjWktJKRZrpNknBeyUSctxJhSI7KcpOdPWTg1dWr3FbnN1F5
pTqe4j5exvmVBoGUW+ayNYupOoQnk+Azsv21k6usTWJKk2gLl1O2HcoJudy3
KVtamhHyW7Ph5762JeRy365kBXBaxrW35sLPfW3kXKwh63JHuXjBdiLql9vH
AnTK3eDVx0clqL24Q1GA2RK3lU/DlvroqCm/yGSTnMneqFfdXHSOxHIXN0/J
K/BVTDukJ53LbsYhYivz19O4TBu3DlyxDC5bCOBaisH3WhvMFMu3zRwiS/iw
MR5SGR7x4NIOmVArA54MpuwQer0MejyEsHPuN0pR4Dtz7B6B8va36HSWH7rj
L5Y37kVnxLx230xMt/DsQ/cIuaTfEoyvg1vrpJGTUojV1nLBVgqgsdhzl3AJ
elGP9m2xIwvYRav81ubjOgq9BUzLxwYyPsVihWOrTRIMg7cVCojmXjAKsybC
UGiQ2riHgOAi4a/MVqRRlYQONqmlK2md4FQlXbPv/q9wViecEiyZ2Mnahe5Z
v9odHDqqeSzt0jbsBxO+32tL/czysbD9WMKbX1uS8fqDgkVDCezzHSy+NSt+
1muNoQRk2OodW3uyvsTXHyF8hd5lo8wrkSKseqfdROOWc+TeNhRfN9IY/HbV
GybwF13e5jp2tLlDO7pyPKXQjvIv7Xlpe4v6KteWWtvyMaplFrVA2m/Nj5/7
2tY4fflA3hLjuijt/Yj9Tq9tj9iXz+CXG9i80HcxQC6W2drm69haUjqSmja2
8g6N7TOnwAPhiHtr+1rX206GF4j7rRnyc19vOi2+KO29ud3p9T1MkOeFvgtz
K5eZW/mVzO3idEm+b73xzEnwLKZmAqTUcy31XE89N1LPzRdOhXFdWDGDIC7O
xOQ9nY3nOn4QyktneeSfk/J/Fe/pYxjo1FY0qrGlwHOjeFMfSBvECpo7ngqK
5ekj1XGtqaD6rqCqpuBOGNLC2KKOYBneSPdsWa63RkTwLG0005SRyvaDhidT
FxRXrQk626Rg5CqOITzKjZFzNx351HRG/oy6pmLk8rnB/gRhLoftfawaiunk
kk2Dr7sE1XYpK024uzdHPA97EvQWqY/Gji2Yj+boATDR3T/GT47ieYL+YJiQ
QnVVn2BNn4wc1TDnRghQdzwWJYlxsKiOFGNqj8a6L5iKKmOREEGhnqWH8OB5
xAhr1NgWK8J0QkSZ5ZyCnEczajjUFZSxcRc9q+6T42vC/F691zVqc8I8+sfI
1DU98zKi96AcMeEBNJ5nPJ+Io3tgnmGrqRCTmjbg/7v9BBoujP25N06nrxli
louQxPXTRTJuQuAY5AxsetAnusByjZjIbQtiUjgwEElpkI+9uMoDJ8OkOmAD
P5quCGNghG/b/gx47Mz9kUE1L8j6oIEWqZNpwNSQdsH1vUdgP5TgsYJ4OHSD
4Nn0fF29i5kU1GPBA02wGWgeEezSA0+Cx7b9DlCbOerMEZgigAhHM10TFNXR
Rw44U47iOrbrAwTBcRhRhhOFCcrctydejfFp4gmPtivMFU8Ato4833aVKRVc
RddAp/8QoMxYKSEBA8H+ayaI0nUhJzy5dKrb1mimeDP2atjThFZPM01VsPi3
iyPNNaNHk+2/RX2oj+bozvQiJfKePNV2nhSoLux5ohuGy44KgmfdnI4NX5gA
kk/eaMI0gpXneKY9h26jK5NGKyw9Bi8oM7iZui4Y+pg/B7o5+R3aCdZ8DAGG
hz7rC+2GIFQBTBXqqOdVOcfD7bWquqUDV3ULtMOa6FOvLeBHQlByXL3AD3RP
TmEXwrMHosOzhfAYguiwFCE8kSD9zg8nCE9LFcKTDaIDKIXwkIN0eiX3Ps69
q7l3DSUHBAn8lJ3kRByBnw+TSl/KCs3V76mbZUZpYjb9vsA3vi0lgVqCpSVw
OMsB0nhZ+TOoxGXxpERuuJbafVbgm3onG34KfGPqbHwz9y7n0rfS76WorM03
Usi35SQu4xNJ8SncEK/KPkTWTOpNC749vWHfCItHLbHRlKRb9Clq8doI6hJu
s48kfINZXxd6cOHRBRgci/FcNzQkogdK71BdRCLoVlKY3JLqtyjT/rfRPNgi
FUEbBb4LW/p4EJyR0GxU+C5mbFMycOmRPrWg7dPi4iTckvPFIdb7iHYMawfb
ArKtC0MP6QOLZvt/wY/4MSmJ4CZZXlLHcYwnVhJHBk101+R7MhXjmiqZkFpx
ycFmZBvgSOri8pKCz5RYUWfDfiZjY3nGr4qlGRTdT5VR8F0zdW073EJONXRm
tJPSmi1SoBDh7oqxMugeqoPfFuSTjjCW66R1iyLb2IbQD/WmyPvh6Nev/+Rf
ITXF+PW/kEga0dvHQ/ThvNo5RBiZn8zw7WNcNmFnzy0X30SBll5DPlClaSjy
ppAafUOPzGDV7YcKaSUFiw2phpOCMw4dghDGINYEtREzrEE15RsBBJtRtREI
g47sue8dE5ArtO5VaCrS/z8i5g63WboMVHEtqHB5wSrNNJDaApBM0bV1i545
6VLHy0utr1uqyT+HZ3dWOju15XnlaPq0EhRAaDVfSmPdUrgDB41iOnNz3cxs
owaVISBn8svr508vc2YFiXFBUo20AJGkr9FGn1ljji47g1Ok2aaisyZTvWNO
W6qegepgaVU+DVraJEddEhu3ASfYVnbpXdj4Sdce3zGSbRFXBc8qrFfVdP0K
7Qzb/oLZIiiINNPlN2sl5SfHwD8LiJwCAk5LCZBkGfXzoLQiKETEcoMJhVLK
WzHkzJ5AlMG5VdC8sL1w410kWCcLOr0zEx1A36MCfbSK6x2kZFWrNWoi6DtT
CkCaNQTHbGFhEPCB1JpyQ2w1cAPIk9sEf4RmxgEradru8fvhVefqevge2eA8
8/3Ej987rg1uMx0xu/wehW/H7+cWb5gsCoHBTv7gWbhV8Ivh/3Tma2b0W5nO
qedXPHYsnW1Vq+rMtU19bkJhunbcrDVZe2kev4+wgO6GCz7K+5igZlOSmxkp
hKsasysWV4gBk6PoJTBQKZmQQCYiTsGsrYbZ3AZMksCU6y2yCqa8DZhxg9Bo
SPUWVKP+4L4B3ki3e3lycf75w3nvqtv7NroegHI8GA640x7mZueOWWCL7YkK
2v8ETt9f9tf+2l/7a399d9f/A4sjx/gAxAAA

--_----------=_14788053844661810
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_14788053844661810--
