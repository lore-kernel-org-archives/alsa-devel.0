From: sion@gmx.de
Subject: alsa or jack?
Date: Mon, 5 Aug 2002 14:06:22 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8724.1028549182@www15.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx0.gmx.net (mx0.gmx.net [213.165.64.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id OAA26308
	for <alsa-devel@alsa-project.org>; Mon, 5 Aug 2002 14:06:59 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm going to write a program whitch should get the audio-data from 8-10 mono
audio channels, and for example save it to a file. Latency is absolutely no
problem, but xruns wouldn't be very nice.
My questions: 
1. Should I use ALSA directly or via Jack? I remember some people saying
Jack would be easyier. Can Jack handle 10 channels?
2. Is it always (i.e. with all soundcards) possible to open the channels in
non-interleaved-mode?

Thanks,
 Florian Bartels

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
