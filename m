From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA framework
Date: Wed, 16 Mar 2011 12:52:23 -0500
Message-ID: <AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
References: <4D7FB076.30300@codeaurora.org>
	<20110316103814.GA8369@sirena.org.uk>
	<1300273162.9428.10.camel@vkoul-udesk3>
	<20110316115627.GC14125@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110316115627.GC14125@opensource.wolfsonmicro.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> It would be nice to have a standard userspace API for this but I'm no=
t
> aware of anyone who's looked at it in detail and you start having to
> also take into account other algorithms that are running on the devic=
e
> so there's nothing to point people at right now and no real prospect =
of
> there being. =A0I don't know if it's something we can resolve entirel=
y in
> the kernel as I'm aware that some of the DSP implementations have
> non-trivial management code in userspace that they talk to which may
> mean that the standard API has to be a userspace one. =A0There's also=
 the
> difference between memory to memory implementations (which fit into a
> userspace chain much more readily) and tunneled implementations (whic=
h
> do need new infrastructure).
>
> I think this'll get substantially easier to look at once the media
> controller API is merged and starts to be used in the audio subsystem=
=2E

Mark:
I must be missing something here. Why would this media controller API
make things simpler? Based on what was presented at LPC, I don't
understand this last part.
-Pierre
--
To unsubscribe from this list: send the line "unsubscribe linux-arm-msm=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
