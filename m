From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: [PATCH] GUS PCM fixes
Date: Fri, 10 May 2002 18:43:20 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020510184320.A19732@sci.fi>
References: <20020510042042.A8147@sci.fi> <Pine.LNX.4.33.0205101005490.1149-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0205101005490.1149-100000@pnote.perex-int.cz>; from perex@suse.cz on Fri, May 10, 2002 at 10:07:01AM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, May 10, 2002 at 10:07:01AM +0200, Jaroslav Kysela wrote:
> There is no reason to limit playback to 44100Hz. Hardware can do frequency
> shift and interleaving, so although DAC operates at 44100Hz, the 48kHz
> sound can be played.

Ok. Have you taken a look at my other message about my MikMod
driver efforts? I've sent at least three messages related to that. I think
I've narrowed the problem down to voice allocation problems. I'm beginning
to think that you're ignoring me on purpose.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
