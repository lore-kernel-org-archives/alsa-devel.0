From: Raymond <rayau@netvigator.com>
Subject: Re: Volume per voices [Feature Request]
Date: Fri, 29 Jul 2005 20:05:40 +0800
Message-ID: <42EA1B94.3060809@netvigator.com>
References: <Pine.HPX.4.33n.0507280926040.9785-100000@studcom.urz.uni-halle.de> <Pine.LNX.4.61.0507281030580.8458@tm8103.perex-int.cz> <1122539988.42e899d4498f2@mail.e4a.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1122539988.42e899d4498f2@mail.e4a.it>
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

In case of au8830, mono, stereo or quad PCM stream are pass through the 
hardware mixer to the stereo/quad AC97 codec (only front channels will 
pass through the equalizer before it go to AC97 codec)

This means the proposed volume control will have 2/4 values depend on 
the stereo/quad codec on au8830.

The rear speaker of Quadzilla/Home Studio - the addon cards of Turtle 
Beach Montego II is not yet supported.

1) front and rear speakers (Surround40) or
2) 2 speakers and 1 headphone or
3) 2 speakers or
4) 1 headphone

http://www.3dgw.com/hardware/soundcards/msmx300/index.php3

One nifty thing about the MX300 control panel is that it recognizes 
automatically what you have plugged into the Line Out's (speakers or 
headphones)

I think the alsa application need to ask the user for the 
speaker/headphone configuration if it want to support Surround40.


Dino wrote:
> Hi,
>    i'm glad about this interest over this feature. Now i have only a
> question(probably a stupid question): Will be there a problem for a >=
> surround40 device?
> 
> tnx,
>    Dino
> 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
