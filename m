From: andersvi@extern.uio.no
Subject: vxpocket 440 with alsa, problems with vxloader
Date: Fri, 14 Jan 2005 12:42:20 +0100
Message-ID: <copr7koutib.fsf@olivier.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Im having trouble getting a Digigram VXPocket PCMCIA with alsa.

copied vxp440.conf to /etc/pcmcia/ - makes the card recognised by
cardmgr when inserted.

The drivers - snd_vxp440 and friend, seem to load and run.
Either by entering them in /etc/modprobe.conf or having them
loaded by cardmgr.

  $/sbin/lsmod | grep vx
  snd_vxp440              4800  0 
  snd_vx_cs              14848  1 snd_vxp440
  snd_vx_lib             45696  1 snd_vx_cs
  snd_hwdep              10784  1 snd_vx_lib
  snd_pcm               120968  4 snd_pcm_oss,snd_vx_lib,snd_intel8x0,snd_ac97_codec
  snd                    72836  11 snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_vx_cs,snd_vx_lib,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
  pcmcia                 22148  6 snd_vxp440,snd_vx_cs
  pcmcia_core            59840  3 snd_vx_cs,pcmcia,yenta_socket

However, running vxloader only leaves me with an error:

  $ vxloader
  vxloader: no VX-compatible cards found
  $

running alsaconf doesnt find any vxpocket card.

alsa is version 1.0.7

has anybody a hint to get this further?

-anders


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
