From: Dan Hollis <goemon@anime.net>
Subject: Re: more sample formats?  too little place left.
Date: Tue, 4 Jun 2002 13:55:54 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206041353490.31844-100000@sasami.anime.net>
References: <s5h8z5vffom.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z5vffom.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Jun 2002, Takashi Iwai wrote:
> > Of course you will want a good API support structure for handling format 
> > conversions...
> hmm, i don't think it must be a struct.  enum (int) could have enough
> values if it's not bitmask, although the order of format enumerators
> may look a bit weird.  there are already functions to retrieve a
> detail information from the format type enum, such as
> snd_pcm_format_width() and snd_pcm_format_little_endian().

we want something expandable but avoid ugliness. something that jaroslav 
has been very good at so far (with switches, etc)

65535 different formats should be enough :-) and if there are functions to 
provide detailed descriptions of the formats, i think it's a good 
solution. even if the order of the formats looks strange because more are 
added on later.

> so far, the bitmask is used only inside the alsa-driver and alsa-lib.
> they must be extended in some good way.  i believe that this change
> can be hidden without changing API itself, but not figure out how
> should we do that yet.

and do it right the first time :-)

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
