From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Cannot Record with ALSA and emu10k1
Date: Mon, 20 May 2002 11:11:05 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20020520111105.guenther.sohler@newlogic.com>
References: <Pine.LNX.4.31.0202221056550.489-100000@pnote.perex-int.cz>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from enterprise2.newlogic.at (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA16008
	for <alsa-devel@alsa-project.org>; Mon, 20 May 2002 11:11:53 +0200
Received: from enterprise2.newlogic.at (localhost [127.0.0.1])
	by enterprise2.newlogic.at (8.11.6+Sun/8.11.6) with ESMTP id g4K9BBb12572
	for <alsa-devel@alsa-project.org>; Mon, 20 May 2002 11:11:11 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.31.0202221056550.489-100000@pnote.perex-int.cz>
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

Hallo Jaroslav,

I wanted to copy my movies from casette to mpeg, and so i bought a television
card and intended to record movies in linux.
For recording movies you also need sound

On my system there is ALSA with oss emulation. I connected the audio to line in.
The line in signal goes through to the speaker - so i can hear the television
audio. I have put the capture source to 'line in' and have unmuted it. also the
'capture volume slider' is macximum.
In general i have unmuted all the channels und put much volume on them. I even
tried to supply the audio through the mic input.

regardless if i record with arecord or if i do

cat /dev/dsp or /dev/audio

I get no signal(just a lot of 0x00 or 0x80) depends on the format)

Do you have an idea whats wrong ???

Please give me detailled information what i have to do with alsa, hardware and
my soundblaster audixy(emu10k1) to get recording working 


rds guenther

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
