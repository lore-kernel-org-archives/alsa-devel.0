From: joy ping <joy@pingfm.org>
Subject: Re: What is the current status of the alsa sound server
 (signal polling)?
Date: Fri, 19 Apr 2002 18:40:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.43.0204191824460.7475-101000@localhost.localdomain>
References: <1019231568.20499.5.camel@meowing.memh.uc.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-819110623-1019234421=:7475"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from audio13.medien.uni-weimar.de (audio13.medien.uni-weimar.de [141.54.172.33])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA10312
	for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2002 22:18:09 +0200
In-Reply-To: <1019231568.20499.5.camel@meowing.memh.uc.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-819110623-1019234421=:7475
Content-Type: TEXT/PLAIN; charset=US-ASCII

i think there are two share devices in alsa-lib or with very similar
names.
1. share device
2. shm (shared memory device)

what the share device is good for? i dont know, and it doesn't worked for
me. i think i tried it only with the current tarbal and not with
cvs-version.
the shm-device works in conjunction with aserver i set up a sample
configuration to try it out, look in the html-file attached with this
mail, but aserver doesnt support concurrent streams to one
hardware-channel, i got an error from aserver trying to write to a
currently open device, such as 'device is busy' or so. maybe depends on
the souncard-driver, dont know, didnt had time to look into the source.

____
joy

On 19 Apr 2002, Ivica Bukvic wrote:

