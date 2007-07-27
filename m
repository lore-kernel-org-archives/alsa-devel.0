From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 27 Jul 2007 22:16:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0707272207010.7596@tm8103-a.perex-int.cz>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<20070719142440.GA2467@localhost>
	<200707201333.38449.gineera@aspect135.co.uk>
	<200707271720.41278.gineera@aspect135.co.uk>
	<75b66ecd0707270859q33f02d05la5160f3443dc9cc1@mail.gmail.com>
	<20070727103746.30d03e39@localhost.localdomain>
	<75b66ecd0707271238p4f48cf8dhefd990d4d8c1b809@mail.gmail.com>
	<20070727130303.12367928@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 38FDD2442A
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 22:16:45 +0200 (CEST)
In-Reply-To: <20070727130303.12367928@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <stanl@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Jul 2007, stan wrote:

> I really want to avoid rate resampling if I can, while format
> conversion has to occur somewhere in order to match the hardware in
> most cases.  I assume that any format conversion alsa does
> is at least as good as one I would do myself.  While the rate

Not really. If application knows all things, the final code might be much 
more optimized. Alsa-lib has all plugins universal (thus mostly 
unoptimized). For example - attenuation + sample conversion can be 
implemented together, but alsa-lib has two plugins - it means two 
iteration over same data.

> resampling can introduce throughput issues and inaccuracies in the
> sound stream.

I answered this numerous times on this list. We have a function to notify 
the plugins that resampling should be avoided - it's 
snd_pcm_hw_params_set_rate_resample().

hw:x,y,z 		- native device without any conversions
plughw:x,y,z		- device trying to do all conversions for applications
default			- default device with all conversions (mostly
			  pointing to plughw:x,y,z)

And yes, plugin doing all conversions is named "plug". So anywhere where 
"plug" plugin is used, other plugins - including the rate plugin - can be 
dynamically inserted to satisfy application requirements.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
