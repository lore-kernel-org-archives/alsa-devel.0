From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: newest versions of cs46xx driver => Terratec Xfire
 recording problem
Date: Sun, 04 Aug 2002 18:30:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4D568E.1010404@cucumelo.org>
References: <19320.1028456242@www15.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA11154
	for <alsa-devel@alsa-project.org>; Sun, 4 Aug 2002 19:20:01 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Friedrich.Ewaldt@gmx.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>
>But now I've got some trouble recording from the soundcard input:
>Trying to record (or using a realtime audio application
>input->process->output), I cannot select the input source any more. Alsamixer shows the capture
>flag at the correct position (e.g. CD or Mic), but hw:0,0 always records the
>output from PCM only.
>I always record (or hear) silence until I produce some PCM output (e.g.
>aplay or a BEEP in a shell). This PCM output gets looped back and I get a
>non-ending loud feedback noise (sounds just like acoustic feedback noise).
>
In fact that I've not tested thoose part yet, so it's that they broken 
as consequence with
all other changes done.

>
>This input problem occurs with the following 2 driver versions:
>
>1.
>alsa-driver-0.9.0rc2-bs20020731.tar.gz +
>alsa-driver-0.9.0rc2-bs20020731.diff +
>additional patch in mail from 1.aug.2002
>
>2.
>cvs snapshot 2002-08-02 
>(I compiled the alsa-driver tree only using "cvscompile" and then "make
>install-modules")
>
>
>The problem seems to be related to the pcm multi support as I can use the
>alsa-driver-0.9.0rc2-bs20020723.tar.gz driver version without this problem.
>
There where many hard && critical changes done between thoose two 
releases, it has
probably become broken.

I will investigate the "recording" part, i believe the problem is 
(hopefully)  easy fixed.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
