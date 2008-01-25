From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Wall clock interrrupts
Date: Fri, 25 Jan 2008 08:55:53 +0100
Message-ID: <1201247753.30957.1233203209@webmail.messagingengine.com>
References: <479983FD.5040704@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8F93A24734
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 08:55:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <479983FD.5040704@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Do all sound cards hardware have wall clocks that one can generate 
> interrupts from?
> I know all Creative and E-Mu cards do.

Some ISA cards and the Yamaha DS-1 chips do; all other cards have only
the PCM period interrupt.

> I am looking to use the wall clock interrupt for triggering events in 
> application space,

I guess you want to synchronize those events to the PCM playback?
This makes sense only when the PCM is running, and in that case you can
use the PCM slave timer.


Regards,
Clemens
