From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: More CS4630, secondary CODEC output.
Date: Sat, 27 Jul 2002 17:13:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020727151347.GA1991@idefix.fvdpol.home.nl>
References: <3D41D4DC.60004@cucumelo.org> <20020727003649.GA5560@porky> <3D4245A1.3020302@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail2.home.nl (mail2.home.nl [213.51.129.226])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA12438
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 17:13:54 +0200
Content-Disposition: inline
In-Reply-To: <3D4245A1.3020302@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sat, Jul 27, 2002 at 09:02:57AM +0200, Benny Sjostrand wrote:
> >   And to those with Santa Cruz cards, after my first (quick) test the 
> >rear
> >channel doesn't seem to work... yet. 
> 
> Well, you dont seems to any luck ... no SPDIF, no rear sound -:(
> Do you know which CODEC's you card have ??, are AC97 2.0 or AC97 1.03
> 

Turtle Beach Santa Cruz boards have:

CS4630-CM DSP, 
CS4294-JO codec, 
CS4297A-JO codec

the board supports 4 analog inputs + 6 analog outputs (I use it for
multi-track recording). One thing that might cause for the driver is that it
has one 1/8" jack, the 'versa jack' that combines multiple (selectable)
functions:

- analog in (channel 3+4)
- analog out (channel (5+6)
- digital out (spdif+ac3; these are different signals on the tip/ring of the
  mini jack)

Frank.


-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
