From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Gateway MP-6954 laptop, FC6, no sound
Date: Mon, 30 Jul 2007 07:31:22 -0700
Message-ID: <1185805882.21191.27.camel@razman.gruemaster.com>
References: <200707300751.l6U7ps2n008306@sky.arc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 3867610381F
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jul 2007 16:31:25 +0200 (CEST)
In-Reply-To: <200707300751.l6U7ps2n008306@sky.arc.nasa.gov>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bill McKie <mckie@sky.arc.nasa.gov>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-07-30 at 00:51 -0700, Bill McKie wrote:

> I've been running FC6 on a Gateway MP-6954 laptop computer
> since Oct-2006, and have been hoping that the regular FC6 yum
> updates will eventually provide an alsa update that will support
> the MP-6954's sound hardware.  So far, that hasn't happened,
> and my system has never had sound capability.
> 
> Current system stuff:
> 
> uname -r
> 2.6.20-1.2962.fc6
> 
> rpm -q -a | grep -i alsa
> alsa-lib-1.0.14-0.1.rc1.fc6
> alsa-lib-devel-1.0.14-0.1.rc1.fc6
> alsa-utils-1.0.14-0.2.rc1.fc6
> 
> cat /etc/modprobe.conf
> alias eth0 sky2
> alias scsi_hostadapter ahci
> remove snd-hda-intel { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; };
>     /sbin/modprobe -r --ignore-remove snd-hda-intel
> options snd cards_limit=8
> alias snd-card-0 snd-hda-intel
> options snd-hda-intel index=0
> alias snd-card-7 snd-usb-audio
> options snd-usb-audio index=7
> 
> alsamixer (v1.0.14rc1) reports:
>  Card: HDA Intel
>  Chip: SigmaTel ID 7634
> 
> Some Internet googling showed that Tobin Davis released
> a source level Sigmatel STAC9250 (7634) test patch 6
> (gateway-mp6954.patch.6) that appears to address this
> problem back in December 2006.

Yes, I did.  See below.

>   http://www.spinics.net/lists/alsa-devel/msg05113.html
> 
> Is this gateway-mp6954.patch.6 still appropriate to be 
> used on my FC6 system? (My FC6 sys has all the current
> yum updates applied.)
> 
> If this patch is appropriate, should I first remove the
> existing alsa rpms before installing alsa from source
> with the patch.  I.e. should I remove all 3 packages:
> 
>  alsa-lib-1.0.14-0.1.rc1.fc6
>  alsa-lib-devel-1.0.14-0.1.rc1.fc6
>  alsa-utils-1.0.14-0.2.rc1.fc6
> 
> Will subsequent FC6 yum updates involving alsa then
> disturb the patched alsa?
> 
> Thanks much,
> Bill
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

The patches are part of the alsa-1.0.14 release driver.  I'm not sure
which driver you have, as I don't follow the driver/kernel versions,
especially at the distro level.

If you wish to maintain your rpm repository, I do have a build
environment that will build rpm packages for your distro.  It is located
at http://members.dsl-only.net/~tdavis/my-build.tar.bz2 .  To use it,
download and extract it with "tar -jxvf my-build.tar.bz2", then cd into
the directory that was extracted.  Type (as root) "make &&
audio_install", and it will build all of the rpm packages for you.  

-- 
Tobin Davis  


"One Architecture, One OS" also translates as "One Egg, One Basket".
