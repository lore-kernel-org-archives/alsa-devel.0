From: xavier.allamigeon@free.fr
Subject: ymfpci : four speakers with OSS-emulation
Date: Thu, 14 Mar 2002 14:30:52 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1016112652.3c90a60c61558@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA27989
	for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2002 14:31:00 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cool, it works with aplay ! But the .asoundrc isn't right, you have to change 
it : 
pcm.ch4dup {
             type plug
             slave.pcm surround40
             ttable.0.0 1
             ttable.0.1 1
             ttable.0.2 1
             ttable.0.3 1
     }
and then
aplay -D ch4dup foo.wav will play the sound on the four speakers !!!
 
Otherwise, I have tried aoss, and it doesn't work. Of course, I have added the 
following line to the .asoundrc file
pcm.dsp0 pcm.ch4dup
and then I have tried "aoss tuxracer", and there was no sound in the game. 
But I use the CVS version of alsa-OSS, so maybe there is a bug, I don't know.
Furthermore, why pcm.dsp0 and not pcm.dsp1 or pcm.dsp2 ?

Thank you very much for your great help !
Xavier


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
