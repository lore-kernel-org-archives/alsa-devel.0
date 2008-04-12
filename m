From: Florian Faber <faber@faberman.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 20:25:57 +0200
Message-ID: <200804122025.57165.faber@faberman.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 34066243DC
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 20:26:11 +0200 (CEST)
In-Reply-To: <4800FC14.3060804@superbug.co.uk>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 12 April 2008 20:14:44 James Courtier-Dutton wrote:
> That sounds reasonable for now. Professional sound card users will
> maybe just have to remember to mute the master control before
> connecting their speakers.

This is very, very dangerous - not only can it harm the equipment, it 
can also harm the user. 0dBFS equals >121dB at a distance 2m away from 
my head, and I have a *small* setup.

To be honest, I think I would then insert a switch in the RME driver 
that will enable the outputs only after the RME mixer application has 
been started.


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
