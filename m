From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: OMAP: Add checking to detect
	bufferless pcms
Date: Wed, 22 Apr 2009 12:42:46 +0300
Message-ID: <200904221242.46541.peter.ujfalusi@nokia.com>
References: <49EE7962.6080008@samsung.com>
	<bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 862742465C
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 11:43:14 +0200 (CEST)
In-Reply-To: <bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 22 April 2009 11:30:32 ext Jarkko Nikula wrote:
> On Wed, Apr 22, 2009 at 4:56 AM, Joonyoung Shim
> <jy0922.shim@samsung.com<mailto:jy0922.shim@samsung.com>> wrote: Add
> checking in hw_params and prepare to detect bufferless pcms(i.e. BT <-->
> codec).
>
> I see exactly similar lines in s3c24xx-pcm.c but don't point now the use
> case where this is used and I don't have idea what is this all about.
>
> Is this something where DAI driver or another end of connection is used to
> provide clocking and the whole setup is then controlled with ALSA PCM API?
> Somehow I have the feeling that would there be a better way to achieve it
> than with dummy bufferless transfer?

In the twl codec, the BT interface does not have dedicated clock line, but =
it =

is (re)using the clock lines for the voice PCM interface. So in order to ge=
t =

BT data going between the BT and the codec, the voice PCM interface has to =

generate the clocks.

But I think this could be done even without the need for the alsa PCM =

interface, probably well placed DAPM switches would also can take care of =

this?

>
> --
> Jarkko

-- =

P=E9ter
