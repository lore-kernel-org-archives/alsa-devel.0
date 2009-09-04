From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Is there a way to figure out if the clocks of
	two	snd_pcm_t's deviate? (snd_pcm_info_get_sync?)
Date: Fri, 4 Sep 2009 12:44:30 +0100
Message-ID: <20090904114430.GA8269@sirena.org.uk>
References: <20090903230351.GA7493@tango.0pointer.de>
	<alpine.LNX.2.00.0909040831390.20533@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 74F6B24453
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 13:44:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0909040831390.20533@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 04, 2009 at 08:44:50AM +0200, Jaroslav Kysela wrote:

> I cannot recall from my mind, if any card has two clock sources - maybe 
> only old Gravis UltraSound hardware with GF1 and CS4231 chips, but it's 
> history. Also, professional hardware can run with word clock sync (wire 
> connection carrying sample clock) or S/PDIF clock sync. But it's matter of 
> user configuration.

Several of the embedded CODECs can have multiple master clocks active
simultaneously within just that device and even more embedded systems
are able to run with multiple masters.
