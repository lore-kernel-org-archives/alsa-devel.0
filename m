From: Martin Langer <martin-langer@gmx.de>
Subject: [RFC] re-queuing usx2y-fw
Date: Mon, 28 Mar 2005 17:51:51 +0200
Message-ID: <20050328155151.GA3552@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id CF12021F
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 17:52:27 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.44)
	id 1DFwWt-0000wi-FF
	for alsa-devel@alsa-project.org; Mon, 28 Mar 2005 17:51:51 +0200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

long time ago there was a thread about replacing tascam_loader.ihx with 
an open firmware:

http://sourceforge.net/mailarchive/message.php?msg_id=8555003

http://www.langerland.de/audio/usx2y/usx2y-fw-0.1b.tar.bz2

All results were quite positive and I've had a lot of downloads since 
them on my site and I never ever got a bugreport about it :)

What about a second attempt of merging it into alsa-firmware? Any new 
strategies for this step? The code still depends on as31 (8031/8051 
crosss-assembler) which still isn't available as .rpm or .deb, at least 
newer versions since 2.1. Should we care about it?

I use it on my US-122 since several months without problems and we have 
positive results from us224 and us428 owners. Even the size has only 20 
percent of the size of the original tascam file. Aren't these good 
reasons for deleting the original closed source file?

Another point is the license note in the README file for those Tascam 
files. Is it really true for tascam_loader.ihx? I (we?) know that 
tascam_loader.ihx and MidiSportLoader.ihx (for M-Audio MidiSport's) are 
100% identical; there's no difference. So I believe that this file is 
part of the same 3rd party development kit and is not be copyrighted by 
Tascam? I don't know it, but Tascam should know it better... just my 
two cents.


bye,
martin

 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
