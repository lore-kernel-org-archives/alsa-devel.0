From: "cjs 2895" <cjs2895@hotmail.com>
Subject: Requesting guidance
Date: Mon, 15 Apr 2002 22:36:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F38tK01svuQRg5YbhEH00010225@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Howdy folks,

I've got an idea for a game I'd like to build for my kids. To make it work 
like I want I need to have four mono sound channels feeding into four 
physical speakers. To make that work it looks like my options are:
  1) Use four separate sound cards (PCI or USB)
  2) Do some coding to use each channel in a sound card to drive a
     separate speaker.
I like option two the best because its cost effective, and I think the newer 
Sound Blaster cards will drive four speakers (even if not, two cards is 
better then four). Unfortunately I don't
think Linux's OSS can handle either of these options so now I'm looking to 
Alsa as a solution. From reading the Alsa manual it looks like I can do what 
I want by interleaving the sound buffers in one memory space. Is that the 
best approach? Its been a week since I read the manual, so I don't recall if 
I can do something like a select() loop to feed data to the sound cards as 
needed, but I'm thinking that would be easier if the method is available. 
Can anyone give me some guidance on how to proceed? I would appreciate it. 
Also, I haven't bought any sound cards yet, so if there is another make that 
might be better suited for this application (and is also cheap) please clue 
me in.

Thanks,
Christopher



_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx
