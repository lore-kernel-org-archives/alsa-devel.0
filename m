From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: How to define card specific pcm devices?
Date: Fri, 24 Aug 2012 12:20:04 +0800
Message-ID: <CAN8cciacZ7NZkkBHo0KVfnGWdbuc-tX=QMg=-=m0+xDFGswoRA@mail.gmail.com>
References: <1344597903.4283.68.camel@IT-D-4QB9Z4J>
 <1345215040.2530.26.camel@IT-D-4QB9Z4J>
 <CAN8cciYX4krbJvb9PWQFswAKq0AqiC_oh20n+NB2Ak=BF8Zgxw@mail.gmail.com>
 <CAN8cciZH2SL7Dm0ykA+hfRoksngo9Z15pkTLHp+pXDYSKpm90w@mail.gmail.com>
 <1345262953.4864.12.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CCDF264EF7
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 06:20:06 +0200 (CEST)
Received: by qcse14 with SMTP id e14so948198qcs.38
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 21:20:05 -0700 (PDT)
In-Reply-To: <1345262953.4864.12.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

>
> > how about the 4 channel mic?
>
> What about it? The discussion stopped when I asked what should be the
> name for the device. I asked whether "4channelinput" would be good, but
> got no answers. At PulseAudio side we figured that "hw" works well
> enough in practice

http://www.rrfx.net/2009/11/ps3-eye-4-channel-audio-tests-on-ubuntu.html

the geometry of the microphone array is an important factor for how to
perform downmixing to mono as there are delay between the four mics and the
channel map of mic array is different from the channel map of surround
speakers
