From: pete <pete@claudia.dyn.dhs.org>
Subject: Accessing 6 channels on CMI8738
Date: Fri, 15 Feb 2002 17:18:25 +1300
Message-ID: <3C6C8C11.5020904@claudia.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi there,

I need to output 3 independent stereo streams on my CM8738, but i'm 
having trouble addressing the card in 'Multi-channel' mode - where I 
should be able to open the first DAC on the card using 6 channels, and 
play interleaved data out of the 3 analog stereo outputs.

I can get 2-channel mode working - i.e. the front DAC works in simple 
stereo, and I can access the second pair of channels i.e. 'rear' using 
hw:0,1, but i can't figure out how to access the last channel pair 
(center/bass) or how to send interleaved data to them all at the same 
time, which would be ideal.

Can anyone give me some hints or skeleton code that puts the CMI8738 in 
a suitable mode and outputs a sine wave on all 6-channels?

Thanks for your time

-Pete


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
