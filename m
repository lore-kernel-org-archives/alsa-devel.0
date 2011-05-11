From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: codecs: max98088: bug fixes and changes
Date: Wed, 11 May 2011 10:26:46 +0200
Message-ID: <20110511082646.GA16115@opensource.wolfsonmicro.com>
References: <D9A2FA38A1E15B4E832469E5FE40C7ABFA0296357B@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15D31103813
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 10:26:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <D9A2FA38A1E15B4E832469E5FE40C7ABFA0296357B@HKMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jinyoung Park <jinyoungp@nvidia.com>
Cc: 'Peter Hsiang' <Peter.Hsiang@maxim-ic.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, swarren@nvidia.com, 'Liam Girdwood' <lrg@slimloigic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 11, 2011 at 02:18:49PM +0800, Jinyoung Park wrote:

> Recently, I working on max98088 and changed something in max98088 asoc driver.

> I included three changes for max98088 in this mail.
> - 1/3 Fixed invalid register definitions in mixer controls
> * This change was confirmed by Peter Hsiang who author of max98088 driver and maxim engineer.
> - 2/3 Moved the EX Limiter Mode from dapm widget to control
> - 3/3 Added digital mute function in DAI1 and DAI2

> Please review below my changes.

Please fix your MUA configuration so you can submit changes as covered
in SubmittingPatches.  I've CCed in your colleage Stephen Warren who
seems to have this set up fine.  Aside from the HTML issue your mail has
multiple copies of patches in it so it'd be really difficult to apply.

The patches themselves look fine but please resend in a format that's
easier to apply.
