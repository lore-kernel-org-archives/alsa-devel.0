From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Re: DSP code for MIDI Reverb
Date: Fri, 22 Feb 2002 12:46:59 +0100 (MET)
Message-ID: <XFMail.20020222124659.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received: from enterprise2.newlogic.com (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA28348
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2002 12:47:33 +0100
Received: from enterprise2.newlogic.com (enterprise2 [172.27.1.1])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id MAA19626
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2002 12:47:00 +0100 (MET)
In-Reply-To: <Pine.LNX.4.31.0202221147510.489-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

hallo jaroslaw,
> No, you don't understand this. The wavetable engine sends to reverb and
> chorus buses samples attenuated as specified in MIDI messages as input for
> the reverb and chorus effects. These samples HAVE NOT the effects
> applied at all. It must be implemented in the DSP engine before the signal
> will be mixed back with the left and right PCM and Music outputs.
sorry for my misunderstanding. Now I presume i understood it and it seems clear
for me.
I presume the TRAM is some sort of big FIFO. 
Are there and dsp algorithms available how to calculate reverb and chorus
effects ?

rds guenther


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
