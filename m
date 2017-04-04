From: Graham TerMarsch <alsa@howlingfrog.com>
Subject: Question re: static-y sound on an Asus Prime Z270-A
	motherboard...
Date: Tue, 04 Apr 2017 16:17:56 -0700
Message-ID: <1994426.GJOqzFsnCO@darkness.internal.howlingfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.howlingfrog.com (mail.ca.howlingfrog.com [159.203.34.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CBAB266F05
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 01:17:59 +0200 (CEST)
Received: from darkness.internal.howlingfrog.com (unknown [184.69.18.242])
 by mail.howlingfrog.com (Postfix) with ESMTPSA id E9CBC12020F
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 16:17:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I recently purchased a new computer w/an Asus Prime Z270-A motherboard in it, 
which uses a Realtek ALC S1220-A chipset (according to the specs at asus.com)

Although the "snd_hda_codec_generic" module does load and produce sound, the 
"left speaker" outputs static along with the sound.  Quieter the sound, the 
louder the static.  If I use the headphone jack the sound is perfect, but 
using the speaker output it has static (and _only_ on the left side).

I'm currently running Fedora-25, and the 4.10.5 kernel release.

I tried patching in a535ad57d0e6b ("hda/realtek - New codec support of 
ALC1220") but with no luck; upon rebooting it does not load that module.  
Loading it with "modprobe" directly also does not generate any output to 
indicate that it detected the card and is in use.

I'm not sure what the exact status is for this motherboard at the moment and 
whether or not it is currently supported, but I thought I would reach out and 
ask.  Would be happy to test patches and/or provide any info I can from this 
motherboard, if that would prove useful.

Much appreciated,

-- 
Graham TerMarsch
