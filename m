From: Gareth Duncan <gareth@gduncan.uklinux.net>
Subject: Re: sblive mixer (was: guitar + sblive + ardour + ladspa effects)
Date: Thu, 1 Aug 2002 11:18:05 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208011114.46075.gareth@gduncan.uklinux.net>
References: <E17ZHUa-0008M8-00@usw-sf-list1.sourceforge.net> <1027977926.10978.104.camel@insanity> <1028116511.4043.6.camel@insanity>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1028116511.4043.6.camel@insanity>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 31 July 2002 11:55 am, Bob Ham wrote:
> On Mon, 2002-07-29 at 22:25, Bob Ham wrote:
> > On Mon, 2002-07-29 at 21:53, Paul Davis wrote:
> > > you will also probably want to turn down the line-in level, so that
> > > the direct feed is not audible. that is also an sblive issue.
> >
> > It's, unfortunately, the only issue :/
>
> I want to capture the line-in, but not hear it.  Surely somebody must
> have an idea as to how this can be done?
>
> Bob

Hi,

I don't have the livedrive but to do what you want with the line in on the 
back of the pci card, I do the following.

Load up alsamixer and find the item Line and press space to capture it. Now go 
to the capture item and press space to capture that aswell, you should now 
here the input from the line in. Make sure that the AC97 Capture volume is at 
maximum. Finally reduce the AC97 volume to zero, you should now not be able 
to hear the input from the line in.

I don't know if this is of any help at all, but maybe if you can replace the 
capture of the Line item with the equivalent on the livedrive (whatever that 
might be) it might work.

Bye,

Gareth.

-- 
Ego is the anesthetic given by a kindly nature to relieve the pain
of being a damned fool.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
