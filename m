From: =?iso-8859-1?q?Z=E9bulon?= <zeb@zebulon.org.uk>
Subject: Terratec aureon space : strange behaviour
Date: Sun, 4 Jan 2004 12:34:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401041234.33230.zeb@zebulon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I have a problem with a new sound card based on Envy24HT, a Terratec Aureon
Sky, on both Mandrake 9.2/kernel 2.4 and cooker/kernel 2.6 (dev version). I
don't know if the problem is a Mandrake configuration issue or an alsa issue,
so I post on that list because it may interests you.

This card is supported by alsa drivers, modules are correctly loaded, there
are the alsa module and also the pcm-oss emulation module.
Strangely, applications configured to use the alsa output (xmms, xine,
mplayer) crash. For example, kaffeine -a alsa crashes with error message
"kaffeine: simple.c:1464: snd_mixer_selem_get_playback_volume: Assertion
`elem->type == SND_MIXER_ELEM_SIMPLE' failed." However, the sound works
correctly when using the oss output (it uses the oss emulation). (e.g.
kaffeine -a oss works).
Also, I have to set up the internal clock myself (but that's ok).

The same way, timidity reads correctly midi files, using the arts output.
However, I cannot get jackd working with alsa, thus rosegarden does not
detect any connected sound server.

My /etc/modules.conf contains :
probeall usb-interface usb-uhci
above snd-ice1724 snd-pcm-oss
probeall scsi_hostadapter ide-scsi
options bttv radio=0 gbuffers=4

That is a big issue for me, my old Soundblaster Live was working correctly
using directly the alsa output.
Where should I look at first ? I have checked the documentation and played
with alsactl, but with no success. Is it an alsa problem (or limitation) or a
Mandrake configuration issue ?

Happy new year
Eric


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
