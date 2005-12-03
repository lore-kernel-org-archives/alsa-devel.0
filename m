From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] Revo 7.1 setup ?
Date: Sat, 03 Dec 2005 14:48:46 -0500
Message-ID: <1133639327.16836.18.camel@mindpipe>
References: <1133636889.4274.7.camel@rousalka.dyndns.org>
	 <1133638082.16836.16.camel@mindpipe>
	 <1133638892.5025.10.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1133638892.5025.10.camel@rousalka.dyndns.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-12-03 at 20:41 +0100, Nicolas Mailhot wrote:
> Le samedi 03 d=E9cembre 2005 =E0 14:28 -0500, Lee Revell a =E9crit :
> > On Sat, 2005-12-03 at 20:08 +0100, Nicolas Mailhot wrote:
> > > Hi,
> > >=20
> > > I'm trying to setup a revo 7.1 in digital out mode (will do 5.1 ana=
log
> > > whenever I receive Y cables).
> > >=20
> > > After much googling the best asoundrc setting I found is :
> > >=20
> > > pcm.!default {
> > >         type plug
> > >         slave.pcm "spdif"
> > > }
> >=20
> > That .asoundrc does nothing that you could not do by setting the app =
to
> > use the "spdif" PCM - it's useless.
>=20
> I don't want to set up apps; I want the default output to be spdif for
> all the system and all apps, regardless of the sound system they use
> (oss, alsa, gstreamer or whatever).
>=20
> without an .asoundrc I get no sound, I suppose it's routed to the analo=
g
> outputs but since they're not cabled yet it does me no good (yes I trie=
d
> toggling IEC958 Output in alsamixer).
>=20
> I created this setup after seing an old message from Takashi stating
> aplay -d plug:spdif should work with this card (no idea where spdif is
> defined). And then googling half an hour more on how to make a plug the
> default. This after trying all the revo asoundrc examples I could find
> on the net, none of which did me much good.
>=20

Ah, OK. Then it's not a bug, the output just defaults to analog.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
