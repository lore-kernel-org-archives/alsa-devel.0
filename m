From: Karl Swisher <k_swisher@frontier.com>
Subject: PreSonus Information For Developers
Date: Thu, 07 May 2015 22:09:49 -0400
Message-ID: <554C1AED.7070503@frontier.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filter01.dlls.pa.frontiernet.net
 (filter01.dlls.pa.frontiernet.net [199.224.80.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 109152610A6
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 04:10:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter01.dlls.pa.frontiernet.net (Postfix) with ESMTP id D31D61FE476
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 02:10:01 +0000 (UTC)
Received: from relay02.dlls.pa.frontiernet.net ([199.224.80.245])
 by localhost (filter01.dlls.pa.frontiernet.net [199.224.80.228]) (amavisd-new,
 port 10024)
 with LMTP id MElvrVFsvwr4 for <alsa-devel@alsa-project.org>;
 Fri,  8 May 2015 02:09:50 +0000 (UTC)
Received: from client.karlnet.net (unknown [184.13.130.14])
 by relay02.dlls.pa.frontiernet.net (Postfix) with ESMTPA id 73D064A05B
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 02:09:49 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA-DEVEL <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

     I have what might be useful information to some developers but I do 
not sure who or how to contact the right people.  I recently purchased a 
PreSonus StudioLive AI 32.4.2 mixer.  Have it half way working under 
Linux.  This mixer has a network connection in addition to the firewire 
interface.  I've installed their software under VirtualBox and ran 
tcpflow capturing packet content between the computer and the mixer.  I 
have started creating text files of the packets of which below is an 
example of their software performing functions like the mixer booting, 
backing up, restore, and selecting the digital output channels 33 
through 48.

55 43 00 01 06 00 4b 41 65 00 64 00
55 43 00 01 06 00 4b 41 65 00 64 00
55 43 00 01 06 00 4b 41 65 00 64 00
55 43 00 01 06 00 4b 41 65 00 64 00
55 43 00 01 06 00 4b 41 65 00 64 00
55 43 00 01 06 00 4b 41 65 00 64 00
55 43 00 01 06 00 4b 41 65 00 64 00
55 43 00 01 1d 00 46 52 65 00 64 00 01 00
Listpresets/scene 00 00

55 43 00 01 1b 00 46 52 65 00 64 00 01 00
Listpresets/channel 00 00

55 43 00 01 19 00 46 52 65 00 64 00 01 00
Listpresets/geq 00 00

55 43 00 01 19 00 46 52 65 00 64 00 01 00
Listpresets/reverb 00 00

     I'm trying to separate out the bin code from the text.

     Does anyone here know if there is value in this information or 
anyone that might want it?  Have a few functions decoded in the format 
above.

Thanks
Karl
