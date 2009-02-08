From: Florian Mickler <florian@mickler.org>
Subject: Re: HD-audio modularization
Date: Sun, 8 Feb 2009 11:20:13 +0100
Message-ID: <20090208112013.6fbb9c2e@schatten>
References: <s5hiqq83zr8.wl%tiwai@suse.de>
	<s5h4p1luyip.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id C51BF1037F5
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 14:45:05 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LW9y3-0005lH-0x
	for alsa-devel@alsa-project.org; Sun, 08 Feb 2009 13:45:03 +0000
Received: from f053210106.adsl.alicedsl.de ([78.53.210.106])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 08 Feb 2009 13:45:03 +0000
Received: from florian by f053210106.adsl.alicedsl.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 08 Feb 2009 13:45:03 +0000
In-Reply-To: <s5h4p1luyip.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 03 Dec 2008 15:25:02 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 28 Nov 2008 11:34:35 +0100,
> I wrote:
> > A known issue is that "alsasound stop" may not work with this
> > because of the explicit module refcount without dependency.  But
> > it's a script problem, basically.  The similar problem must be
> > there for snd-aoa, for example, too.
> 
> FYI, the hda-modularization patches are now merged to master branch
> on sound git tree.  The snapshot tarball includes this change as well.

Hey! My system doesn't shutdown anymore! And i found it is the
alsasound-stop problem. 

Is there no way to have snd_hda_intel listed in the used-by column of
lsmod for snd_hda_codec_analog  ?

how should that ''script problem'' be solved?

up until now, the gentoo-initscript takes the lsmod output and removes
recursively the dependancies of the /^snd_/ modules.

a simple shootdown-script doesn't work:

--------------------------------------------
#!/bin/sh
unload_module_my() {
	echo "Unloading: $1"
		rmmod -v --wait "$1"
	echo $?
}

unload_modules_26() {
# First of all, remove the snd module and all the modules depending
# on it, this should remove already most of ALSA modules.

	UNLOAD_MODULES_LIST=

		lsmod | grep -q "^snd[[:space:]]" && rmmod --wait "snd"
		&

		wait
# Then find the remaining ones, and handle them too.
		for module in $(lsmod | sed -n -e
		's/^\(snd[^ ]*\) .*/\1/p'); do unload_module_my
		"${module}" & done

				wait

				lsmod | grep -vq "^snd"
}

unload_modules_26

-----------------------------------------------

dosn't work. 

it gives: 

Unloading: snd_pcm_oss
rmmod snd_pcm_oss, wait=yes
Unloading: snd_mixer_oss
Unloading: snd_hda_codec_analog
rmmod snd_mixer_oss, wait=yes
rmmod snd_hda_codec_analog, wait=yes
Unloading: snd_hda_intel
Unloading: snd_hda_codec
rmmod snd_hda_intel, wait=yes
rmmod snd_hda_codec, wait=yes
Unloading: snd_pcm
Unloading: snd_page_alloc
rmmod snd_pcm, wait=yes
rmmod snd_page_alloc, wait=yes
Unloading: snd_timer
rmmod snd_timer, wait=yes
0
0
ERROR: Removing 'snd_pcm': Resource temporarily unavailable
1
0
ERROR: Removing 'snd_hda_codec': Resource temporarily unavailable
0
1
ERROR: Removing 'snd_page_alloc': Resource temporarily unavailable
ERROR: Removing 'snd_timer': Resource temporarily unavailable
1
1


how is one supposed to get the unload-ordering, to do a step by step
unload?

Sincerely,
Florian
