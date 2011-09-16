From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: snd_pcm_pause kills plaback handle on OMAP4
Date: Fri, 16 Sep 2011 11:37:30 +0300
Message-ID: <1566700.iCnvMszhAn@barack>
References: <20110914111322.98fd97237cc930a62b888eb89e535f85.3e53ce80b3.wbe@email12.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 2044C2413F
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 10:37:32 +0200 (CEST)
Received: by mail-bw0-f47.google.com with SMTP id 11so4780751bke.6
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2011 01:37:30 -0700 (PDT)
In-Reply-To: <20110914111322.98fd97237cc930a62b888eb89e535f85.3e53ce80b3.wbe@email12.secureserver.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: john@johnandjuliet.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Wednesday 14 September 2011 11:13:22 john@johnandjuliet.com wrote:
> I'm trying to control the McBSP2 that is used for the modem in an
> android environment (BLAZE OMAP4)

What kernel are you using?
 =

> What I am trying to do is control the audio paths for capture and
> playback seperatly like in a SIMPLEX (half duplex) instead of full
> DUPLEX mode audio ..

So either playback, or capture, but never both at the same time?

> I also want to stop the audio without total
> shutdown of the audio system.
> =

> From what I can see that would be to call snd_pcm_pause(handle,bool)
> =

> But here is what happens.  With the handle forthe plaback path
> everything works OK... But if I call that then the capture path stops
> working... even if I try to turn on (unpause) both paths.

So you have both playback and capture opened, if you pause the playback, an=
d =

release it, then the capture path stops working?
Or you mean that doing the pause/release with playback, then closing it, af=
ter =

that the capture is not working?

> This implies some sort of bug in the omap soc driver?

Everything is possible. I have not heard such about such a problem myself.
If this issue exist on OMAP4, it should be present on OMAP3 as well...

Could you be more specific on the scenario?
What codec you have attached to McBSP2 port?
Are you using ABE, or are you using the McBSP2 port directly?

CC-ing Jarkko to catch his attention...

--
P=E9ter
