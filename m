From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: GUS driver status : multiple open of /dev/dsp ?
Date: Fri, 7 Jun 2002 02:43:58 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020607024358.A29561@sci.fi>
References: <3CFF2B90.6050304@cmi.univ-mrs.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CFF2B90.6050304@cmi.univ-mrs.fr>; from vanackere@cmi.univ-mrs.fr on Thu, Jun 06, 2002 at 11:29:52AM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Vincent Vanackere <vanackere@cmi.univ-mrs.fr>
Cc: alsa-devel@lists.sourceforge.net, Vincent Vanackere <vanackere@gyptis.univ-mrs.fr>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 06, 2002 at 11:29:52AM +0200, Vincent Vanackere wrote:
> Hi,
> 
> I'm sorry to ask such a common question here, but I'd like to know if
> it is possible to configure my (old) Gravis Ultrasound ISA PnP card in 
> order to enable multiple open of /dev/dsp with alsa.

Should be possible. With a GUS PnP you have to use the second pcm device.
first one is the codec and second is the synth. That would be mapped to
/dev/adsp for OSS emulation. You have to pass the snd-interwave module
snd_pcm_channels=n parameter where n is from 2 to 16.

The problem with GUS synth is that it uses non-interleaved data layout so
it's not relly useful for pcm stuff. alsa-lib doesn't want to do
the required conversion for some reason. Interwave supports also
interleaved DMA but the driver doesn't use this feature.

One way of using it currently is having multiple mono wavs.
"aplay -D plughw:0,1 -c 1 -I mono.wav" will play one file. You can use
that multiple times at the same time or you can specify all the files at
once "aplay -D plughw:0,1 -c N -I mono1.wav mono2.wav ... monoN.wav".

OK. I just checked and it only works with one or two channels per aplay.
So if you want more channels you'll have to run multiple aplays
simultaneosly.


And the obligatory ad... :)
If you really want to use hardware mixing you can try the mikmod driver I
wrote. It requires CVS version of alsa-lib or a patch. Both are at 
"http://www.saunalahti.fi/~syrjala/alsa/"


Great card BTW :) Well apart from the nasty hissing bug. I have one with
16 MB memory. A really nice card with Utopia soundbank. If only Jaroslav
would have the time to add MIDI emulation to the driver...

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
