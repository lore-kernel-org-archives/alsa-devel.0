From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC] SoC WM8940 Driver
Date: Mon, 27 Apr 2009 12:35:40 +0000
Message-ID: <49F5A69C.40406@cam.ac.uk>
References: <49F21310.4060009@cam.ac.uk> <20090425102100.GA4394@sirena.org.uk>
	<49F345A8.1030901@cam.ac.uk> <20090425180346.GA4072@sirena.org.uk>
	<49F599BB.9050805@cam.ac.uk> <20090427122550.GF1760@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-7.csi.cam.ac.uk (ppsw-7.csi.cam.ac.uk [131.111.8.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 59988103819
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 14:35:15 +0200 (CEST)
In-Reply-To: <20090427122550.GF1760@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Apr 27, 2009 at 11:40:43AM +0000, Jonathan Cameron wrote:
> 
>> As in snd_soc_dapm_add_route only mux, switch and mixer controls can take
>> a control element.
> 
> You can modify the core, or if you're not keen on doing that just drop
> this feature for now - it's relatively rarely used.
I'll go with dropping it for now. Too many other things to do and to be
honest it's not a feature I care about.
Definitely one for another day.

Thanks,

Jonathan
