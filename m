From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: changing audio routing through mixer
	controls	with emu10k1/audigy
Date: Mon, 26 Sep 2005 19:43:22 -0400
Message-ID: <1127778203.28523.34.camel@mindpipe>
References: <20050925234658.4d008c9e@VikingPC.home>
	 <1127696645.26124.4.camel@mindpipe> <1127696983.26124.6.camel@mindpipe>
	 <20050926223642.60df06fb@VikingPC.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050926223642.60df06fb@VikingPC.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Corvus Corax <corvus-ml@cybertrench.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-09-26 at 22:36 +0000, Corvus Corax wrote:
> The tools (unlike their OSS counterparts which are segfaulting on this
> arch) are compiling and working on my system, however there is either
> no effect on the DSP, or garbage out of the speaker - while the front
> end seems to be working ( additional mixer sliders and all appear and
> seem to be working, however without any effect on sound output) 

Did you run the init_live script?  This should produce the same mixer
state that the driver contains by default.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
