From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Fix locking during codec
	shutdown
Date: Fri, 06 Jul 2012 18:10:13 +0100
Message-ID: <1341594613.4963.11.camel@odin>
References: <1341590225-20837-1-git-send-email-lrg@ti.com>
	<20120706160220.GG4017@opensource.wolfsonmicro.com>
	<1341592575.4963.7.camel@odin>
	<20120706164344.GH4017@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 4ED76104596
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 19:10:18 +0200 (CEST)
Received: by wibhm2 with SMTP id hm2so751858wib.10
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 10:10:15 -0700 (PDT)
In-Reply-To: <20120706164344.GH4017@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-07-06 at 17:43 +0100, Mark Brown wrote:
> On Fri, Jul 06, 2012 at 05:36:15PM +0100, Liam Girdwood wrote:
> 
> > I don't think there is anything explicitly stopping a power off from
> > happening during a stream shutdown atm without this patch. It was
> > reported to me that this would fail 1 in 20 times on a certain device
> > and that the above patch fixed the issue (1200 tests completed OK after
> > the patch).
> 
> > I do think we need this patch atm since we are accessing the same
> > resources as the stream event.
> 
> So how is suspend and resume safe, for example?  It's the same general
> path through the PM core.

suspend and resume are safe as they call stream_event() that holds the
DAPM mutex.

Fwiw, I've searched my email and found Misa's analysis here :-

<device is preparing to reboot>
soc_dapm_shutdown_codec() : Insert widget A, B, C, ... in "down_list"
soc_dapm_shutdown_codec() : Run power sequence via dapm_seq_run()
dapm_seq_run(): Move widget A, B, C, ... from "down_list" to "pending"
list for coalesced changes
dapm_seq_run_coalesced(): Iterating over A

<system sound indicating device reboot closes>
dapm_power_widgets() : Run a STREAM_STOP event a inserts widget B in a
different "down_list" (whose next element is not C, but other widget X
with diff reg address)

dapm_seq_run_coalesced() : Iterates over B and expected C next, but got
the widget X added by dapm_power_widgets() above
dapm_seq_run_coalesced() : Widget X doesn't share same reg address as
widget A, B, ... hence BUG().

dapm_power_widgets() uses card's power_mutex, but
soc_dapm_shutdown_codec() does not, so above scenario is possible. IMO,
just protecting codec shutdown with card's power_mutex should suffice as
in attached patch.

Liam
