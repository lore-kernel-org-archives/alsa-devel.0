From: Giuliano Pochini <pochini@shiny.it>
Subject: volume always 0 ?!?
Date: 23 Mar 2003 23:54:13 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048463664.4150.46.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


setvolume control callback always get uc->value.integer.value[x]==0. Any
ideas ?


Bye.



---------------------------------------------------------
[Giu@Jay Giu]$ amixer 
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback -32768 - 1536
  Front Left: Playback 0 [96%]
  Front Right: Playback 0 [96%]




static int Echo_volume_info(snd_kcontrol_t *kcontrol,
snd_ctl_elem_info_t *uinfo) {
  uinfo->type=SNDRV_CTL_ELEM_TYPE_INTEGER;
  uinfo->count=2;
  uinfo->value.integer.min=ECHOGAIN_MINOUT;
  uinfo->value.integer.max=ECHOGAIN_MAXOUT;
  return(0);
}

static int Echo_setvolume(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t
*ucontrol) {
struct EchoChip *chip;

  printk("setvol %ld %ld\n",
         ucontrol->value.integer.value[0],
         ucontrol->value.integer.value[1]);
}


static snd_kcontrol_new_t pcmout_volume_control __devinitdata = {
  .name="PCM Playback Volume",
  .index=0,
  .iface=SNDRV_CTL_ELEM_IFACE_MIXER,
  .access=SNDRV_CTL_ELEM_ACCESS_READWRITE,
  .info=Echo_volume_info,
  .get=Echo_setvolume,
  .put=Echo_getvolume,
};





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
