From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No sound on Asus EeePC 1215b (hda-intel)
Date: Wed, 31 Aug 2011 22:42:02 +0200
Message-ID: <4E5E9C9A.8090908@ladisch.de>
References: <20110829115005.GA2937@lisko> <20110831203045.GA12513@lisko>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5F8A0244C2
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 22:42:23 +0200 (CEST)
In-Reply-To: <20110831203045.GA12513@lisko>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Touko Korpela <touko.korpela@iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Touko Korpela wrote:
>> No sound is heard (but mixer is not muted).
>> Shouldn't mixer have more channels to adjust?
>
> 00:01.1 Audio device: ATI Technologies Inc Device 1314
> 00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA) (rev 40)

Your default sound device is the device that happened to be detected
first, which is your GPU's HDMI output.

Tell whatever sound configuration tool is used in your distribution to
use the other sound device.


Regards,
Clemens
