From: Roberto De Leo <deleo@unica.it>
Subject: strange problem with an AWE ISA card
Date: Wed, 05 Mar 2003 22:15:21 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6676F9.7020707@unica.it>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I know this is the developers list but this problem is really odd and it 
seems to me it fits better in this ML.

Here is the problem. I am the author of the eMoviX package, a micro 
Linux distro that makes a CD able to boot and autoplay [with MPlayer] 
all audio/video files it contains.
My hw autodetection system for ISA cards makes use of 
/proc/bus/isapnp/devices but it failed for a user which has a SB AWE 
card. He claims that in the devices file his card is identified as 
"CTL00e3" but in the cardids.txt file that code does not appear anywhere!
I have access to a PC with a similar card and for it I get the code 
"CTL00e4" that is perfectly good.

How come that not all SB AWE card models are supported?
What is, more or less, the percentage of ISA cards covered by cardids.txt?
At this point I need this info since if the percentage is far from 100% 
I'll change hw autodetection system.

Thanks,
  Roberto De Leo



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
