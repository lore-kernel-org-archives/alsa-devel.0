From: Florian Faber <faber@faberman.de>
Subject: Re: RME MADIface 192 kHz problem
Date: Thu, 21 Oct 2010 16:10:58 +0200
Message-ID: <4CC049F2.1050707@faberman.de>
References: <4CC03A21.2050406@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 328C12446E
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 16:10:27 +0200 (CEST)
In-Reply-To: <4CC03A21.2050406@ifi.uio.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fredrik,

> I have a problem running the RME MADIface card at 192 kHz. At that
> speed the number of channels for the card is reduced to 16. I can set
> the sampling rate to 192 kHz using:

The MADIface does not run properly with the stock hdspm driver. Most of
the controls are wrong and the FPGA is using a wrong base frequency.

> What is needed to get this card running at 192 kHz?

A working driver :)

http://wiki.linuxproaudio.org/index.php/Driver:hdspe

There you can also find a version of hdspmixer that works with 64 channels:

http://wiki.linuxproaudio.org/index.php/App:hdspmixer_64


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
