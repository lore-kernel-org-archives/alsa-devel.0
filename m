From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply,
 not revision
Date: Sat, 4 Jun 2016 19:15:25 +0200
Message-ID: <20160604171525.GA29266@archie.localdomain>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
 <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
 <5751AEF6.40200@nelint.com> <575264A4.2070709@nelint.com>
 <20160604090324.GA867@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pqgruber.com (mail.pqgruber.com [178.189.19.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CE1E260831
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 19:15:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160604090324.GA867@archie.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: Eric Nelson <eric@nelint.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Hi Fabio,

please don't merge the patch yet, I just observed a strange effect when
resetting the board during playback / just after playback stops.
At next boot time, sometimes the following error occurs:
imx-sgtl5000 sound: ASoc: CODEC DAI sgtl5000 not registered
imx-sgtl5000 sound: snd_soc_register_card failed (-517)

I'll have to investigate further and will report back. Until then,
please hold off with the patch. I might have overlooked something.

Regards,
Clemens
