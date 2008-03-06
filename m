From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to do pause/resume in ALSA application
Date: Thu, 06 Mar 2008 11:35:54 +0100
Message-ID: <47CFC90A.4000604@ladisch.de>
References: <010C7BAE6783F34D9AC336EE5A01A0880575F767@dbde01.ent.ti.com>
	<47CEC1F7.3040709@ladisch.de>
	<010C7BAE6783F34D9AC336EE5A01A0880575FA06@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id F0B56244A0
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 11:34:21 +0100 (CET)
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A0880575FA06@dbde01.ent.ti.com>
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

(please don't top-post)
Aggarwal, Anuj wrote:
> Are you suggesting a bug in the driver or in the library?

Yes.

> I passed "plughw:0,0" as the device name.

The plug plugin doesn't do funny things with pausing, so the bug must
be in the driver.

> We have our own driver for the audio codec, written as per the ALSA
> framework.

I'd guess that the SNDRV_PCM_INFO_PAUSE flag is set, but that the
trigger callback doesn't implement SNDRV_PCM_TRIGGER_PAUSE_PUSH/RELEASE.


HTH
Clemens
