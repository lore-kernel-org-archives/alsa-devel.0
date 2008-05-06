From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Where can I find ALSA driver for smdk2410-UDA1341?
Date: Tue, 6 May 2008 13:33:32 +0100
Message-ID: <20080506123331.GC31939@sirena.org.uk>
References: <F360252464DB3C448CCADCBCE8276CCF17D196@inmail.hopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DDD52439E
	for <alsa-devel@alsa-project.org>;
	Tue,  6 May 2008 14:33:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <F360252464DB3C448CCADCBCE8276CCF17D196@inmail.hopen.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: yushilin <slyu@hopen.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 06, 2008 at 04:49:34PM +0800, yushilin wrote:

> Any one knows?

You probably want to look at the ASoC subsystem[1] - see sound/soc and
Documentation/sound/alsa/soc.  There is support for s3c24xx CPUs in
the mainline kernel distribution already, although no specific support
for the UDA1341 codec or that specific board.

[1] http://opensource.wolfsonmicro.com/node/6
