From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Sound programming confusion
Date: Thu, 26 Feb 2004 19:05:41 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403DC4F5.1080503@boosthardware.com>
References: <1077736614.19756.44.camel@localhost.localdomain> <1077770359.23452.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ken Bass <kbass@kenbass.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Ken Bass wrote:
> Here is another questions (to make it easier):
> 
> 7) How do I do accomplish this using an asoundrc file? I can't even
> figure that out. I've got an SB Live! 5.1 (EMU10K1).
> How do I 'simply' setup 2 'streams' (not sure I'm using the correct
> terminology).
>   The first stereo 'stream' would output to the front L/R speakers at
> 25kHz. This first stream would only require an input 'wav' file of 2
> channels (stereo).
>   The second 'stream' would output to the rear L speaker at 22050Hz.
> This second would only require an inpt 'wav' file of 1 channel (mono).
> 
>   I mean under OSS this is so simple! Open /dev/dsp at 25kHz and open
> /dev/dsp1 at 22050Hz. Unfortunately, I cannot get the routing to work
> reliably under OSS which is why I'm attempting the world of ALSA. 
>

use:

	hw:0,0
  	hw:0,1

They should be seperate subdevices for that card.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
