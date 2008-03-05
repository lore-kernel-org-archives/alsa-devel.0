From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to do pause/resume in ALSA application
Date: Wed, 05 Mar 2008 16:53:27 +0100
Message-ID: <47CEC1F7.3040709@ladisch.de>
References: <010C7BAE6783F34D9AC336EE5A01A0880575F767@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CA4E5103802
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 16:51:53 +0100 (CET)
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A0880575F767@dbde01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, suresh.raj@gmail.com
List-Id: alsa-devel@alsa-project.org

Aggarwal, Anuj wrote:
> I am using the snd_pcm_pause API in my application but it is returning
> error: Invalid argument.

This indicates that the driver (or some PCM plugin) does not support
pausing.

> I checked whether the pause functionality is supported, using
> snd_pcm_hw_params_can_pause() and it returned me success.

This is a bug.  What device name did you use when opening the device,
and which driver are you using?


Regards,
Clemens
