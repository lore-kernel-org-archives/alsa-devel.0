From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Do DAPM control updates in
	the	middle of DAPM sequences
Date: Thu, 16 Dec 2010 13:55:05 +0000
Message-ID: <20101216135505.GA1344@sirena.org.uk>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292349202-25538-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201012161551.13096.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F5ED2444C
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 14:55:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012161551.13096.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 16, 2010 at 03:51:13PM +0200, Peter Ujfalusi wrote:

> It behaves mostly OK, but there's a strange side effect:
> I noticed a pop on playback stream start on the twl4030 codec.
> I'll look into it, but I do not see how this patch can affect the stream start..

Indeed, it should result in an extra comparison in the middle of the
DAPM sequence which oughtn't to have any effect here.  Is it possible
that some of the other updates that have been going in recently such
as the cross-device changes introduced this, or is it definitely just
this one patch?

> Could you hold this patch for some time, so I can look at this?

Sure.
