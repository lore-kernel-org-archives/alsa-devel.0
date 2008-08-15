From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: SPDIF audio / non-audio bit
Date: Sat, 16 Aug 2008 00:45:33 +1000
Message-ID: <1218811533.32652.33.camel@localhost>
References: <1218725321.32652.14.camel@localhost>
	<s5hmyjfzks2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F38A246CD
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 16:45:40 +0200 (CEST)
In-Reply-To: <s5hmyjfzks2.wl%tiwai@suse.de>
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


On Thu, 2008-08-14 at 17:19 +0200, Takashi Iwai wrote:
> Some drivers have the independent PCM IEC958 status bits while many
> have only the default IEC958 status bits.  In the former case, the
> driver resets automatically the status bits after closing the PCM
> stream.  Your case is the latter one, which doesn't reset.  In this
> case, usually alsa-lib takes the old setting back.  But when the
> program crashes (or aborted unexpectedly), the new setting is kept
> even after that, as you described in the above.

Could you please clarify 
'independent PCM IEC958 status bits' vs 
'default IEC958 status bits', 
perhaps by pointing out some drivers implementing each type?
> 
> > Could someone set me straight here so that I can try to produce a
> > permanent fix for this?
> 
> You can change the status easily via iecset program in alsa-utils.
I note here that iecset does not accept --device=hw:0,1 for example. Any
reason for this?
> 
> Maybe it's safer to have an independent PCM iec958 setting on all
> drivers.  But this requires the change in alsa-lib (system) config,
> i.e. it may cause an incompatibility with older alsa-lib configs.
> This is an only drawback, I think.
I will try to figure this out after I have validated and submitted my
44100Hz patch for ca0106.

Ben.
