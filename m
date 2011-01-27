From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: Convert bunch of codecs to use
 soc-core interconnect registration
Date: Thu, 27 Jan 2011 08:57:09 +0200
Message-ID: <4D411745.4070307@nokia.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
	<1296043097-11720-4-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A7F08243AF
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 07:57:14 +0100 (CET)
In-Reply-To: <1296043097-11720-4-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 01/26/11 13:58, ext Jarkko Nikula wrote:
> These codec drivers have only single interconnect map so these can be
> switched to use soc-core based interconnect registration.
> =

> This simplifies those codecs that check the return value of
> snd_soc_dapm_add_routes and adds a failure path to those that don't.

I might be missing something, but the only benefit of the 3+4 patch is
actually the failure check for the snd_soc_dapm_add_routes, which was
not done for most of the codecs, but now it is done in the core.
On the other hand, now we always have one check for the
codec->driver->route in soc_probe_codec.
I don't see how these actually simplifies the codec drivers.
We had a single snd_soc_dapm_add_routes call before the patches, now we
have two fields to fill in snd_soc_codec_driver...

-- =

P=E9ter
