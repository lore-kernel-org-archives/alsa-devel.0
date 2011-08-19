From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: ALSA underruns for S32_LE format
Date: Fri, 19 Aug 2011 17:13:14 +0530
Message-ID: <CABb+yY2SnCwoHANNPiekz0TqqV2L=gzz2mk_6tvC-VYDtmEJtg@mail.gmail.com>
References: <CAL5CBvJBrk=euqXgOK=QWP4NC5yYKsm92Y+vC4dJiirgW1o_+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id DE98E24655
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 13:43:14 +0200 (CEST)
Received: by bkar19 with SMTP id r19so2208979bka.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 04:43:14 -0700 (PDT)
In-Reply-To: <CAL5CBvJBrk=euqXgOK=QWP4NC5yYKsm92Y+vC4dJiirgW1o_+A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kuldeep ghan <ghankp@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2011 at 4:06 PM, kuldeep ghan <ghankp@gmail.com> wrote:
> Hi,
>
> I am trying to play raw audio as S32_LE format and I am getting underruns.
>
> *# aplay /userdata/raw -fS32_LE -r48000 -c2*
> *Playing raw data '/userdata/raw' : Signed 32 bit Little Endian, Rate 48000
> Hz, Stereo*
> *underrun!!! (at least 0.055 ms long)*
> *underrun!!! (at least 0.043 ms long)*
> *underrun!!! (at least 0.040 ms long)*
> *underrun!!! (at least 0.043 ms long)*
> *underrun!!! (at least 0.043 ms long)*
> *underrun!!! (at least 0.043 ms long)*
> *underrun!!! (at least 0.040 ms long)*
>
> I am able play it fine as S16_LE format. (aplay /userdata/raw -fS16_LE
> -r48000 -c2)
>
> I would like to get it working fine S32_LE format. Any help, suggestions to
> get away with underruns is welcome.
>
>From the info you provide, it seems your codec doesn't support 32bps and your
system is too slow to be able to afford plugin's conversion overhead.
