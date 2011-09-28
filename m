From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: dmix
Date: Wed, 28 Sep 2011 12:25:26 -0400
Message-ID: <CA+Dpatg_mHrQA29FgDF4W8LgH38GnveXzeGdrmVwM9nqSLJ6xA@mail.gmail.com>
References: <CA+Dpatird_tLYPLF98T60yKreZGOmE3YVC=AQKJWUrC9Y0-sYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A512103813
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 18:25:27 +0200 (CEST)
Received: by wyg36 with SMTP id 36so211589wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2011 09:25:26 -0700 (PDT)
In-Reply-To: <CA+Dpatird_tLYPLF98T60yKreZGOmE3YVC=AQKJWUrC9Y0-sYA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Jerry Geis <geisj@messagenetsystems.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

I am using ALSA 1.0.24 with the attached asound.conf.  I am attempting to
share (mix) the analog output between Asterisk and aplay.  However, when
Asterisk is running, my application throws an error when attempting to play
a wave file via aplay.  If I stop Asterisk, aplay plays the wave file just
fine.  If I remove the asound.conf file, Asterisk and aplay are both happy
and share the analog output just find with the default ALSA dmix
implementation.  However, we need this asound.conf to work for us for other
reasons.  What is wrong with it.  I have even tried replacing dmix with
dshare and get the same bad behavior.  We are running CentOS 6.0.  As a
caveat, I am attempting to use dmix with analog audio.  If I use it with
HDMI audio, it works flawlessly (same asound.conf with tweek to specify
HDMI).  Thanks in advance for your help.

[root@devkrakorar ~]# aplay /usr/share/sounds/alsa/Front_Center.wav
pcm_name = default
ALSA lib pcm_dmix.c:1068:(snd_pcm_dmix_open) unable to open slave
aplay: main:662: audio open error: Invalid argument

Best Regards,

-- 
Rob Krakora
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext 212
(317)663-0808 Fax
