From: Vincent Vanackere <vanackere@cmi.univ-mrs.fr>
Subject: Re: GUS driver status : multiple open of /dev/dsp ?
Date: Fri, 07 Jun 2002 15:41:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D00B7F3.4010805@cmi.univ-mrs.fr>
References: <3CFF2B90.6050304@cmi.univ-mrs.fr> <20020607024358.A29561@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ville Syrj=E4l=E4 wrote:
> On Thu, Jun 06, 2002 at 11:29:52AM +0200, Vincent Vanackere wrote:
>=20
>>I'm sorry to ask such a common question here, but I'd like to know if
>>it is possible to configure my (old) Gravis Ultrasound ISA PnP card in=20
>>order to enable multiple open of /dev/dsp with alsa.
>=20
>=20
> Should be possible. With a GUS PnP you have to use the second pcm devic=
e.
> first one is the codec and second is the synth. That would be mapped to
> /dev/adsp for OSS emulation. You have to pass the snd-interwave module
> snd_pcm_channels=3Dn parameter where n is from 2 to 16.


So in that case, does it mean that by simply replacing /dev/dsp with a=20
symlink to /dev/sound/adsp, I can have 2 different (and up to 16...) oss=20
applications transparently accessing the sound card ? However, that=20
sounds too easy to be true... I can't test this right now - I'm at work=20
- but I'll have a try tonight.


> The problem with GUS synth is that it uses non-interleaved data layout =
so
> it's not relly useful for pcm stuff. alsa-lib doesn't want to do
> the required conversion for some reason. Interwave supports also
> interleaved DMA but the driver doesn't use this feature.


I'm a little confused with this: is it related to/does that explain the f=
act
that xmms crashes systematically when I set the alsa output to GUS/synth =
?

Many thanks for your help,

Vincent


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
