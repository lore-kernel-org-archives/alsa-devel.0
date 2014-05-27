From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Fix Left/Rigth PGA
 mixer widgets/kcontrols
Date: Tue, 27 May 2014 13:18:33 +0200
Message-ID: <53847489.2010801@metafoo.de>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
 <1401187986-11059-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-071.synserver.de
 [212.40.185.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 127D82655AD
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 13:18:31 +0200 (CEST)
In-Reply-To: <1401187986-11059-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/27/2014 12:53 PM, Peter Ujfalusi wrote:
> Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
> control" changed the way how the 'value' has been stored for a widget.
> Since the driver is not updated following the mentioned commit it is mostly
> broken when we try to change mixers for Left/Right PGA since the value is
> not going to be updated correctly.

I don't think the mentioned commit is the cause. The driver didn't set 
widget->value either, so there is no change in behavior here. The commit 
only changed where the value is stored not how it is handled.

This driver uses a custom put handler and the generic get handler. 
dapm_kcontrol_get_value() is used in the generic get handler, but only if 
reg equal to SND_SOC_NOPM. Which is not the case for this driver. And that's 
the only place where the value stored for the kcontrol is used. I don't see 
how calling dapm_kcontrol_set_value() or not calling 
dapm_kcontrol_set_value() changes anything.

I might be missing something, but I think the issue is somewhere else.

- Lars
