From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi - hwdep
Date: Sat, 23 Feb 2008 20:41:48 +1300
Message-ID: <200802232041.48913.linux@audioscience.com>
References: <200802221226.59326.linux@audioscience.com>
	<200802231010.59448.linux@audioscience.com>
	<75b66ecd0802221652s6dd2a56fye01616b5e17c93aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id BF4C6103840
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 08:38:16 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JWO00K8RL7M3B10@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 23 Feb 2008 20:38:11 +1300 (NZDT)
In-reply-to: <75b66ecd0802221652s6dd2a56fye01616b5e17c93aa@mail.gmail.com>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Lee,

On Saturday 23 February 2008 13:52:13 Lee Revell wrote:
> On Fri, Feb 22, 2008 at 4:10 PM, Eliot Blennerhassett
>
> <linux@audioscience.com> wrote:
>I just don't know enough
> > about how to start on hwdep implementation.
>
> Please take a look at snd_emu10k1_fx8010_ioctl in
> alsa-kernel/pci/emu10k1/emufx.c for examples of hwdep ioctl usage.

that wasn't too hard. I have implemented stubs just to see how it fits 
together.

It doesn't do quite what I want.  The existing HPI ioctl has one device file 
for the driver, whether one or sixteen cards are installed, and its name 
doesn't change depending on the card index. (I.e. userspace accesses the 
whole (HPI) audio subsystem through the one /dev/asihpi)

ALSA makes one device file per card, and the file name depends on the card 
index.  Is there any way I can make a single device for the driver that has 
an unchanging name (preferably /dev/asihpi)

regards

-- 
--
Eliot Blennerhassett
www.audioscience.com
