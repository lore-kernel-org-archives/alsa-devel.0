From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Terratec DMX XFire DSP
Date: Fri, 02 Aug 2002 10:32:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4A4380.3060405@cucumelo.org>
References: <10779.1028274265@www55.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA00682
	for <alsa-devel@alsa-project.org>; Fri, 2 Aug 2002 11:22:22 +0200
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
>regarding your cs46xx DSP and codec list:
>AFAIK the Xfire card has got a CS4624 DSP, not a CS4630. The main (only?)
>difference should be the processing power (CS4624: 255MIPS, CS4630: 420MIPS).
>
Are you sure ?
If the Windows system properties tells say that's a CS4624 it can be 
becourse
it uses the same driver for both cs4630 and cs4624, as they are binary 
compatible.
If you do a "lspci" on Linux it will probably say that it's cs4624/ 
..SoundFusion (something), but does
not mean that the device really has a cs4624.

Just sounds strange for me that Terratec have choosen the cs4624 ....

>
>Are there any more differences you know of?
>Is there any possibility for me to check the codec type of the Xfire card
>e.g. under windows or by looking at the components on the cards?
>
Look at your card physically, you may find the codec chips close to the 
DSP chip.
It would be great if you could do so.

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
