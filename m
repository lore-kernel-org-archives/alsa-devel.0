From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Mon, 28 May 2012 16:58:39 +0200
Message-ID: <4FC3929F.4050304@ladisch.de>
References: <4FBFE0D5.8030501@mixxx.org> <4FC23123.8000702@ladisch.de>
	<4FC295AD.1030901@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 536F22438B
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 16:59:06 +0200 (CEST)
In-Reply-To: <4FC295AD.1030901@mixxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sean M. Pappalardo - D.J. Pegasus wrote:
> I just updated my kernel and tried it with the SCS.1m but unfortunately it reports an error:
>
> firewire_core: created device fw1: GUID 0012600000000000, S400
> snd_scs1x fw1.0: transaction failed: type error

This is from a snd_fw_transaction call, either the ping or the address
setting.

Please check if these commands work:

	firewire-request /dev/fwX read c007dedadada 4
	firewire-request /dev/fwX write c007dedadada f100123456789abc

In theory, you should be able to write MIDI commands by prefixing them
with 00, like this for a note-on:
	firewire-request /dev/fwX write c007dedadada 00912345

> Turning on the SCS.1d then yields:
> firewire_core: created device fw2: GUID 0012600100000000, S400

FFADO had only the 1m's ID, so the driver does not yet know about the 1d.


Regards,
Clemens
