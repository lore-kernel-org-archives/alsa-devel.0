From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: (Terratec DMX Xfire seems to not have any secondary
 CODEC)
Date: Fri, 02 Aug 2002 20:30:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4ACFD2.9050206@cucumelo.org>
References: <5423.1028299729@www15.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA08356
	for <alsa-devel@alsa-project.org>; Fri, 2 Aug 2002 21:21:01 +0200
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
>the Terratec DMX Xfire has got one(1) codec chip:
>
>C (that's the Crystal logo of cirrus logic)
>4294-JQ EP
>(ZTAHKE0109)
>
>the following link says
>"CS4294 CrystalClear 4channel
>AC97"
>http://www.plasma-online.de/index.html?content=http%3A//www.plasma-online.de/english/identify/picture/crystal.html
>
>but i don't know which version of AC97...
>
That's a good explication why it dont detect the secondary codec.
I've been reading the DataSheet of the 4294, and the CODEC is equiped 
with two DAC's it's possible
to address each DAC independently, in that way having 4 independent 
channels with one CODEC.

On the Hercules Game Theater XP (i believe) that the primary CODEC gives 
output to front L/R headphones L/R,
the secondary rear L/R , center and subwoofer. Which in theory should be 
8 indpendent channels, but you may want
the same output in fron L/R and headphones L/R, the 4294 CODEC is 
default programmed to give the same output in
both channels (so far I can understand from the bloody spec.) which 
explain why the headphones works fine with the  Hercules Game Theater 
XP, but dont explain why I got no output from center and subwoofer, and 
dont explain why there is not
any output from all 4 channels on the Terratec board.

In conclusion, with the Terratec board we need to a different setup on 
the CODEC, and probably some different setup on
the DSP to make the 4 channels work. And hopefully there is no unkown 
GPIO to take care of.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
