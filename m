From: Ville Herva <vherva@v.iki.fi>
Subject: Re: ice1724 M-Audio Revolution 5.1 support?
Date: Tue, 18 Oct 2005 13:08:33 +0300
Message-ID: <20051018100833.GA20424@v.iki.fi>
References: <s5hu0ffkxgx.wl%tiwai@suse.de>
Reply-To: v@iki.fi, alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hu0ffkxgx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2005 at 11:04:14AM +0200, you [Takashi Iwai] wrote:
> At Mon, 17 Oct 2005 22:21:56 +0300,
> Ville Herva wrote:
> > 
> > Hi,
> >  
> > is support for M-Audio Revolution 5.1 planned? It appears quite similar to
> > 7.1. I tried the monkey-see-monkey-do approach, and simply added the device
> > ID to the driver (see the attached patch against 2.6.14-rc4), but that
> > doesn't quite work - I get
> >  
> >    alsa_setup(): Sample format not available for playback: Invalid argument

(That error was from xmms)

> If you used "hw" PCM, the above is no fatal error.
> ICE1724 supports only 32bit format.  For playing 16bit or other
> formats, you have to convert it via plug layer.  For example,
> 
>       % aplay -Dplughw foo.wav
> 
> But, the default configuration is already like above, so even just
> "aplay foo.wav" should work.

I'm not at the computer that has the card so I can't verify I get sound, but
at least the aplay command above does not give an error :).

Any idea how I should configure xmms to do the same? There are three MAudio
devices in the ALSA settings tab in xmms, and every one of them gives the
error above.


Thanks!


-- v -- 

v@iki.fi



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
