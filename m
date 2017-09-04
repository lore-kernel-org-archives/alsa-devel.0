From: Mark Hills <mark@xwax.org>
Subject: Re: "alsactl store" fails to save Echo Gina3G mixer
Date: Mon, 4 Sep 2017 21:23:32 +0100 (BST)
Message-ID: <1709042113040.5915@beth.localdomain>
References: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
 <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
 <7ef92b65-ef37-1a68-b1d8-e3a747859200@gmail.com>
 <e59f34a8-0999-c552-00e0-3d20a0721d3f@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-669754955-1504556575=:6108"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 55F5D266D16
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 22:23:38 +0200 (CEST)
In-Reply-To: <e59f34a8-0999-c552-00e0-3d20a0721d3f@sakamocchi.jp>
Content-ID: <1709042123230.6108@beth.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "S. Christian Collins" <s.chriscollins@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-669754955-1504556575=:6108
Content-Type: text/plain; charset=US-ASCII
Content-ID: <1709042123231.6108@beth.localdomain>

On Thu, 31 Aug 2017, Takashi Sakamoto wrote:

> On Aug 29 2017 12:46, S. Christian Collins wrote:
> > On 08/28/2017 10:33 PM, Takashi Sakamoto wrote:
> > >
> > > Would you get output from below command line for your Gina 3G?
> > >
> > > $ amixer scontrols
> > 
> > The output of "amixer -c 1 scontrols" is attached to this e-mail as
> > "scontrols.txt".
> > 
> > > And typically state data is stored into '/var/lib/alsa/asound.state' as a
> > > default. For my information, could you disclose it if possible?
> > 
> > Yes, it is also attached to this e-mail. The asound.state file was last
> > modified on March 26th. I remember that I used to not get the error when
> > using "alsactl store", so perhaps an update caused this issue to appear
> > around that time?
> 
> $ alsactl -f ~/asound1.state store 1
> (alsa-utils:alsactl/alsactl.c)
> main()
>   (alsa-utils:alsactl/state.c)
> ->save_state()
>   ->get_controls()
>     ->get_control()
>       snd_ctl_elem_info(info)
>       count = snd_ctl_elem_info_get_count(info)
>       for (i = 0; i < count; i++)
>         snd_ctl_elem_value_get_integer(ctl, i)
> 
> I guess that 'snd-echo3g.ko' returns value greater than 128 in a call graph of
> 'snd_ctl_elem_info_get_count()', then a call of
> 'snd_ctl_elem_value_get_integer()' hits an assertion in the function.

This sounds familiar -- would you like to compare to my post earlier in 
the year (for Layla):

  http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/119125.html

In this post I made a misdiagnosis that it was related to my move to a 
64-bit userland. When I found I could revert a patch it looks like it was 
coincidence.

