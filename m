From: Martin Langer <martin-langer@gmx.de>
Subject: Re: rme96 and adat, problems opening for capture when clock-master
Date: Mon, 1 Jul 2002 15:16:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020701131638.GA2265@localhost>
References: <0ChZyM167A140000.gml@xs4all.nl>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <0ChZyM167A140000.gml@xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: vanDongen/Gilcher <gml@xs4all.nl>
Cc: alsa-devel@lists.sourceforge.net, Anders.Torger@xs4all.nl
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 01, 2002 at 12:29:09PM +0000, vanDongen/Gilcher wrote:
> I am using a rme 96/8 card.
> I encounter a problem whenever I try to open the adat device, which is the 
> second device on the card, for capture. I get an input/output error.
> The problem occurs when I switch from spdif to adat (from hw:0,0 to hw:0,1 
> in my case) _and_ the clock mode is master. If I set the card to slave mode 
> and change the settings on my adda converter, there is no problem.
> Playback only will always work.
> So f.i. if I start pd, with hw:0,1 as audio device, I have to start once , 
> with an error message that it can't open the card for capture. Then I quit, 
> and start pd again. 
> The second time it works for capture as well as for playback.
> 
> Is this a bug in the driver?
> 

First a queston for all clockmode users:
Can you set the clock mode to master without specifying a frequency? 

I have no experiences, but I've specified three master modes for the rme32
(for each sample rate). Maybe that's a mistake, but it looks more plausible
for me, than one master mode (like rme96) with an undefined sample rate.

Maybe we need a real experiment here.


martin




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
