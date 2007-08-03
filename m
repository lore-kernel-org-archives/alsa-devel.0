From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 3 Aug 2007 15:03:16 +0100
Message-ID: <200708031503.16318.gineera@aspect135.co.uk>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<20070727130303.12367928@localhost.localdomain>
	<Pine.LNX.4.61.0707272207010.7596@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 493F224354
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 16:02:43 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0707272207010.7596@tm8103-a.perex-int.cz>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, stan <stanl@cox.net>
List-Id: alsa-devel@alsa-project.org

On Friday 27 July 2007 21:16, Jaroslav Kysela wrote:
> On Fri, 27 Jul 2007, stan wrote:
> > I really want to avoid rate resampling if I can, while format
> > conversion has to occur somewhere in order to match the hardware in
> > most cases.  I assume that any format conversion alsa does
> > is at least as good as one I would do myself.  While the rate

> I answered this numerous times on this list. We have a function to notify
> the plugins that resampling should be avoided - it's
> snd_pcm_hw_params_set_rate_resample().

Can this function be built into an ALSA configuration file in some way, or can 
it only be called from an app?

Alan