> A patch mentioned by Mark Hills (a commit 275353bb684e 'ALSA: echoaudio: purge
> contradictions between dimension matrix members and total number of members')
> is fairly valid in a logical design of ALSA control protocol/interface. In
> detail, please refer to my post[1].
> 
> Some of ALSA drivers for PCI cards produced by Echo Audio potentially have
> problems which I mentioned in the post. They can cause buffer-over-run over
> 'struct snd_ctl_elem_value.value' in user space. The drivers should be going
> to fix.
> 
> I wrote a small program to validate dimension information for your card[2].
> Would you please execute it? Like:
> 
> $ gcc -o ./test ./alsa-ctl-dimen-check.c
> $ ./test /dev/snd/controlC[0-9]

In case it's useful, I've also attached the output for my Layla 3G.

This is with the patch reverted as that's the kernel currently in use.
If it would be helpful for me to build another kernel, I can do that.

-- 
Mark
--8323328-669754955-1504556575=:6108
Content-Type: application/octet-stream; name=layla3g.txt.gz
Content-Transfer-Encoding: BASE64
Content-ID: <1709042122550.6108@beth.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=layla3g.txt.gz

H4sICN+zrVkAA2xheWxhM2cudHh0ALXdS08bdxiF8X0+xSzbRdQ5Z+4sS1Sp
UpEioWZv7EkYxR4jY5rk29eEcllEyHGfs7MR+H2NYR5x+ek/322m1VmhN0Ux
fVwsx7NiM30dd4e7q/Gf6f5+ebh9e3f18u682BxuvT+/KN6vF9+uFsvPxYft
+m4z3j/KvBq/Przb/tvN4d2meT9++v6Iy+3dvD/Mat/MD1N9wtS/pnkszhc3
+7vdWFx+mfbL6+KXtypXv3/49Ufjr7bb9biYn8f3j9OrU6c/Pen/Nb5+Hr9c
7FbHTP/w99vNuB93t/9NPmqgHgc2Jzzfp4lHvbJDe/+Y02acb6ftfHa4UxTl
4WUu6v77bd2/+N8/70Xh+7c/7daesNvFdp72211xcf8BP/UF+MMtD5uVL7Ys
H1fr8NVErdbjq5labcBXq6jVVOK71dhup1yIX9+twXY75XL9+m4tttspF/PX
d+uw3Wp8tx7b7ZQovL7bgO3GR0FYFRTIAtYF8WEQVgbxaRDWBvNtEBYH83EQ
VgfzdRCWB/N5ENYH830QFgjzgRBWCPOFMFYI84UwVggHfnTACmG+EMYKUfGF
MFaIii+EsUJUfCGMFaLiC2GsEBVfCGOFqPhCGCtExReiwgpR8YWosEJUfCEq
rBBV4NdLWCFqvhAVVoiaL0SFFaLmC1Fhhaj5QlRYIWq+EBVWiJovRIUVouYL
UWOFqPlC1Fghar4QNVaImi9EjRWiCfwFAitEwxeixgrR8IWosUI0fCFqrBAN
X4gaK0TDF6LGCtHwhWiwQjR8IRqsEA1fiAYrRMMXosEK0fKFaLBCtIE/UmOF
aPlCNFghWr4QDVaIli9EgxWi5QvRYIVo+UK0WCFavhAtVoiWL0SLFaLlC9Fi
hej4QrRYITq+EC1WiI4vRIsVouML0WKF6PhCtFghOr4QLVaIji9EhxWi4wvR
YYXo+EJ0WCE6vhAdVoieL0SHFaLnC9Fhhej5QnRYIfrAv7pihej5QnRYIXq+
EB1WiJ4vRI8VoucL0XMKgi9EjxWi5wvRY4UY+EL0WCEGvhA9VoiBL0SPFWLg
C9FjhRgCGgIrxMAXoscKMfCFGLBCDHwhBqwQA1+IASvEwBdiAK0cn4iB03Il
34iB83IlH4mBE3MlX4mBM3Mln4mBU3NlgM1xbq5MwDmsFCoDdK7k7FwZwHMl
VguVAT5Xcr0I4OqHawG0XoDQlVwxAsT64WoArRdgdCXXjAC0frgaQOsFKF3J
VSPBrUFvHQHXXDUS5Bo01wl0zalrJdg1566VgNecvFaCXnP2Wgl8zelrJfg1
56+VANicwFaAYIsz2AogbHEKWwGGLc5hKwCxxUlsBSi2OIutAMYWp7EV4Nji
PLYCIFucyFaAZIsz2QqgbHEqWwGWLc5lKwCzxclsBWi2OJutAM4Wp7MV4Nni
fLYCQFuc0FaAaIsz2gogbXFKWwGmLc5pKwC1xUltBai2OKutANYWp7UV4Nri
vLYCYFuc2FaAbIsz2wqgbXFqWwG2Lc5tKwC3xcltBei2OLutAN4Wp7cV4Nvi
/LYCgFuc4FaAcIsz3AogbnGKWwHGLc5xKwC5xUluBSi3OMutAOYWp7kV4Nzi
PLcCoFuc6FaAdIsz3QqgbnGqWwHWLc51KwC7xcluBWi3ONutAO4Wp7sV4N3i
fLcCwFuc8FaAeIsz3gogb3HKWwHmLc55KwC9xUlvBai3OOutAPYWp70V4N7i
vLcC4Fuc+FaAfIsz3wqgb3HqWwH2Lc59KwC/xclvBei3OPutAP4Wp78V4N/i
/LcCAFycAFeAgIsz4AogcHEKXAEGLs6BKwDBxUlwBSi4OAuuAAYXp8EV4ODi
PLgCIFycCFeAhIsz4QqgcHEq3AEVLo6FO8DCxblwB1y4OBjuAAwXJ8MdkOHi
aLgDNFycDXfAhpuz4Q7YcHM23AEbbs6GO2DDzdlwB2y4ORvugA03Z8MdsOHm
bLgDNtycDXfAhpuz4Q7YcHM23AEbbs6GO2DDzdlwB2y4ORvugA03eCJ3wIYb
PJM7YMNNnsodqAZ4LnfAhhs8mTtgww2ezR2w4QZP504czw2ez504oBs8oTty
RDdXjcQh3ZwNd+KYbs6GO3FQN2fDnTiqm7PhThzWzdlwJ47r5my4Ewd2czbc
ARtuzoY7YMPN2XAHbLg5G+6ADTdnwx2w4eZsuAM23JwNd8CGm7PhDthwczbc
ARtuzoY7YMPN2XAHbLg5G+6ADTdnwx2w4eZsuAM23JwNd8CGm7PhDthwczbc
ARtuzoY7YMPN2XAHbLg5G+6ADTdnwx2w4eZsuAM23JwNd8CGm7PhDthwczbc
ARtuzoY7YMPN2XC/tOHXX1bjzTHrnV8v5nlc3x6mf9w+7/XKN2z7PPBFB5aL
3eqYee+mT9N+sS4229VYXH6Z9svrH00dDzPG3WI/rl5+Op4Gv7jC3yw3x8y9
XGxu1mNxvt4uPxeX27vdcjxhbvPzT/jyt/fv/vzjtOf7L7k9hPCKogAA

--8323328-669754955-1504556575=:6108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323328-669754955-1504556575=:6108--
