From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: USB audio devices on Audio 4DJ and similar
Date: Fri, 6 Apr 2012 22:09:21 +0100
Message-ID: <201204062209.21564.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net
	[62.24.128.238]) by alsa0.perex.cz (Postfix) with ESMTP id 82352244DA
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 23:08:31 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel and Alsa folks,

At present I am involved with resolving some issues that have arisen from 
people using the Audio 4DJ interface with Portaudio, and I hoped it would be 
OK to check a few Alsa details with you?  Unfortunately I have limited 
experience of USB audio.

Apparently the 4 audio inputs/outputs appear as 2 stereo sub-devices on the 
first device, rather than a single 4-channel device - is this correct?

Assuming that is correct, does that arise as a result of the intrinsic nature 
of the interface, or is it by developer choice in the driver (for example so 
that it can be opened as 2 stereo streams)?   Is there (or could there be) a 
way to change this, eg by module option or udev rule?  I notice in the source
    #define CHANNELS_PER_STREAM  2

Is there a way at present that the device can be accessed as a single 
4-channel stream other than by creating a custom ~asoundrc with a pcm 
definition using 'multi' to join the 2 stereo streams?

I don't see any USB audio units having files in /usr/share/alsa/cards; is it 
not relevant, not normally necessary or something no-one has got round to 
writing?

I appreciate any clarification you can bring.

Regards

Alan
