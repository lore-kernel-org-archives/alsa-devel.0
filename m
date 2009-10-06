From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Tue, 6 Oct 2009 17:12:32 +0200
Message-ID: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
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
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 070CD103938
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:12:48 +0200 (CEST)
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello.

On Tue, 2009-10-06 at 15:33, Jaroslav Kysela wrote:
> On Tue, 6 Oct 2009, Jaroslav Kysela wrote:
> 
> >So at least, the API basics is now clear. I'll prepare a branch in
> >alsa-lib GIT tree to have a start point for first accepted
> >implementation.
> 
> The updated header file is now at:
> 
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=include/ascenario.h;h=003eabeafb7320c96bac585f4aac922e5ba290bb;hb=97911335f2a50ad35c57df6c8a2cfe2867dba97a
> 
> My other proposals:
> 
> - remove all SND_SCN_ defines - they are quite use-case specific
>   - the names should be just documented somewhere
> - represent QoS with string (name) rather than integer -
>   QoS is also quite use-case specific
> - SND_SCN_INT_QOS may be SND_SCN_INT_QOS_POWER ?
> - what about to remove QOS and add universal parameter interface?
>   something like:
> 
> int snd_scenario_set_parameter(snd_scenario_t *scn, char *type, char *value);

I will work on these items over the next days. Patches will be based on the
ascenrio branch and get posted here.

regards
Stefan Schmidt
