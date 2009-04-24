From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3] ASoC: cs4270: add Master Playback
	Switch
Date: Fri, 24 Apr 2009 14:17:38 +0100
Message-ID: <20090424131738.GE26440@sirena.org.uk>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<1240578026-1987-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 00DA6103897
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 15:17:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1240578026-1987-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 03:00:26PM +0200, Daniel Mack wrote:
> This new control exports cs4270's DAC MUTE capabilities.

The DAC mute is controled by cs4270_mute function - DAC mute is handles
specially since many CODECs want to have mute synchronised with power
down of the DAC.  If cs4270 doesn't need this then remove the DAI
operation too.
