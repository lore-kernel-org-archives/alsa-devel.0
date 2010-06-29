From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snddevices issue
Date: Tue, 29 Jun 2010 17:33:08 +0200
Message-ID: <4C2A1234.2030001@ladisch.de>
References: <AANLkTikzjyDqClZopaTvVmT7wwazRHE4K3XbH2m48rgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6150D246F8
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 17:33:11 +0200 (CEST)
In-Reply-To: <AANLkTikzjyDqClZopaTvVmT7wwazRHE4K3XbH2m48rgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adish Kuvelker <adkuvi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adish Kuvelker wrote:
> I find that the device nodes created in the /dev/snd for Control,
> Timer and pcmC0D0 have different minor numbers from the class devices
> created by the ALSA core.

The help text for the --enable-dynamic-minors option (when using the
alsa-driver package) or the CONFIG_SND_DYNAMIC_MINORS option (when
using the in-kernel ALSA) says that this can be used only when the
machine is running udev.  (If you are actually running udev, you don't
need the snddevices script).

> I just did kernel prints to capture the minor numbers

These numbers are also available in /proc/asound/devices.


Regards,
Clemens
