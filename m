From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Hide TLV320AIC26 configuration
	option for	non-OpenFirwmare users
Date: Tue, 14 Oct 2008 10:04:48 +0100
Message-ID: <20081014090444.GA14538@sirena.org.uk>
References: <1223915914-12196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h1vykv1rm.wl%tiwai@suse.de>
	<20081013181458.GA23014@opensource.wolfsonmicro.com>
	<s5hod1nohi8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AF782444E
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 11:05:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hod1nohi8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 14, 2008 at 07:47:11AM +0200, Takashi Iwai wrote:

> Well, this is a standard technique.  You can find "if EMBEDDED" in
> many Kconfig items, too.

Yeah, though the cases I remembered noticing were for things were the
entry should be both hidden and disabled.
