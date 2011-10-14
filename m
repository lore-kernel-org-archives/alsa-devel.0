From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 1/2] ASoC: soc-pcm: Add flag to ignore
	pmdown_time at pcm_close
Date: Fri, 14 Oct 2011 13:27:01 +0300
Message-ID: <1710140.zx24iMBeWW@barack>
References: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
	<10992537.0jJ7E3VM1G@barack> <20111014093840.GA5448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 3094324412
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 12:27:07 +0200 (CEST)
Received: by mail-yx0-f179.google.com with SMTP id 35so796260yxn.24
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 03:26:56 -0700 (PDT)
In-Reply-To: <20111014093840.GA5448@sirena.org.uk>
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

On Friday 14 October 2011 10:38:41 Mark Brown wrote:
> I'd expect that it's likely to follow the device a lot of the time - for
> example, in the case that motivated this it seems that every system
> using twl6040 is going to need to work around the DC servo issue.

Fair enough. I'll move the flag to snd_soc_codec.

--
P=E9ter
