From: Steffen Sauder <steffensauder@gmx.de>
Subject: Re: OSS emulation delays (?)
Date: Fri, 24 Oct 2003 14:49:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F992DF7.9090002@gmx.de>
References: <20031023124542.0868bfd8.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031023124542.0868bfd8.rpav@mephle.com>
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

I've had similar problems with mplayer and my Terratec DMX 6fire (also 
ice1712)

>  MPlayer isn't quite so slow, but there is a decent pause
>while seeking in movies. 
>
I've had this problem with mplayer and oss emulation since alsa 0.9.3 i 
think (not quite sure). In older versions it
worked fine, but in newer versions and the current cvs it takes about a 
second for mplayer to skip anywhere. I didn't have this problem with any 
other app than mplayer though.

> With the xmms ALSA driver, this is not a
>problem.  Unfortunately mplayer and ALSA don't seem to get along with
>my card (ice1712... maudio delta-44), but with audio disabled seek
>times are fine.
>  
>
Same problem here again, mplayer's alsa-output has been broken for me 
since I have that card (1.5 years). Audio seems to be running fine, but 
video plays at about one fps, and after few seconds the 
"buggy-audio-driver" message pops up. Because mplayer is the only app 
having problem with the alsa-driver, I always thought it was mplayer's 
bug, but I didn't dare to post on their mailinglists :o).

I ended up using arts, because it works perfectly with the ice1712 
drivers and both xmms and mplayer.

gruss
Steffen



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
