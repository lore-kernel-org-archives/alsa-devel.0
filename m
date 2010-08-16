From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional	kcontrol
	prefix name for a DAI link
Date: Mon, 16 Aug 2010 12:09:03 +0100
Message-ID: <20100816110902.GA10354@sirena.org.uk>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B914010383A
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 13:09:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100816135328.077b5ea3.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 16, 2010 at 01:53:28PM +0300, Jarkko Nikula wrote:

> Multi-DAI codecs are not so clear to me. I thought codecs are exporting
> different controls for different DAIs? Like "foo Playback Volume" and
> "bar Playback Volume".

No, consider CODECs which support mixing signals between the two DAIs
like the WM9713 or WM8994.  You will normally have some controls for the
very edge of the CODEC but for at the parts of the CODEC after mixing
there's no way to distinguish based on the DAI.
