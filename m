From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: More CS4630, secondary CODEC output.
Date: Sat, 27 Jul 2002 09:02:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4245A1.3020302@cucumelo.org>
References: <3D41D4DC.60004@cucumelo.org> <20020727003649.GA5560@porky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA07530
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 09:53:42 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>    And to those with Santa Cruz cards, after my first (quick) test the 
> rear
> channel doesn't seem to work... yet. 

Well, you dont seems to any luck ... no SPDIF, no rear sound -:(
Do you know which CODEC's you card have ??, are AC97 2.0 or AC97 1.03

The problem is that the secondary AC97 2.0 CODEC uses:
BA0_ACSDA2, BA0_ACCTL, BA0_ACCAD, BA0_ACCDA, BA0_CSTS2
registers, using BA0_ACCTL reigsters TC bit to address primary or 
seconary CODEC.
But seconary AC97 1.03 uses:
BA0_ACSDA2, BA0_ACCTL2, BA0_ACCAD2, BA0_ACCDA,2 BA0_CSTS2
registers to address the secondary CODEC.
(about what I can understand from the bloody spec. )

The case for 1.03 CODEC's is not implemented for the moment, I got no way
to test it.

>
>    Gee, thanks Benny. Just when I was getting used to the dsp_scb layout,
> you change it. ;)  (though I admit it is a _good_ change)

Well, but I got yet another new problem here. the /proc/asound/card0/dsp_scb
entry is to long, and now it's not possible to view all entries, the 
last entries
(SPDIFOSCB, SPDIFISCB and AsyncCODECSCB) are cut of.
Any suggestion about what to do ??

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
