From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Audigy 2: How does one switch off the filters/interpolators?
Date: Wed, 27 Aug 2003 17:39:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4CDEB8.6090806@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I have started work on getting AC3 passthru working on the Audigy 2.
So far I have established that some sort of filtering is happening 
between the computer PCM and the DSP.
I can currently send samples to the DSP, and then grab them off the DSP 
into a file, and then compare the two.
I have heard that there is a way to switch off the 
filtering/interpolating hardware so that passthru works.

If I send the following samples: -

0 0 0 0 0x500 0x500 0x500 0x500 0x500 0x500 0x500 0x500
I get back something like
0 0 0 0 0x010 0x080 0x200 0x400 0x499 0x499 0x499 0x499

So, there is obviously a high pass filter in there to stop "click" 
sounds reaching the speakers.

Can anybody describe how to switch off this filter/interpolator on the 
Audigy 2 ?

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
