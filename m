From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: more sample formats?  too little place left.
Date: Sun, 2 Jun 2002 03:22:00 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020602032200.A19956@sci.fi>
References: <s5h3cw8gzvo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cw8gzvo.wl@alsa2.suse.de>; from tiwai@suse.de on Fri, May 31, 2002 at 04:23:23PM +0200
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

On Fri, May 31, 2002 at 04:23:23PM +0200, Takashi Iwai wrote:
> Hi,
> 
> it seems that USB audio supports 24 bit sample in 3 bytes format.
> and additionally i've found there are 20bit and 18bit sample formats.
> the world is large...
> 
> an arising problem is that the number of formats is limited to 32.
> already 26 format types are used.  the rest are only 6, and not enough
> if we put BE/LE and signed/unsigned for new formats, too.
> 
> how can we solve this?  extend to 64bit?  no, it has too overhead.
> add a new field for special formats?

What do you mean by overhead? Binary compatibility maybe?

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
