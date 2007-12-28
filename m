From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Thu, 27 Dec 2007 18:41:26 -0800
Message-ID: <1198809686.3732.222.camel@razman.gruemaster.com>
References: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
	<1198697428.3732.176.camel@razman.gruemaster.com>
	<BAY109-W373CBC57EE1663E94F98D8A9540@phx.gbl>
	<1198716447.3732.193.camel@razman.gruemaster.com>
	<BAY109-W163C6B7386D97E65192FBBA9540@phx.gbl>
	<75b66ecd0712270942w3a2d1ab5h26647304dddae3ee@mail.gmail.com>
	<1198805106.3176.5.camel@localhost.localdomain>
	<BAY109-W26A10E12EBD66E23EA9FA7A9550@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 167C924497
	for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2007 03:41:30 +0100 (CET)
In-Reply-To: <BAY109-W26A10E12EBD66E23EA9FA7A9550@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: De Fuuss <fuuss@hotmail.com>
Cc: Jiang zhe <zhe.jiang@intel.com>, Lee Revell <rlrevell@joe-job.com>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-12-28 at 01:53 +0000, De Fuuss wrote:

> Hi,
> 
> I tried with the corrected syntax (alsamixer -D hw:1,0), to no avail. I get the following:
> 
> # alsamixer -D hw:1,0
> ALSA lib conf.c:3840:(parse_args) Unknown parameter 1
> ALSA lib conf.c:3966:(snd_config_expand) Parse arguments error: No such file or directory
> ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:1,0
> 
> alsamixer: function snd_ctl_open failed for hw:1,0: No such file or directory
> 
> 
> I'm not sure I understand your question about extending the jacks. The SG33G5M has indeed 5 jacks on the back:
> 
> 1 front out l/r
> 1 center/bass
> 1 sourround back l/r
> 1 side sourround
> 1 line in
> 
> + an spdif out
> 
> All the jacks are directly soldered on the motherboard. The XPC motherboard is promoted as 7.1 capable.
> 
> The motherboard also exists in a SG33G5M "Deluxe" version with a supplementary spdif in + bluetooth + ...

In that case, try "model=6stack-dig" for your system.   Also, try
"model=6stack-hp".

-- 
Tobin Davis  


Set the cart before the horse.
		-- John Heywood
