From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: issue at 44.1 Khz capturing
Date: Mon, 10 Aug 2009 15:34:09 +0200
Message-ID: <4A8021D1.10602@ladisch.de>
References: <98769532B4BB14429434178695419EAE5F937821@bgsmsx501.gar.corp.intel.com>
	<4A8009B5.5020305@ladisch.de>
	<98769532B4BB14429434178695419EAE5F937AC6@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 09BB5103896
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 15:33:54 +0200 (CEST)
In-Reply-To: <98769532B4BB14429434178695419EAE5F937AC6@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

Harsha, Priya wrote:
> I see that the buffer allocated is 22050 bytes (and not 22052 bytes).
> Yes the hardware supports buffers which are not multiple of period size.

But there may be a (driver) bug that affects the last byte.
Try calling

	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);

in the open callback.

> Can I forcefully set my buffer size to 22052 bytes

Try the --buffer-size and --period-size parameters of arecord.


HTH
Clemens
