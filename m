From: "John Brewer" <jbrew8@hotmail.com>
Subject: Big-endian to little-endian conversion
Date: Wed, 28 Sep 2005 15:10:00 -0400
Message-ID: <BAY105-F230240E564304F590D37529F8D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,


I am new to programming with alsa, and recently began by following a 
tutorial published by the Linux Journal 
(http://www.linuxjournal.com/article/6735).  The turotial includes some 
basic record and playback programs that work just fine when used with my 
PC's generic PCI sound card.

I then tried to use the programs to record and play back audio on my MAudio 
Quattro device, but anything recorded would play back as white noise.  
Searching this list's archives, I found some posts that state that the 
Quattro records in big-endian byte order, but plays back in little-endian.  
After reading that thread, I was able to playback my recordings with aplay 
using the plughw interface.  I assume that the plughw interface 
automatically converts the sound clip to the byte order required by the 
Quattro's playback device.

My question is, how I can I convert the data from big endian to little 
endian within my application?  Specifically, how do you convert fromt the 
S16_BE to the S16_BE formats?  I have found lots of information on byte 
order online, but so far have not been able to successfully code a solution 
that works.  Can someone point me in the right direction?

Thanks,

John

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
