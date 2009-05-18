From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring
	and	Headset pop-attenuation fix
Date: Mon, 18 May 2009 14:09:28 +0100
Message-ID: <20090518130928.GD1629@sirena.org.uk>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AABAD1037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 15:09:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, getarunks@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 18, 2009 at 04:02:03PM +0300, Peter Ujfalusi wrote:

> The following series aims to fix the Headset power on/off pop noise problems.

Looks OK but given all the to and fro here I'd rather wait for some
testing to make sure it works well on other system.s

> I needed to move the APGA control from SND_SOC_DAPM_PGA to be handled with
> _MIXER. Than adding a PGA to the headset outputs results correct power
> sequences.

TBH it sounds like this is actually a mixer anyway - typically mixers do
have some gain controls associated with them, the sort of PGA DAPM means
is more an output stage driver.  Typically these have much more control
of the gain and only one input and output.
