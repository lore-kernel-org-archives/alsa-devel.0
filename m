From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: dmix oss
Date: Wed, 23 Mar 2005 08:54:48 +0100
Message-ID: <1111564488.424120c835bd6@www3.webhosting.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to figure out the dmixoss example in the plugin docs.

It says to use this with oss emulation devices but afaict the plugin laye=
r
doesn't automatically pick up that dmixoss is being used.

I tried setting it to default plugin but it doesn't want to do that eithe=
r. I
get this error message:

ALSA lib conf.c:1165:(parse_def) default is not a compound
ALSA lib conf.c:1578:(snd_config_load1) _toplevel_:1:13:Invalid argument
ALSA lib conf.c:2821:(snd_config_hook_load) .asoundrc may be old or corru=
pted:
consider to remove or fix it
ALSA lib conf.c:2684:(snd_config_hooks_call) function snd_config_hook_loa=
d
returned error: Invalid argument
ALSA lib conf.c:3050:(snd_config_update_r) hooks failed, removing configu=
ration
snd_pcm_open: Invalid argument (default)


Ideas for how to get around this if possible are greatly appreciated. The=
 main
point of this otherwise futile effort is to be able to use skype which on=
ly has
oss support for some bizarre reason.

Rgds.

 --
 Patrick Shirkey - Boost Hardware Ltd.
 Http://www.boosthardware.com
 Http://www.djcj.org/ - The Linux Audio Users guide
 Http://www.djcj.org/gigs - Gigs Guide Korea
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 Being on stage with the band in front of crowds shouting, "Get off! No!
 We want normal music!", I think that was more like acting than anything
 I've ever done.

 Goldie, 8 Nov, 2002
 The Scotsman


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contes=
t
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphone=
s
for the chance to win $25,000 and application distribution. Enter today a=
t
http://ads.osdn.com/?ad_id=3D6882&alloc_id=3D15148&op=3Dclick
