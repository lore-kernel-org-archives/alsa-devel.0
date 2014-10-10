From: Fabio Estevam <festevam@gmail.com>
Subject: Re:
	=?utf-8?q?No_sound_captured_with_SGTL5000_on_i=2EMX6?=
	=?utf-8?q?_in_I=C2=B2S_master_mode?=
Date: Fri, 10 Oct 2014 12:54:35 -0300
Message-ID: <CAOMZO5A6dH8pG-y5Bg6TMkQ5XDg9UbVgULgLiRSp3yAV7GPzdw@mail.gmail.com>
References: <20140918170524.GA6080@Asurada>
 <CAOMZO5AqtNm3kwndUYszAuMfJ4CMOz4pwZRmE+04cEDtz98agg@mail.gmail.com>
 <20140918174935.GB6432@Asurada>
 <CAOMZO5AXN4p01=oGCydHUm6sPdt5NRNXO+4EOKQ1T7ZKUwVfMw@mail.gmail.com>
 <20140918180742.GC6432@Asurada>
 <CAOMZO5AvWecqimJkZcwysvsmPiq8Fa2Hm_XppCH3E1+vyjVzFQ@mail.gmail.com>
 <20140918183910.GF6432@Asurada>
 <CAOMZO5BJbzizB4r8vvtJEBzv+DhsyRmYMUoQL2D-dQhBorGkzA@mail.gmail.com>
 <20140918235045.GA4148@Asurada>
 <CAL8zT=hdT0otjqkQeBmfQgNsfdoapCv3NnHMwNxfxydu1+44Ww@mail.gmail.com>
 <20140919075228.GA4376@Asurada>
 <CAL8zT=jWQ4ZTGpohWHGTfbxgj547ukcZEUg7XdQsWzwq1=JiVA@mail.gmail.com>
 <CAL8zT=gELK8+LOgVn6qXnaTm=Vcx=zn8OxfQBh_9m28NQtR2pA@mail.gmail.com>
 <CAL8zT=gEMwbJq=3Tf6FAg2_fyAK4Q07-hVn5eYZKFSBfC-8iBQ@mail.gmail.com>
 <CAOMZO5CWZdyLHzc=EpQ3LYE3ixiRXbp-WTCT=2JKgQK0sEc_gw@mail.gmail.com>
 <CAL8zT=jUbck2OTpskna3rjgo-NGWw6VX2cuDHP9bDunbS_qGBg@mail.gmail.com>
 <CAOMZO5CBPcQ1O-o2sMxcSzudJrju+aevheJbWw2m_QH7UyHzXw@mail.gmail.com>
 <CAL8zT=j=hXA8oCFGfhW=NwuFX6w70_GT+r5qHMk+tCLX7YOocg@mail.gmail.com>
 <CAOMZO5DHFgJRH_c-6rUCdfhX7ejHYMdjXCCFTNzjQ7qOfSQ+=A@mail.gmail.com>
 <CAL8zT=jJtsOLfZKeBV1UhpU0FzUWJL4Ywhi20QrAZujbZ+uanw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D7D16260650
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 17:54:38 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id gi9so3531450lab.19
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 08:54:36 -0700 (PDT)
In-Reply-To: <CAL8zT=jJtsOLfZKeBV1UhpU0FzUWJL4Ywhi20QrAZujbZ+uanw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 10, 2014 at 12:49 PM, Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com> wrote:

> Do I need to keep actual defaults if the resistor or voltage are not
> specified in DT ?

Better to keep the behaviour unchanged, so that old dtb's can work
exactly in the same way.

> Or should I set it to off (which is probably more logical) ?
> And one or two patches (one resistor and one voltage patch, or both in
> the same) ?

Splitting in 2 patches is easier for reviewing.
