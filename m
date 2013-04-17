From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH v3 0/5] ALSA: snd-usb: add support for DSD
Date: Wed, 17 Apr 2013 20:13:45 +0300
Message-ID: <516ED849.7020907@sonarnerd.net>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
 <s5hsj2pbexz.wl%tiwai@suse.de> <516E8185.9050705@gmail.com>
 <516ED558.3060004@sonarnerd.net> <516ED631.4060707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 370B32616F3
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 19:13:46 +0200 (CEST)
In-Reply-To: <516ED631.4060707@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 04/17/2013 08:04 PM, Daniel Mack wrote:
> You volunteer for sending a patch? :)

I have to admit I have no idea from where and how ALSA API docs are 
generated.

> Ok, that's a case I haven't though of yet, but we can easily extend that
> logic once such a device is used by anyone. For now, this entire logic
> is only relevant for one series of devices, and for that, we know the
> parameters exactly.

Over 50% of devices I've seen use 32-bit sample formats for DoP, 
including the one I regularly use with Linux. That's why I asked...

Currently most popular OEM blocks are XMOS and M2Tech hiFace which both 
use 32-bit sample format.

> The important thing is that we don't have to break the userspace API,
> but I think we're safe here, right?

Yes, it looks good to me.
