From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ascenario: Add scenario support to	alsa-lib
Date: Wed, 7 Oct 2009 14:53:20 +0100
Message-ID: <20091007135320.GI19135@sirena.org.uk>
References: <20091001150849.GE5936@excalibur.local>
	<20091005082747.GA3983@excalibur.local>
	<alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
	<20091005093502.GC3983@excalibur.local>
	<alpine.LNX.2.00.0910060949070.31529@eeebox2.perex-int.cz>
	<s5hzl847w3q.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910061048410.31529@eeebox2.perex-int.cz>
	<s5hvdis7txp.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910061302330.31529@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0910061510320.31529@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3675C103899
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 15:53:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910061510320.31529@eeebox2.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 06, 2009 at 03:33:39PM +0200, Jaroslav Kysela wrote:

> - represent QoS with string (name) rather than integer -
>    QoS is also quite use-case specific

I believe the idea is that QoS should be relatively generic - the long
term idea is that the application should be able to give some idea of
the sort of output it is trying to provide to the stack to enable the
stack to make decisions about configuration.
