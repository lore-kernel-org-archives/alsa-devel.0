From: knuarv@nith.no
Subject: Re: Set up buffers for individual channels?
Date: Tue,  8 Apr 2003 20:38:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049827096.3e9317183693a@webmail.nith.no>
References: <1049752146.3e91f2525897f@webmail.nith.no> <s5hllylq93e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllylq93e.wl@alsa2.suse.de>
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

Quoting Takashi Iwai <tiwai@suse.de>:

> At Mon,  7 Apr 2003 23:49:06 +0200,
> knuarv@nith.no wrote:
> > 
> > After browsing through the ASIO SDK I see that one can enable individual 
> > channels of a card, and only enabled channels will have a buffer set up for
> 
> > them. Is there a similar way to specify the exact channels one wants to
> access 
> > using Alsa (instead of simply number of channels)? 
> 
> how about accessing via non-interleaved mode?
>
I'm experimenting with non-interleaved mmap now, but I can't say I understand 
the workings of Alsa yet. From what I can see Alsa sets up memory areas for the 
requested amount of channels (from 0 to 9 for instance), so I can choose myself 
which buffers to actually use? I was thinking I could perhaps specify _which_ 
channels I want to use, and get handed buffers for only those channels. No 
biggie, just need to get to know the interface a bit more.

A




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
