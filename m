From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Two sound cards, only sound out of one
Date: Thu, 28 Aug 2003 20:37:48 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062128268.2810.6.camel@Wizard.knechthome.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
	 <20030824095120.49055.qmail@web40613.mail.yahoo.com>
	 <20030824203749.27d69196.erikd-alsa@mega-nerd.com>
	 <1061914407.2317.9.camel@Wizard.knechthome.com>
	 <20030829125439.34e60138.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030829125439.34e60138.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-08-28 at 19:54, Erik de Castro Lopo wrote:

> Well if this is a problem with aply, I hope that this might shake it out.
> I really don't have very much free time at the moment and I would prefer
> not to add more variables to the situation because that is only likely
> to confuse the issue.
> 
> Erik

Makes sense not to confuse things, but from my experience aplay really
does strange things based on how many channels the wave file is that
it's playing. Alsa, my experience with aplay is that you cannot control
what output channels it puts audio on. I wouldn't be the least bit
surprised, based on how few multicard setups have been tested, that it
doesn't really send audio to the second card at all, but I've said that
already I think.

As an alternative, what about using Jack, two instances of alsaplayer
and qjackconnect to control where Jack believes it's sending the audio? 

Or maybe something similar on the input side using meterbridge instances
and looking at what signals come in? When Thomas and I were debugging
the HDSP 9652 driver recently it turned out to be a better strategy, in
my case, to look at inputs before I looked at outputs.

Anyway, maybe some of this will give you some ideas. I hope you find the
solution. I'm interested in what you're trying as I'd like to do it
myself one of these days.

Best of luck,
Mark



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
