From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: need help understanding overrun/underrun
Date: Fri, 20 Aug 2010 11:49:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008201146200.10278@eeebox2.perex-int.cz>
References: <98769532B4BB14429434178695419EAE0523526CDA@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AD2AD24506
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 11:49:33 +0200 (CEST)
In-Reply-To: <98769532B4BB14429434178695419EAE0523526CDA@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Aug 2010, Harsha, Priya wrote:

> Hi
>
> I had modified the arecord application to call snd_pcm_writei() with the 
> output of snd_pcm_readi(). Basically a loopback.
>
> When we execute, I see the calls return EPIPE (lot of overruns and a few 
> underruns). Can anyone help me understand why there are underrun/overrun 
> being printed? Is it because of the serial call of reads and writes? Is 
> there any issue with the driver I am using? Can you suggest some ways to 
> overcome these messages?

You must queue playback with more samples at the beginning (to 
setup the output latency) otherwise you get the output underrun 
immediatelly. See alsa-lib/test/latency.c for an example.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
