From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: GUS driver status : multiple open of /dev/dsp ?
Date: Sat, 8 Jun 2002 01:41:57 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020608014157.A9573@sci.fi>
References: <20020607163222.A25401@sci.fi> <E17GMUB-0000Vj-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17GMUB-0000Vj-00@usw-sf-list1.sourceforge.net>; from pbd@op.net on Fri, Jun 07, 2002 at 12:22:02PM -0400
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

On Fri, Jun 07, 2002 at 12:22:02PM -0400, Paul Davis wrote:
> >On Thu, Jun 06, 2002 at 09:20:31PM -0400, Paul Davis wrote:
> >> >The problem with GUS synth is that it uses non-interleaved data layout so
> >> >it's not relly useful for pcm stuff. alsa-lib doesn't want to do
> >> >the required conversion for some reason.
> >> 
> >> i find this very suprising and somewhat hard to believe. the
> >> hammerfall also uses a non-interleaved data layout (as all the best
> >> cards do :), and yet despite the fact that the driver contains no code
> >> to handle an interleaved stream, aplay via plughw:N,0 works just
> >> fine i.e. alsa-lib handles the conversion perfectly. what makes you
> >> think it doesn't work?
> >
> ># aplay -D plughw:0,1 stereo.wav
> >aplay: set_params:754: Access type not available
> 
> can you try it with the -I option, and also the -m option (in all
> combinations)?

I wont be able to do any testing until next week. I know -I works but
AFAIK only with mono files. As I said it only works with up tp two files.
Due to channels_max being hardcoded to 2 in snd_pcm_hardware_t. -I sets
the access type to noninterleaved so it's not really the problem here.

Did you mean -M as in mmap? It's not supported anymore. There used to be
some ugly hack to make it work but Jaroslav threw it out. It's interesting
to note that capture claims to support mmap (I haven't tested). I don't
understand what the actual problem with mmap and playback is. You'd have
to ask Jaroslav.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
