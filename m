From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Modifying PCM buffer before DMA
Date: Wed, 30 Nov 2016 20:47:18 +0100
Message-ID: <alpine.DEB.2.02.1611302033450.10518@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 551BC26733E
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 20:47:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 7127E2E162
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 20:47:26 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id W04ZbHVDX506 for <alsa-devel@alsa-project.org>;
 Wed, 30 Nov 2016 20:47:25 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bes.se.axis.com (Postfix) with ESMTPS id A09732E2C0
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 20:47:25 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FDF81A065
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 20:47:25 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84F171A05F
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 20:47:25 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder02.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 20:47:25 +0100 (CET)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by thoth.se.axis.com (Postfix) with ESMTP id 78FE5DCD
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 20:47:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Working with a SoC which has an I2S interface which reuquires =

16-bit-swapped 32 bit samples (i.e. the first and 16 halfwords are =

swapped, but within the halfwords the bytes themselves are little endian), =

I'm trying to figure out a way to adjust the data in the PCM driver so =

that ALSA sees standard S32_LE samples.

My approach is to use a tight loop to halfword-swap the data. This works =

fine for capture, where the swap routine can be run triggered by the DMA =

interrupt as each period arrives from the I2S interface, before calling =

snd_pcm_period_elapsed().

The problem I have is for playback. I want to have SNDRV_PCM_INFO_MMAP set =

in snd_pcm_hardware.info in order to be use plugins such as dmix, which in =

practice means that the PCM driver doesn't really know exactly how much =

data the application has written before the DMA starts writing it out to =

the I2S interface. As far as I can tell, the application layer asks the =

driver for the hw_ptr but there is no way the driver can actually know how =

much data the application has in fact written.

Contrary to the capture case, once the DMA interrupt for a previous period =

has been triggered, the data for the current period will already be on its =

way out to the I2S interface, courtesy of the DMA.

Disabling MMAP seems to be one way to get the PCM driver to take greater =

control of the transfer (for instance via snd_pcm_ops->copy() ), but I =

want to avoid that as mentioned above. My question is, is there another =

way?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
