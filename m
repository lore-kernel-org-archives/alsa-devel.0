From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Two sound cards, only sound out of one
Date: Thu, 28 Aug 2003 21:16:23 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062130583.3028.0.camel@Wizard.knechthome.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
	 <s5hptiu80km.wl@alsa2.suse.de>
	 <20030829132114.4f0ef4f6.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030829132114.4f0ef4f6.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-08-28 at 20:21, Erik de Castro Lopo wrote:
> > also, you can try to swap the card order,
> > 
> > 	options snd-ens1371 index=1,0
> 
> Tired this, ran "update-modules" and restarted alsa.
> 
> This changes the way that the two cards are listed in the /proc/asound/cards
> output but otherwise not much else changes. The same physical card that works
> before still works while the one that never worked still doesn't work.
> 
> Erik

I'm sure you've tried this, but if the card that doesn't work in this
configuration is the only card in the system, does it work?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
