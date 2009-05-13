From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Intel HDA fix for Macbook 3,1 and newer
Date: Wed, 13 May 2009 19:16:06 +0300
Message-ID: <4A0AF246.4060207@pardus.org.tr>
References: <4A0AD9BE.7070808@letorbi.de>	<4A0AE9FB.7010502@pardus.org.tr>
	<s5hk54lvw8p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.pardus.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 880D21038BF
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 18:16:03 +0200 (CEST)
In-Reply-To: <s5hk54lvw8p.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Did you try the latest alsa-driver snapshot?  It already contains a
> patch to support Macbook 5,1 (Aluminium).  The tarball is found at:
>    ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>
>
> Takashi
>   

Yes I already tried it, no effects. I then thought that it was aimed at
MB51 not MBP51:

mecbuk 2009 # cat /sys/module/snd_hda_intel/parameters/model
mb51,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>

The subsystem ID of my ALC889A codec is : 0x106b4000
The mb51 quirk is automatically applied to :

+               case 0x106b3f00: /* Macbook 5,1 */
+                       board_config = ALC885_MB5;
+                       break;

so it seems that the codecs differ.


I actually made it work by changing VREF of Node[0x18] PIN from HIZ to
any of 50,80 or 100.
This fixed the sound, also enabling the surround slider which vastly
improves the sound quality and loudness.

But still there are problems with the headphone/internal speaker
functioning. If you think that this will require
another model quirk for patch_sigmatel, I really want to get involved on
providing the necessary informations to you.

Thanks,