> Thank you for your reply. However, a while ago Paul Davis mentioned
> there was a "share" device that could potentially be used for this
> purpose (see:
> http://www.mail-archive.com/alsa-user%40lists.sourceforge.net/msg02201.html
> ), but I am not sure as to how to use it (and whether it is useful at
> all for this purpose). I also know that there is a framework for a
> sound-server burried somewhere deep in the Alsa code, but do not know as
> to how complete it is. But, I would appreciate any info I can get from
> you (or anyone else regarding asoundrc file), as well as additional info
> regrading polling abilities with the soundcards that have lousy drivers
> due to lack of documentation and/or questionable hardware and are
> therefore unable to provide me with the hardware mixing.
>
> Thank you!
>
> Ico
>
>
>
> On Fri, 2002-04-19 at 10:03, joy ping wrote:
> > hi,
> >
> > im working on a kind of asoundrc-mini-howto, if you are interested in i
> > can send you a pre-version. as i know, polling is not supported with alsa,
> > and its not configurable at runtime.
> >
> > ____
> > joy
> >
> > On Fri, 19 Apr 2002, Ivica Bukvic wrote:
> >
> > > Hi all! A while ago I was inquiring about the current status of the
> > > .asoundrc documentation, as well as the feasibility of creating "mock"
> > > devices that would allow polling of the audio i/o resources of the
> > > soundcard whose driver's limitations and/or hardware limitations
> > > currently do not support hardware polling.
> > >
> > > I am just wondering if anyone had any luck in figuring out how to do
> > > that using .asoundrc and whether that is even possible at this point.
> > >
> > > Also, what is the current status of gstreamer in this department and
> > > jack? (I tried artsd and that one simply doesn't cut it)
> > >
> > > Any info on this issue would be utmostly appreciated!
> > >
> > > Ico
> > >
> > >
> > >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > >
> >
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

--8323328-819110623-1019234421=:7475
Content-Type: APPLICATION/octet-stream; name="asoundrc-howto.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.43.0204191840210.7475@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="asoundrc-howto.tar.gz"

H4sIAPpDwDwAA+1abXPbuLXO1/WvwDqdyr4jUpLjJLe+inYcx9t46thp7G3v
3s5OBiIhiWuSUAnQippJf3vPCwBSsrzZue20X4gPtkQCBwfn5TkvkDS6LtMq
iRZ6ZXW8sEX+5F89hqPh8MXx8ZMhjJcvntP/kfs+HB4dPxsePRm+PH5+dHT0
8uj5M5j/7Pj5yydi+C/nZMeojZWVEE9+1uuvzFOV+Xcw9O8d47e37y4ne+O3
56dvJuPbi9vL84l0NiGKrMzYMMYDfjUe0MS98evrNz+K178/u768/vBqf7XI
rNoXt+f/e/tqf5rL5G4f5rwXp5cXv796tZ+o0qpqfzI+O7+6Pf8wGb8d7d4E
nu+Nv7++uhU3F/93/up4Mr6YyNoudHUiQEFimZXz8eBiMn79YbKXSqtOxHAU
DY+jI7Cj8QBXAotulz3gAE82mgB1kVmx0tWdcZvAm8BBZoRdL7NE5vlaZCUY
RJ6rFD4Ju1BioQsVpVmlEqurtTj4zdvrd+eD2K8+FLJMkUTCq2aVLsSgNtXA
LGSlBjI3kv7EiS5nMfBhBHzVYqlNNs2VsNrvKaQwa2NVscpSJXB6Nq8raTNd
ilkGU6URA2WTAe/tCc6AAyQpI7nM4RQ0H60adppqu9hByYiVqpSolEzjPZrD
T4FhUWrbEsJ0TaQFaEEXQICFtNa1WMh7Yj7VKNtCljW++jYIfbWApU5I34nV
QlqUEkydaw1i0tV3jSpsBqcvQUulrkQQrShVBhqoRBAfUiiVShURYM6AhWWl
l6oCvlDDsSBRBlEYYRa6zlN6KVZAUdfAimVV6BKWzTM4igE9C/XJVlLM6jLB
pTLP7Bo3KOQdSAvWgf2ZvjCyWOYK5Kki4OoegIH2AdUIOKUUuV5FuVqpPAIx
zlUcZGIU0W0ZIVpYOC8QM5lBrmbiGWwKFrhENZ4wgdeT92fvhKMxHryejKcV
PX538eZi1/Oz28uHj4HSLWzaIoVSrZTxBomSBQVXOCVK1X2WqANzGNOKQkk4
6Ps6N+pMp+qdTuucpJyVfXQYEHVlSbB4MF4Mus+SBdhLmaKNpdk8A+OC2UvQ
AzoPiLw0sGuB1nGAxyY/hHcy13PkpzhELSBJ0IFB7wBl5mksriucWCnUgcLl
FjQFdgxktLFAhmkcCpPN4ZM4IPek0+VZqaKsPGyxgO+QhgYCnk23EF1FonSm
a14ul8HCYvHnhSrJKcjteMJM3usKYFEsc7lWVV+oeB6TyfoHeB5Hfq6BawsW
Nl/A3o3gY3EqCl0hGqDJWZSpSapsSXoDM0GlgPrkvcxy4o8OgZRPL29Oo9P3
F1Gqk7oABCZe2ZTg7HdGjE/F2w/n37/aX1i7PBkMVqtVTDgC/vQzmEasqzlB
V5Rn08EyKT4u83oO2EBpwv7k/7VsPDhlIySjzZwHStbAEqwnIumQFcKhi7r0
kAanTbPZDICrtM60wBdBxkCbUAmeqVwv7dfWIrpVJBITiwvEYzEFtecZOLkE
fLGIFE5HU7BRUoDJUAGx+BG0jBCEJkI89BGWAYEbqn20oJrsEejP2BzIxxNZ
peAIuCMe3ymZLCcBErgmqO5G/bVWZQKi8Pt4P2LcnbJRZByq+hyGZg00S/hX
pSuA9MisSyBrsr8BMV1u8dPng+O+xbI+Ho622EHrenBAFItkJ0dHa6gZv/lS
gxLokDeMMn2ChamykAp4AUHA0zNLPDpREC9j4L1Ssw3DBLWYpQSPgA+xrAd/
n8/twGZFlgJGO4P0X8cDOUHLQDhXVUlg06h8T7a9aQbphzcRPE5SV2QkzLoF
qaJHP3Cxr/kRMoKOsE/gHIwekRdQ2csE6WLcASmXcxIzo34J2EpWTJBHMdAZ
PLIJyK5LhYjeyN3FmAUi/GI0ARqpssDweADf4MQuwWlijUsQMB7Crj3EkcUK
p6lezFrHqGh25RbIFAWLzMdHhj3Q5lIlGezSANhDexMHDAekIJODtRxSlkH7
wdFlAV7mwzQx0s42ZAJCMFskIwAZCFFIprdYnQz7wx4S74F2ZZ3bXrynPlHI
Jq2Ns4lKWA4iyoRVxsYreS8iTSftM4XxIINUcjnZA0IsJIRtH0KBBn0X0RvB
8wOdsBDFVNbFFEKTkDO0epiJoirBS1C5Q/HKhYqsavtQHwOzBu5wgqmnLhTs
+eOTAtwa/7aRMy9txN2WHqoXAyYwMuoP4z06GFK7U2sAvbQRGS3j3Yise75j
w/Am7Mg4BYpzMXiIW2F2F7bbMDfeCiBWunSYnBK+5pk0yjT5CGjZWRU4MQVP
wDX5yTkK7Nfy5swnTZajNhxOVa/2h1CXiLEFJQr4l06AZHx1+u5cfB4P4Cs+
+m05Ncv/oa8wdUBzWytIhIsVvRebA18/FX8AxFHkAo/SICldXN0Obm4/bBFi
Gmc4AT0BzZht6FFif2GR/IQEdxJ7w/piMuLA62t4+DjJoOUHVJnkTbACptoX
0chZZAOTYado5Lfye/nNiFxRyOVHVbhEUry+vr70O/JuqiR6OE8081DrlR6s
tIfGrT1a5/nyS8qFv0gePqBvzyhqEFhQGKfSwFtfsPkth2WQBGtlm8OpsSrN
6NnLkfgMifjl9dkf/vjD9e35ZO8bqGiDCV1wSo7PiMxw45GTcPMQEL9FSXzZ
GwPKoF/5gO3RAVyh8RVERaoykEHRc3z1XMDYoOhU3MI2f4o2uG3xsUeFE6xo
Ci5pWnmu4EJNi59lcgd59F9rqKUZwzASNj67neDwf3RzdATyBpdyOCLpRqKM
GZzWEI45j0PcyKEQczpJbP5PqmTz1Cz8LdRxBTQXqIjWUCNgCbKGirKiKO4y
4RD6DNU5LiazSlChHgF5UgNwvByqCAEFz9rlpG5SQkXu1OU0mKBuiQAzcZoa
mxz1+VAOGeKh1/kOVX9xJas/NFVavLsP2HhYqFlBWRDwDNfY2FGgHJrySO1K
+ky2oJ0k4DWJKsaEnLI0NCpKQyFBwqyxBBynGAoQjyUUFNzNfkSwh4dAhZqe
KGo4Z0smrqdDPLdML5rmOrmLBeSEkJApWy/hYK363iLEsXVChbtyPjZVYKIZ
sB8/kO/RA+G2JUsWhuTF8fFoONwpZcQQnPLRcfCAIJkszmByrAbYeSe1Nkpg
C4cPUKoV2GcCta0F2RzcZ5WtZX7YAMfJToDYhIgNJn8BJ5ANFuFmL8kt9Tkd
Qa9BVR8fxyNx9/ZvrXYL6iDnihrsobEu8gYoKGY1HC2Rvo6i0oRRyFB9RA2j
sGFrL0KVbL6wrc28xrfSV2r1LSki6RlXQu2CKePy029jKGHW3BQCuzdYhift
I7UiDtuRbFf8n2Cxzl1FGwhmjIPe0AkX2G9cShTSn031hckbectT8b2uCuxc
pT+DvzCuklUJ592Qp3zTzL6hZwTIB0YRG2z4h27RU8C3jfWftzIlT6PxQDdd
0Jlgu53TMWvEbcPk1ka88rP48ujKHZv9ZcYHhw1/2l7iXoUsplQA7sYeInbv
12WykOVcpfsNLXwCmZ/BlOmnTVrh1a+nRrbRUGpTo1e/ktIX9x+bl+rjUgOe
rhv5PuXnwj0nw/XOKSynznNVKm4dB+Z2jadEFb0A4DaUEX3RA44rOVf4MdHL
Nf5Pa4frva+QdGtPsD2JZ6UynB5hHcwdRC/br5DCvU+42cTZW9CJJGdbZhyz
U5BlVv6a84ZTnDQffWaoLDL4K1lzwjohHp0u+oAJiXK9rEKXGkHH1sBqBDVY
4Sg6FX3epnhL7Uzss3AmPs3SrIDoQz1tQhaqfvXsa0ILQvovYcJnV9QehsVn
Z29Pr67OL6GKaujd+Icfzk8vHT22tnuZ18DUMB6KOI7FKB42pL5s2O2OCKLa
SPtLKc6zr4dg7/2jFx8vz/lROGQ7So9eDIfD3Umgi9QOrJtg7Vrw7e0JQQMC
M3l65kP3s0e3gBQegyXmQHiPBbmWqzQgFF/4UHz/Rmyz0YTjCxYfRqoVXraE
GZxfYxqZ1hVu4IKrj4ruJYvqxMmqD44UUI0jq5sYkcDA9kcvMHbHqCIOj3Sd
xKyGPgCwMNWgSs397Oiem+iKwzc/bfV/wK18n2s0cdcxrsGVpsTzoh1TTkRv
A/Y8Evmjyam+d+GwXYXQGg6wLbChLCBYB1CgB9yzAmHEQbych4cehsHYvxHQ
HeNN+tjqiyAzvcil+cG68LvX6cPMcsuk2P7R1hklvmGQiNHdhvF/bzwbQYY1
jEeP2t0CbwnB5UC8KuUbMqO9Lv05iBSJhMrkkIowFNI9iut/MRrxHRLZFixI
gh35fMvn7ODmEP94Ije1mFbmL5cCUEeBAr7IZdg2dKKkmOUaXN01QfgSZeq0
fK/zumj6rY8SrjCyIjUQZQSoRWJrXXo1JdiqyqxVWNmdYK7spH1z/cOHs/OP
DhfjN+c3txdXp7cX11f+mfjT9eUP7845e8b6slEdS83Zpve8IV/3ODmCBpoX
rVPEqHcvNj5sRBjMFtayBUfeidsTOxgdbu+zY4a07T19Y9nJFhwI7Iz3c/D1
oATfNNN2JR44xFdHTUX+fttqV8qFmMb+EJy2uHWd/uY0zezWlLYAm7rXZeom
XGdSRmFXjejp4jIVmm9IGntNpOEy2d2YgEMoHQE4R3T33t9dzAC1Ht5urlO5
xtbGDBMprDnaVz3kmAWkEJk3WKYJJk1hvhTpfRrZSiZ38CyGErtdsZgaa7Lt
XwlQd40d3F+JHgXq8ILa934GCYHhwd0AeKSMuUmlOLmaOiiBjGkNiTwkmY5C
n9nvC/rRREoSLLJPe3vjt0cT7l4ZGVERZlR1jw0EvLVFLdKCqFCAsWtXuY4H
sCpcr/egzO0JfyEZDePfIRSrcPfhuih3GWVEorWJRyRJKQYJDX9tgCGMZkXG
Qu1cgBEQR/7qkLo7OrlT7jcGV9e3eF8Sfu5hFJ4Oz0vdG0eD7BDvg/h8B0Ak
AxhLyx4kgagYxUbV/jHLIdsCKgvlwKpQ7eYfG5zbK/CbQUKNF6TIiLuK275z
w25dZmN2EthgTjdvg/0JvuALNlmuV3LtG4n0Kxs6nRX10nuYF+UJXldxeWud
rzGwB2WC/dlK547v1i3nRj8r1MpNW88sio87+1kUGOGti4u8Ff+jBS7js3lo
cz4lDYQAhLf+OdWVzq4ei5NMNG7RfsDMAp0+1xA78ZNjiYxE9Aa2WPJvhPBJ
79Ft8BZTSbJS6Sys6f1iphH6hniR7oy3JWb3Q5g8MxicrI53ynQraUZKv4Ox
A25BlbmSXpXsueyIIqjRbGox5On/rNq2k/ld8gKjpDxoQ5/BMyi5aUkHfwVT
lyU40bfBWK3/YYe3R3fT6ZaExM3bqHuOTYodwsS22Y7zPOyVuXTJX36ifgl1
EBTQc6v0Ow7JA5+lOz/6mjrbjbuggF9o2slGNtN1uOqb1lnOGN38UCyIwl+g
e8AFfPg2igTe0IOPp6GhwD8us5/skZVzzKmeiwOHPf7hNvociigiDq/f/Ig/
RaSfLv6nf0HZjW50oxvd6EY3utGNbnSjG93oRje60Y1udKMb3ehGN7rRjW50
oxvd6EY3utGNbnSjG/+Z8Q8eRm0eAFAAAA==
--8323328-819110623-1019234421=:7475--
