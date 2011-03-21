From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about
	snd_mixer_selem_get_playback_dB_range()
Date: Mon, 21 Mar 2011 15:38:59 +0100
Message-ID: <4D876303.3090100@ladisch.de>
References: <1300711933.24854.263.camel@IT-W2076>	<AANLkTi=jXgTmNUM=RG=AuToV9Z-gNpVAmPWSk8Zq4GSs@mail.gmail.com>
	<1300715722.24854.290.camel@IT-W2076>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1B88124152
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 15:37:31 +0100 (CET)
In-Reply-To: <1300715722.24854.290.camel@IT-W2076>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanu.kaskinen@digia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tanu Kaskinen wrote:
> On Mon, 2011-03-21 at 15:43 +0200, Raymond Yau wrote:
> > AFAIK , only those STAC920x codec has SND_CTL_TLV_DB_GAIN_MUTE
> 
> Also some broken HDA cards,

Where "some" = "those that use a STAC920x codec".

> What is not any driver bug?

That the hardware reported a wrong dB value for the lowest volume
setting.  The latest driver has a workaround.

> Is it a bug in alsa (the driver or alsa-lib or whatever) if
> snd_mixer_selem_get_playback_dB_range() returns something else than
> SND_CTL_TLV_DB_GAIN_MUTE as the min gain, if the lowest volume step for
> the element is mute?

Yes.


Regards,
Clemens
