From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: Player Thread is not woken after period elapsed
Date: Fri, 9 Sep 2011 14:07:25 +0800
Message-ID: <20110909060725.GA21124@zhy>
References: <3CA6C6D9F70D314CA34352990B57DA1507C420F147@bgsmsx502.gar.corp.intel.com>
 <20110905105253.2787b91f@infradead.org>
 <3CA6C6D9F70D314CA34352990B57DA1507C420F15C@bgsmsx502.gar.corp.intel.com>
 <20110905112225.72b46ac9@infradead.org>
 <3CA6C6D9F70D314CA34352990B57DA1507C4275D58@bgsmsx502.gar.corp.intel.com>
 <20110906200614.57a99d3d@infradead.org>
 <3CA6C6D9F70D314CA34352990B57DA1507C42767FA@bgsmsx502.gar.corp.intel.com>
 <20110908021327.GA8890@zhy>
 <20110908072948.GB11124@zhy>
 <3CA6C6D9F70D314CA34352990B57DA1507C42C3CA5@bgsmsx502.gar.corp.intel.com>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507C42C3CA5@bgsmsx502.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 08, 2011 at 03:15:38PM +0530, Nallasellan, Singaravelan wro=
te:
> > > > Further investigation of this issue shows that the thread is in=
 running state

Hmm, how do you detect it?

> > and it is not scheduled. I am not sure how I will go about debuggin=
g this issue.
> > Any pointer would help.

Could 'cat /proc/sched_debug' give some useful info?

And BTW, have you tried CONFIG_DETECT_SOFTLOCKUP =3D y?

Thanks,
Yong


> > >
> > > Could you confirm if [commit f26f9af Sched: fix skip_clock_update
> > > optimization] residents in your kernel?
> I applied this patch manually. I still see the issue.
> >=20
> > And commit da7a735e51f9622eb3e1672594d4a41da01d7e4f
> > http://marc.info/?l=3Dlinux-kernel&m=3D129527509622696&w=3D2
> This is already applied.
> =13=EF=BF=BD=EF=BF=BD=EC=B9=BB=1C=EF=BF=BD&=EF=BF=BD~=EF=BF=BD&=EF=BF=
=BD=18=EF=BF=BD=EF=BF=BD+-=EF=BF=BD=EF=BF=BD=DD=B6=17=EF=BF=BD=EF=BF=BD=
w=EF=BF=BD=EF=BF=BD=CB=9B=EF=BF=BD=EF=BF=BD=EF=BF=BDm=EF=BF=BDb=EF=BF=BD=
=EF=BF=BDdz=EF=BF=BD=DE=96)=EF=BF=BD=EF=BF=BD=EF=BF=BDw*=1Fjg=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=1E=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j/=
=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD2=EF=BF=BD=
=DE=99=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD)=DF=A1=EF=BF=BDa=EF=BF=BD=EF=
=BF=BD=7F=EF=BF=BD=EF=BF=BD=1E=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=
=BF=BD=0F=EF=BF=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BD=D9=A5>W=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDi=EF=BF=BDaxP=10j=EF=BF=BDm=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=0C-=EF=BF=BD=1A+=EF=BF=BD=EF=BF=BDd=EF=BF=BD_

--=20
Only stand for myself
