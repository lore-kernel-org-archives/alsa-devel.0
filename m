From: Harald Radke <harryrat@postnuklear.de>
Subject: Re: get rid of controls with snd_ctl_remove
Date: Mon, 1 Sep 2008 13:04:45 +0200
Message-ID: <200809011304.45951.harryrat@postnuklear.de>
References: <200808291454.42441.harryrat@postnuklear.de>
	<200808300019.06175.harryrat@postnuklear.de>
	<s5hd4jo76k1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id 93F852415A
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 13:04:47 +0200 (CEST)
In-Reply-To: <s5hd4jo76k1.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi there!

Well, I guessed it was a typo but you know, with software u barely know, one 
is a little bit more careful (:

Ok, I tested the activated() routine, it works quite well for deactivating, 
those controls aren't available in mixer user apps as well as deactivating a 
control which is necessary for sound output like "Left Mixer Playback Switch"
(on WM8750) mutes the device (:

However, I tried the following:

- deactivate control
- activate same control (right after deactivating)

with the effect that the control wasn't accessible via mixer nor did the 
related path seem to work

Greez,

Harry
