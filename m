From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Workaround for headset DC
	offset caused pop noise
Date: Wed, 12 Oct 2011 11:18:50 +0300
Message-ID: <1362600.vrF78ASdYQ@barack>
References: <1318330813-31184-1-git-send-email-peter.ujfalusi@ti.com>
	<20111011132921.GD1098@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 408FC1038C5
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 10:18:50 +0200 (CEST)
Received: by mail-wy0-f172.google.com with SMTP id 24so455602wyg.31
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2011 01:18:48 -0700 (PDT)
In-Reply-To: <20111011132921.GD1098@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 11 October 2011 14:29:21 Mark Brown wrote:
> On Tue, Oct 11, 2011 at 02:00:13PM +0300, Peter Ujfalusi wrote:
> > Both Headset DAC need to be enabled at the same time, before any of
> > the output drivers are enabled.
> =

> This sounds like you should be using a supply widget to do the reference
> counting here?

Probably it is better to move the whole thing to be handled by a supply wid=
get =

(attached to the HS DACs).
It will not mess up the sequence, and I'm not going to need to count in the =

driver.
Will rewrite the patch.

Thanks for the suggestion,
P=E9ter
