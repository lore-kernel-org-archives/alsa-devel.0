From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: GUS driver status : multiple open of /dev/dsp ?
Date: Wed, 12 Jun 2002 17:33:45 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020612173345.A53@sci.fi>
References: <20020607163222.A25401@sci.fi> <Pine.LNX.4.33.0206110902100.509-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0206110902100.509-100000@pnote.perex-int.cz>; from perex@suse.cz on Tue, Jun 11, 2002 at 09:04:08AM +0200
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

On Tue, Jun 11, 2002 at 09:04:08AM +0200, Jaroslav Kysela wrote:
> On Fri, 7 Jun 2002, [iso-8859-1] Ville Syrjälä wrote:
> 
> > On Thu, Jun 06, 2002 at 09:20:31PM -0400, Paul Davis wrote:
> > > >The problem with GUS synth is that it uses non-interleaved data layout so
> > > >it's not relly useful for pcm stuff. alsa-lib doesn't want to do
> > > >the required conversion for some reason.
> > > 
> > > i find this very suprising and somewhat hard to believe. the
> > > hammerfall also uses a non-interleaved data layout (as all the best
> > > cards do :), and yet despite the fact that the driver contains no code
> > > to handle an interleaved stream, aplay via plughw:N,0 works just
> > > fine i.e. alsa-lib handles the conversion perfectly. what makes you
> > > think it doesn't work?
> > 
> > # aplay -D plughw:0,1 stereo.wav
> > aplay: set_params:754: Access type not available
> > 
> > There is a snd_pcm_plug_change_access() function in pcm_plug.c so I'm
> > thinking it should work, but it doesn't.
> 
> Could you try alsa-lib from current CVS? The problem is, that GUS Synth 
> PCM device doesn't support mmaped access at the time, so mmap emulation in 
> alsa-lib should be turned on. I've added a GUS.conf file to 
> /usr/share/alsa/cards with redefinition of pcm.hw (mmap_emulation is set 
> to on).

No help from this. With or without -M.

$ aplay -D plughwtu:0,1 foo.wav 
Playing WAVE 'foo.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Stereo
ALSA lib pcm_plug.c:657:(snd_pcm_plug_hw_refine_schange) Unable to find an
usable access for 'plughw:0,1'
aplay: set_params:754: Access type not available


BTW you forgot to add GUS.conf to Makefile.am.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
