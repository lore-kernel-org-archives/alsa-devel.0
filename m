From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: issue with TWL4030
Date: Tue, 13 Jul 2010 11:03:27 +0300
Message-ID: <201007131103.27928.peter.ujfalusi@nokia.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<C358A26273CF2948B8BCDBA661A581782A6FBF945F@NOK-EUMSG-03.mgdnok.nokia.com>
	<AANLkTim5rQNaVHLlEjXK3hY2ykOU_TxM89WJd1g96LCh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D90AE24362
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 10:03:34 +0200 (CEST)
In-Reply-To: <AANLkTim5rQNaVHLlEjXK3hY2ykOU_TxM89WJd1g96LCh@mail.gmail.com>
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
Cc: ext Raymond Yau <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tuesday 06 July 2010 02:24:50 ext Raymond Yau wrote:
> The OSS emulation call driver's hw_params many time when the OSS program =
or
> SDL try to probe the supported rate , format and channels
> =

> Not easy for the driver to 100% compatible with OSS 3.8 since the default
> is mono ,U8 and 8000Hz when you use  "cat  foo.wav > /dev/dsp" or "cat
> /dev/dsp > foo.wav"

I agree with you.
What I plan to do is to allow several hw_params call on the master (first) =

stream until the point when the playback is actually started.
I need to check how does the consequent hw_parmas looks like. Do they retai=
n the =

already configured parameters? What I mean is that at the last hw_parmas ca=
ll is =

it so that all the needed information sent to the driver?

Thanks,
P=E9ter
