From: Preston Kulaga <pkulaga@gmail.com>
Subject: underruns over network
Date: Thu, 13 May 2010 21:09:58 +0000 (UTC)
Message-ID: <loom.20100513T224915-386@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 924242448A
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 23:15:05 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OCfkF-0005g5-Pv
	for alsa-devel@alsa-project.org; Thu, 13 May 2010 23:15:04 +0200
Received: from 97-121-64-10.omah.qwest.net ([97.121.64.10])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 23:15:03 +0200
Received: from pkulaga by 97-121-64-10.omah.qwest.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 23:15:03 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

  I am quite new to ALSA and am having a bit of trouble with underruns.  I am 
working on a voice communication system via udp sockets and am getting underruns
on receiving end very sporadically (capture end is fine).  Have done a great 
deal of reading and searching on reasons for this but am not sure what approach 
is best to limit the underruns.  I must not be transferring the data quickly 
enough over the network before the ring buffer runs out of data, which makes 
sense, but how would you accommodate for this?  I am able to buffer a large 
amount of network data and then playback successfully, but obviously the delay 
induced is so significant that it makes real-time communication impossible.  
If I just recover/prepare the stream after an underrun the audio is horribly 
distorted.  Is there a normal way of dealing with this issue that I am unable
to find?

I would appreciate any insight, guidance, references for any help you can 
give me.  Thank You.
