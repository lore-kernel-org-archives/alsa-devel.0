From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC v2 0/3] ASoC: Option to reorder widget power
	sequence
Date: Tue, 7 Dec 2010 10:51:50 +0000
Message-ID: <20101207105150.GA4698@rakim.wolfsonmicro.main>
References: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101206224008.GA2862@opensource.wolfsonmicro.com>
	<201012071129.15475.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD04410382F
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 11:51:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012071129.15475.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 07, 2010 at 11:29:15AM +0200, Peter Ujfalusi wrote:

> Fair enough.
> I did taken a look at the possibility to do the register update between DAPM 
> power down and up, but I thought it is a bit big change (the place, where the 
> DAPM power down and up happens is quite deep, and I was not sure how to inject 
> things between those).

Stash the callback in the DAPM context - we have to lock the context to
do the path walks anyway so no issue with reentrancy.

> If we do the update at the same time (or around), when the power for the 
> switch would have been enabled, than we are filtering the switching for the 
> DAPM widgets before the switch.

On the other hand it's possible that this will result in a sharp switch
in of a DC offset rather than a slow ramp, and anything doing DC offset
correction is going to want its input to be up before correcting.
