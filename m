From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ioctl request code for specific alsa control
Date: Wed, 14 May 2008 11:17:02 +0200
Message-ID: <482AAE0E.1020509@ladisch.de>
References: <4829DE70.7050103@wurmsdobler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 213E624356
	for <alsa-devel@alsa-project.org>;
	Wed, 14 May 2008 11:17:05 +0200 (CEST)
In-Reply-To: <4829DE70.7050103@wurmsdobler.org>
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
> ...
> Another control is called pmic_control_op_sw (.name = "Master Output
> Playback Volume") and appears in amixer as "Master Output" (in fact it
> is not a volume control but a switch).

Then I'd guess its name should be "Master Playback Switch".
See Documentation/sound/alsa/ControlNames.txt.

> What is the ioctl request code for a particular snd_kcontrol_new_t
> defined in the driver?

ALSA controls do not have separate ioctl codes.  Controls are identified
by their name (or by their ID, which is a number that ALSA assigns
automatically).  There is one ioctl request that writes the value of a
control and which gets the control ID as parameter.

> Alternatively, how does the OSS layer in ALSA map the different ALSA
> controls to the predefined and fixed OSS controls?

The OSS API has some predefined mixer controls that are identifed by a
number or ioctl request.  By default, ALSA maps these OSS controls to
certain ALSA control names; see section "Mixer Elements" in
Documentation/sound/alsa/OSS-Emulation.txt.


HTH
Clemens
