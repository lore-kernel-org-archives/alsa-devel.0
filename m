From: Matt <matt@embeddedalley.com>
Subject: Re: [PATCH] hda: use amp capabilities from afg if amp override not set
Date: Mon, 21 Mar 2005 14:14:18 -0700
Message-ID: <20050321141418.A17346@cox.net>
References: <20050320173605.D10431@cox.net> <s5heke84wg5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5heke84wg5.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Mar 21, 2005 at 08:42:50PM +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 21, 2005 at 08:42:50PM +0100, Takashi Iwai wrote:
> At Sun, 20 Mar 2005 17:36:05 -0700,
> Matt wrote:
> > 
> > Some HDA codec nodes contain an amp, but do not provide local amp
> > capabilities.  In these cases, AC_WCAP_AMP_OVRD is not set so we
> > should query the AFG nid in order to get the general amp capabilities.
> 
> Thanks, applied to CVS now.
> 
> At the next time, could you provide "signed-off-by" line, too, to
> include your credit properly in changelog?

Will do. Sorry, I forgot that this time.

Thanks,
Matt


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
