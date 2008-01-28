From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: es1938 - patch trying to improve capture hw
	pointer reads: log file
Date: Mon, 28 Jan 2008 23:38:58 +0100
Message-ID: <20080128223858.GA14943@lemon.iwr.uni-heidelberg.de>
References: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
	<s5hr6g74f8d.wl%tiwai@suse.de>
	<20080124152102.GE8290@lemon.iwr.uni-heidelberg.de>
	<s5hwspz2pwd.wl%tiwai@suse.de>
	<20080125002514.GA9015@lemon.iwr.uni-heidelberg.de>
	<s5h3asm2nib.wl%tiwai@suse.de>
	<20080125160727.GF9123@lemon.iwr.uni-heidelberg.de>
	<s5hy7adj2s7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de
	[129.206.100.212])
	by alsa0.perex.cz (Postfix) with ESMTP id BA6FE2451C
	for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 23:39:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy7adj2s7.wl%tiwai@suse.de>
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2008 at 05:19:52PM +0100, Takashi Iwai wrote:
> At Fri, 25 Jan 2008 17:07:27 +0100,
> Hermann Lauer wrote:
> > 
> > On Fri, Jan 25, 2008 at 11:44:12AM +0100, Takashi Iwai wrote:
> > > > > Then a question arises - why DMAADDR isn't used as the primary source
> > > > > at all?  Is it less stable than DMACOUNT in some cases?
> > > > 
> > > > I don't know and the current implementation contains only a "don't ask why - AB"
> > > > comment.
> > > > 
> > > > To reiterate: My proposed patch is about minimising the chance that a
> > > > wrong hw pointer value is given back due to garbage read from the chip. If
> > > > you are interested, I can send you debugging output which shows
> > > > that both DMAADDR and DMACOUNT are read out as bogus values
> > > > from time to time - one or the another, or both. I tried some
> > > > status flags on the chip, but alway found cases where it's
> > > > not clear if and which one of the two is correct.
> > > 
> > > Yeah, it would be helpful to understand the problem more correctly.
> > 
> > Will put together some of the log files next week.
> > Up to what size could/should  I cc to the list without upsetting people ?
> > I guess compressing them will yield only a few KBytes.
> 
> Not sure about the size limit, but it'd be better to attach a
> compressed file.  Or just cut out only the interesting part.

Appended is a logfile part. The interresting parts are the diff vlaues (1 if DMACOUNT and ADDR are
read correct), DMA count, addr and probably status. Status is 0xf when the DMA engine resets
the DMAADDR to it's starting value, 0 in all other normal cases.

DMAADDR is reread for the debug output from the chip, so it's sometimes not the value
used in the diff calculation.

Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--LQksG6bCIzRHxTLp
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="kern.log.full.gz"
Content-Transfer-Encoding: base64

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
tLbQ/wfLUNzJMuMAAA==

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--LQksG6bCIzRHxTLp--
