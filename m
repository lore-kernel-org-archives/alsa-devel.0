From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Re: [Alsa-user] Re: Re: SB Live! PCM control
Date: Fri, 11 Feb 2005 18:08:24 +0100
Message-ID: <m2d5v7hvnb.fsf@vador.mandrakesoft.com>
References: <420270C1.3000706@voicenet.com>
	<1107457227.7256.37.camel@krustophenia.net>
	<4202A72C.3000007@superbug.co.uk>
	<1107645609.7256.73.camel@krustophenia.net>
	<420C0C89.1010008@voicenet.com> <s5hr7jnza3t.wl@alsa2.suse.de>
	<Pine.LNX.4.58.0502111103140.2300@pnote.perex-int.cz>
	<s5hk6pfz7nx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hk6pfz7nx.wl@alsa2.suse.de> (Takashi Iwai's message of "Fri,
 11 Feb 2005 11:56:50 +0100")
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
Cc: Jaroslav Kysela <perex@suse.cz>, Adam K Kirchhoff <adamk@voicenet.com>, Lee Revell <rlrevell@joe-job.com>, James Courtier-Dutton <James@superbug.co.uk>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > > IMO, a "Master" volume should control all volumes as it name
> > > stands.  If it doesn't control all channels, it should be
> > > renmaed at least as "Front".
> > 
> > Yes, renaming is appropriate. I don't like to have some
> > "abstraction" code in the kernel. In case of SB Live! you must
> > take care about AC97 and DSP setup which is easy to do from the
> > user space and there is a way to do it now (via the user space
> > controls).
> 
> I'm afraid that just renaming wouldn't be enough from the
> perspecitve of compatibility.  Some apps expect that the master
> control is available.  If a small additional DSP code can support
> the consistent volume control over all channels, it will make 99%
> users happy.

indeed.
on the second hands, such apps will usually be able to use the OSS
emulation layer.
where is redirected the OSS'main level in this case?



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
