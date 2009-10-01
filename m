From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: add support for multiple
	cards/codecs in debugfs
Date: Thu, 1 Oct 2009 09:13:57 +0300
Message-ID: <200910010913.57488.peter.ujfalusi@nokia.com>
References: <1254306259-8098-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090930123938.GC12101@sirena.org.uk>
	<200910010841.07085.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 324671038D2
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 08:14:19 +0200 (CEST)
In-Reply-To: <200910010841.07085.peter.ujfalusi@nokia.com>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 01 October 2009 08:41:07 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Is it good if the patch creates a directory hierarchy like this:
> debugfs/asoc/{dev_name()}/{codec->name}/...
> =

> Or should I use some intermediate buffer to construct a single level tree:
> debugfs/asoc/{dev_name()}-{codec->name}/...
> =

> From the point of what is coming the former is much more future proof, if
>  we take into account that we can have more than one codec in one soc
>  device (or card).

After a bit of thinking, I think I will go with the later one:
debugfs/asoc/{dev_name()}-{codec->name}/...

It needs some intermediate buffer to construct the string for the directory=
, but =

I think that is the better way for now.

> =


-- =

P=E9ter
