From: kuldeep ghan <ghankp@gmail.com>
Subject: Re: ALSA underruns for S32_LE format
Date: Sat, 20 Aug 2011 00:03:36 +0530
Message-ID: <CAL5CBvLB8QJdH0m_SqpZRAY6ka279akzKdoUS6naPCEWPYh4cA@mail.gmail.com>
References: <CAL5CBvJBrk=euqXgOK=QWP4NC5yYKsm92Y+vC4dJiirgW1o_+A@mail.gmail.com>
	<CABb+yY2SnCwoHANNPiekz0TqqV2L=gzz2mk_6tvC-VYDtmEJtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E0793103822
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 20:33:37 +0200 (CEST)
Received: by wyh22 with SMTP id 22so2447319wyh.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 11:33:37 -0700 (PDT)
In-Reply-To: <CABb+yY2SnCwoHANNPiekz0TqqV2L=gzz2mk_6tvC-VYDtmEJtg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
 Thanks Jassi, I dont my System is too slow, I have dual core processor,
1.5GHz. no CPU consuming process running on it.
 I Shall confirm if it does not support S32_LE.. Is  there any means by
which I can confirm the same without
 going through Codec Driver??
Kuldeep


On Fri, Aug 19, 2011 at 5:13 PM, Jassi Brar <jassisinghbrar@gmail.com>wrote:

> On Fri, Aug 19, 2011 at 4:06 PM, kuldeep ghan <ghankp@gmail.com> wrote:
> > Hi,
> >
> > I am trying to play raw audio as S32_LE format and I am getting
> underruns.
> >
> > *# aplay /userdata/raw -fS32_LE -r48000 -c2*
> > *Playing raw data '/userdata/raw' : Signed 32 bit Little Endian, Rate
> 48000
> > Hz, Stereo*
> > *underrun!!! (at least 0.055 ms long)*
> > *underrun!!! (at least 0.043 ms long)*
> > *underrun!!! (at least 0.040 ms long)*
> > *underrun!!! (at least 0.043 ms long)*
> > *underrun!!! (at least 0.043 ms long)*
> > *underrun!!! (at least 0.043 ms long)*
> > *underrun!!! (at least 0.040 ms long)*
> >
> > I am able play it fine as S16_LE format. (aplay /userdata/raw -fS16_LE
> > -r48000 -c2)
> >
> > I would like to get it working fine S32_LE format. Any help, suggestions
> to
> > get away with underruns is welcome.
> >
> From the info you provide, it seems your codec doesn't support 32bps and
> your
> system is too slow to be able to afford plugin's conversion overhead.
>
