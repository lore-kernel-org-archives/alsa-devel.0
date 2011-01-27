From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: Convert bunch of codecs to use
 soc-core interconnect registration
Date: Thu, 27 Jan 2011 09:21:16 +0200
Message-ID: <20110127092116.e29f5cb1.jhnikula@gmail.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
	<1296043097-11720-4-git-send-email-jhnikula@gmail.com>
	<4D411745.4070307@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7169C2464F
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 08:19:54 +0100 (CET)
Received: by fxm5 with SMTP id 5so1836344fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 23:19:54 -0800 (PST)
In-Reply-To: <4D411745.4070307@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Jan 2011 08:57:09 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> On 01/26/11 13:58, ext Jarkko Nikula wrote:
> > These codec drivers have only single interconnect map so these can be
> > switched to use soc-core based interconnect registration.
> > 
> > This simplifies those codecs that check the return value of
> > snd_soc_dapm_add_routes and adds a failure path to those that don't.
> 
> I might be missing something, but the only benefit of the 3+4 patch is
> actually the failure check for the snd_soc_dapm_add_routes, which was
> not done for most of the codecs, but now it is done in the core.
> On the other hand, now we always have one check for the
> codec->driver->route in soc_probe_codec.
> I don't see how these actually simplifies the codec drivers.
> We had a single snd_soc_dapm_add_routes call before the patches, now we
> have two fields to fill in snd_soc_codec_driver...
> 
Yeah, simplification comes only if a driver is checking the return value
what most are not doing currently.

Another issue that came to my mind if some drivers need to add
additional interconnects later then there's basically need to revert
the 4/4 for those codecs. However, I don't think there are many codecs
that will do that.

-- 
Jarkko
