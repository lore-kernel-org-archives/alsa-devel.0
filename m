From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Stereo Support in APLAY
Date: Thu, 08 Apr 2010 08:47:45 +0200
Message-ID: <4BBD7C11.9050906@ladisch.de>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>	<l2s98391a7b1004030348n2b2a540bq8fddb0a90dd7c3c9@mail.gmail.com>
	<290463D19D2E064191F1F96ECA480A8940F04F6E80@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 11CC91037F7
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 08:47:51 +0200 (CEST)
In-Reply-To: <290463D19D2E064191F1F96ECA480A8940F04F6E80@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Reddy, MR Swami wrote:
> Could you plz confirm, if the ALSA drivers support the stereo format files
> with 'aplay'?

aplay supports stereo files; whether the driver supports this depends
on the driver.

I don't know what you problem is, but it's likely that you tried to
play a stereo file on a mono device or a mono file on a stereo-only
device, and that you used a device name like "hw:0" that disables all
automatic format conversions, instead of "default".


Regards,
Clemens
