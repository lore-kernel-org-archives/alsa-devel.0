From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: M-Audio Delta 1010LT: S/PDIF clock source not
	working
Date: Sun, 7 Apr 2013 21:35:45 +0100
Message-ID: <201304072135.45811.gineera@aspect135.co.uk>
References: <515EEF10.1020007@gmail.com> <5160C35A.8020403@gmail.com>
 <5161A6D3.3060602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net
 [62.24.128.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 549BC265173
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 22:29:38 +0200 (CEST)
In-Reply-To: <5161A6D3.3060602@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 07 April 2013 18:03, Gabriel M. Beddingfield wrote:
> On 04/06/2013 05:52 PM, Jonas Petersen wrote:
> > It seems it's related to the ICE1712... I now tried the Audiophile 2496.
> > Same behaviour! There is no way to clock from external (S/PDIF). The
> > 'Multi Track Internal Clock Default' setting will always override the
> > external clock rate and mess up the capturing.
>
> Well, it /should/ work -- according to the 1010's manual.  I'll bet it's
> some register setting that's missing on the ice1712 -- but I have no
> access to the specs/datasheets/schematics on these things.
>
> I wonder -- did this ever work on Linux?

Can't confirm on Delta 1010 series, but this is/was working on Terratec 
DMX6fire and STaudio DSP2000 (other ice1712 cards) since at least about Alsa 
1.0.12.  More people have the 1010's, so I would expect it has been working 
on those.  However I do seem to remember some relatively recent changes 
related to external wordclock on the 1010; maybe it has been broken?

@Jonas - are you using 'envy24control' to toggle the settings?


Regards

Alan
