From: Dan Hollis <goemon@anime.net>
Subject: Re: more sample formats?  too little place left.
Date: Mon, 10 Jun 2002 13:46:04 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206101345270.4086-100000@sasami.anime.net>
References: <s5hk7p72o1h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7p72o1h.wl@alsa2.suse.de>
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

On Mon, 10 Jun 2002, Takashi Iwai wrote:
> i talked (yes, physically!) with Jaroslav about this issue.
> our conclusion is to extend the snd_pcm_hw_constraints_t struct,
> namely, using char arrays instead of int for mask bits.

you mean represent each mask bit with separate ascii character?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
