From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Volume Peak display
Date: Sat, 20 Sep 2003 01:11:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1064034672.10497.7.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
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
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm implementing Hardware EQ peak visualization code in the Aureal
Vortex driver, and took as a reference the ICE1712 MultiTrack peak
kcontrol code.

The problems are:

- The peaks doesnt get updated by alsamixer nor alsamixergui.
I set the "volatile" flag, but is doesnt have any effect.
- Alsamixer shows only 4 of the peak control set (20 total), and other
mixers just show 2 of them.
- The controls are declared as read only, but i can change their value.
This shouldn't be allowed.

Any suggestions ?

Best Regards

Manuel Jander.


static int snd_vortex_peaks_info(snd_kcontrol_t *kcontrol,
snd_ctl_elem_info_t *uinfo) {
	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 20;
	uinfo->value.integer.min = 0x0000;
	uinfo->value.integer.max = 0xffff;
	return 0;
}

static int snd_vortex_peaks_get(snd_kcontrol_t *kcontrol,
snd_ctl_elem_value_t *ucontrol) {
	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	int i, count;
	u16 peaks[20];
	
	vortex_Eqlzr_GetAllPeaks(vortex, peaks, &count);
	printk("vortex: Peak = %x\n", peaks[5]);
	for (i=0; i<20; i++)
		ucontrol->value.integer.value[i] = peaks[i];
	
	return 0;
}

static snd_kcontrol_new_t vortex_levels_kcontrol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "EQ Peaks",
	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
	.info = snd_vortex_peaks_info,
	.get = snd_vortex_peaks_get,
};





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
