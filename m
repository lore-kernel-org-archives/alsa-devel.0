From: joy <joy@pingfm.org>
Subject: spdif-trough and snd_ctl_elem_*
Date: Sat, 13 Jul 2002 17:19:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020713151936.GA4711@pingfm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

hi,

i actually want to set spdif-trough automagically from inside an application
when its needed but it seems there are differences from hardware to
hardware or/and changes in the alsa-lib-api, but im not sure.

i have an old-code fragment which dosn't work for me (ens1371). 
it does not work also on the SB Live Player 5.1.

   ...
   snd_ctl_elem_value_alloca(&ctl);
   snd_ctl_elem_value_set_interface(ctl, SND_CTL_ELEM_IFACE_PCM);
   snd_ctl_elem_value_set_device(ctl, snd_pcm_info_get_device(info));
   snd_ctl_elem_value_set_subdevice(ctl, snd_pcm_info_get_subdevice(info));
   snd_ctl_elem_value_set_name(ctl,SND_CTL_NAME_IEC958("", PLAYBACK, PCM_STREAM));
   snd_ctl_elem_value_set_iec958(ctl, &spdif);
   ...
   snd_ctl_elem_write(ctl_handler, ctl);

i got always "file or directory not found"-error with this and it's no
wonder cause i have no pcm-iface like above.

i changed now iface to SND_CTL_ELEM_IFACE_MIXER and _set_name to:
  snd_ctl_elem_value_set_name(ctl,SND_CTL_NAME_IEC958("", PLAYBACK, SWITCH));
   
it seems to work for me but im not sure if its work on the sbLive. the
switch or whatever on the sblive is called 'IEC958 Optical Raw'.
are the switches different from hadware/mixer to hardware or im wrong?
and if yes is there an 'easy way' to get the default
spdif-through-switch?

any enlightment in this appreciated.

-- 
thanx and regards

____-
joy

________/\---------%%%___________-----------
webcast every sunday 2000 cest at pingfm.org

pgp key at: x-hkp://wwwkeys.de.pgp.net


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
