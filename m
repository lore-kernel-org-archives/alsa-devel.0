From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: [Jackit-devel] Multiple cards.
Date: Wed, 12 Jun 2002 22:23:37 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D074B59.6030602@boosthardware.com>
References: <200206121243.g5CChIP04283@post2.fast.net>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "jackit-devel@lists.sourceforge.net" <jackit-devel@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

>>I can hear Paul now saying you have no desire to make this happen 
>>because you do not work with consumer devices. Unless someone paid you 
>>to do it.
> 
> 
> That's correct. Consumer devices are just that. People trying to do
> multichannel work by ganging such devices are engaged in a strategy I
> don't want to support with my own time.
> 

Not even if the reason is to allow cueing of a track. I think it may 
even be possible to allow this to work in sample sync if alsaplayer is 
the app used to play the file.

Eg1. I could cue the file using my headphones channel on a consumer card 
and then click a switch in alsaplayer to allow the file to stream 
through my pro card. As long as the file was paused between switching 
channels it should retain sample sync because alsaplayer is sample accurate.

Eg2. I could set up three channels in ardour mixer for each alsaplayer 
gui and then I just fade them in/out depending on what channel I want to 
hear the file through. This would definitely loose sample sync but could 
allow for some interesting time effects. Do you fancy the idea of 
"ardour dub sessions"?

> 
>>If it is possible to do and the code was written would it be included in 
>>JACK?
> 
> 
> Its possible, and if it was reasonably written, it would be included
> in JACK.
> 

That's good to know.


> 
>>If it is possible to do how much would it cost to have it implemented?
> 
> 
> I don't know. Somebody else would have to do it.
> 

Is there anything that would entice you into whipping it out?

I can send you a sticker if it helps :)



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
