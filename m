From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: Oss mixer emulation
Date: Sat, 24 Aug 2002 03:41:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020824084156.GA24534@mlug.missouri.edu>
References: <20020824075446.GA23390@mlug.missouri.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlug.missouri.edu (root@mlug.missouri.edu [128.206.61.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA19516
	for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2002 10:41:59 +0200
Received: from mlug.missouri.edu (markrages@localhost [127.0.0.1])
	by mlug.missouri.edu (8.12.3/8.12.3/Debian -4) with ESMTP id g7O8fuKL024788
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=FAIL)
	for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2002 03:41:56 -0500
Received: (from markrages@localhost)
	by mlug.missouri.edu (8.12.3/8.12.3/Debian -4) id g7O8fuXR024786
	for alsa-devel@alsa-project.org; Sat, 24 Aug 2002 03:41:56 -0500
Content-Disposition: inline
In-Reply-To: <20020824075446.GA23390@mlug.missouri.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 24, 2002 at 02:54:46AM -0500, Mark Rages wrote:
> A quick question, as I'm tired of reading source:
> 
> I can adjust the volume of my driver with either alsamixer or aumix.
> 
> Using the OSS output plugin for XMMS, however, the volume control on XMMS 
> has no effect.
> 
> Besides trading XMMS for Alsaplayer, what can I do to fix this?  The same 
> setup works fine with my AWE32.  (I referred to the sb_mixer code when 
> adding the volume control)
> 
> Does the OSS mixer emulation look for the first control to emulate as 
> master volume?  Else, how does it choose?

Following up:

This card has two stereo PCM outputs.

After a little experimentation, I find that if I name one mixer "PCM" and 
the other "Master" I get the desired operation.

However, I want them to show as "PCM 1+2" and "PCM 3+4" in alsamixer etc.

Is there some way to hint the alsa oss mixer emulation code?

Also, I have code like this (borrowed from sb_mixer.c):

static snd_kcontrol_new_t snd_wave4_controls_double[] = {
  { iface: SNDRV_CTL_ELEM_IFACE_MIXER,
    name: "PCM",
    info: snd_wave4_mixer_info_double,
    get: snd_wave4_mixer_get_double,
    put: snd_wave4_mixer_put_double,
    private_value: 0
  },
  { iface: SNDRV_CTL_ELEM_IFACE_MIXER,
    name: "Master",
    info: snd_wave4_mixer_info_double,
    get: snd_wave4_mixer_get_double,
    put: snd_wave4_mixer_put_double,
    private_value: 1
  }
};

static int snd_wave4_mixer_init_double(wave4_t *wave4, char *name) {
  int i, err;

  for (i = 0; i < 2; i++) {
    if ((err = snd_ctl_add(wave4->card, 
			   snd_ctl_new1(&snd_wave4_controls_double[i], 
					wave4))) < 0)
      return err;
  }

  snd_component_add(wave4->card, name);
  strcpy(wave4->card->mixername, name); 

  return 0;
}

So what are all these names? Can I use different names to get what I want? 
- The one in snd_kcontrol_t
- the one passed to snd_component_add
- the one in card->mixername

Regards,
Mark


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
