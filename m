From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: From snd_kcontrol_new_t to amixer
Date: Wed, 14 May 2008 11:08:03 +0200
Message-ID: <482AABF3.3060406@ladisch.de>
References: <4829D9F6.205@wurmsdobler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9E002243D2
	for <alsa-devel@alsa-project.org>;
	Wed, 14 May 2008 11:08:08 +0200 (CEST)
In-Reply-To: <4829D9F6.205@wurmsdobler.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Wurmsdobler <peter@wurmsdobler.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Peter Wurmsdobler wrote:
> I am puzzled by an observation that runs against my common sense. The
> pmic-alsa-mixer.c provides 6 (six) snd_kcontrol_new_t controls with
> their callback functions, name and other members, then registers
> themusing snd_ctl_add(...). However, amixer shows only 5 (five), and all
> with different names. What is the process of generating these names if
> not from the kernel structures?

There is an additional layer (the "simple" mixer layer) on top of the
kernel mixer layer.

Use "amixer controls" or "amixer contents" to see the kernel controls.


HTH
Clemens
