From: Ed Sweetman <safemode@speakeasy.net>
Subject: Re: pcm_peak code in aplay
Date: 04 Jun 2002 10:12:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1023199971.22778.44.camel@psuedomode>
References: <E17EVWP-0002qi-00@usw-sf-list1.sourceforge.net>
	<1023025791.10826.19.camel@psuedomode>  <s5hbsarfhde.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbsarfhde.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

the problem was tha capture flag had to be set for "Capture" in order
for any capturing to be done on any other mixer element (which also
needs a capture flag set) 



On Tue, 2002-06-04 at 06:49, Takashi Iwai wrote:
> At 02 Jun 2002 09:49:51 -0400,
> Ed Sweetman wrote:
> > 
> > Ok, this is strange. arecord is not recording anything from the sound
> > card.  I have done this before with arecord so it's nothing new but now
> > it's like i'm recording silence, no matter if i'm capturing the mic, or
> > line in. Capture volume is way up, it doesn't change anything.  
> 
> did you adjust "AC97 Capture Volume" too?
> emu10k1 has a complex routing, and there are many volumes/switches to
> be adjusted.
> 
> 
> Takashi
> 
> _______________________________________________________________
> 
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
