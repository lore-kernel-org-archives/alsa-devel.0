From: Ann Patterson <annp322@sbcglobal.net>
Subject: Re: M-Audio Revolution and MythTV
Date: Mon, 08 Mar 2004 20:58:27 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078808306.5620.17.camel@localhost.localdomain>
References: <1078107493.5239.19.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0403010917310.1870@pnote.perex-int.cz>
	 <1078285146.5239.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078285146.5239.59.camel@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-03-02 at 19:39, Ann Patterson wrote:
> On Mon, 2004-03-01 at 00:17, Jaroslav Kysela wrote:
> > On Sun, 29 Feb 2004, Ann Patterson wrote:
> > 
> > > I installed a M-Audio Revolution 7.1 (snd-ice1724) in my mythtv box. I
> > > had mythtv working fine with the machine's onboard sound (snd-trident)
> > > using OSS emulation. The revo works correctly for things like xine,
> > > mplayer, aplay (of course), play, etc. In mythtv, however, I get no
> > > sound. 
> > > 
> > > I dug into the mythtv code, and found that it is doing a call to
> > > ioctl(audiofd, SNDCTL_DSP_GETOSPACE, &info) and using the info.bytes
> > > value that is returned to determine whether or not to write to the card.
> > > The first call to SNDCTL_DSP_GETOSPACE appears to return a reasonable
> > > number, but from that point, the numbers returned are all over the
> > > place, and are often negative. So, mythtv, of course, won't write to the
> > > card. I find that if I comment out the code that checks the values
> > > returned from GETOSPACE, I get sound, but it is out of sync with the
> > > video (sound slightly behind video).
> > > 
> > 
> > Can you write a nice small test code which shows this problem? You may 
> > modify code in alsa-oss/test/osstest.c .
> > 
> > 						Jaroslav
<snip>
> 
> Let me know if you need anything else, or if I'm doing something wrong.
> 
> Ann P.
> 

I have this sorted out. According to the OSS docs, the values returned
by SNDCTL_DSP_GETOSPACE are only defined if the application is writing
full fragments. Mythtv was writing partial fragments, then checking the
value returned from GETOSPACE. For pretty much every other card, this
works fine. For the M-Audio card, bad things happen. When I changed
mythtv to write full fragments, the problem went away.

Ann P.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
