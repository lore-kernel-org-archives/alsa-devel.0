From: Anders Torger <torger@ludd.luth.se>
Subject: Re: rme96 and adat, problems opening for capture when clock-master
Date: Mon, 1 Jul 2002 19:24:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207011724.g61HOt716880@d1o1116.telia.com>
References: <0ChZyM167A140000.gml@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 01 July 2002 14.29, you wrote:
> Hello,
> I am using a rme 96/8 card.
> I encounter a problem whenever I try to open the adat device, which
> is the second device on the card, for capture. I get an input/output
> error. The problem occurs when I switch from spdif to adat (from
> hw:0,0 to hw:0,1 in my case) _and_ the clock mode is master. If I set
> the card to slave mode and change the settings on my adda converter,
> there is no problem. Playback only will always work.
> So f.i. if I start pd, with hw:0,1 as audio device, I have to start
> once , with an error message that it can't open the card for capture.
> Then I quit, and start pd again.
> The second time it works for capture as well as for playback.
>
> Is this a bug in the driver?

I'm in a mess of work right now, so I cannot look into this for a 
while, but it may be a bug in the driver. ADAT is the least tested mode 
(by me at least).

/Anders  Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
