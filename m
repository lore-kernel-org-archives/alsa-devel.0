From: Florian Faber <faber@faberman.de>
Subject: Re: [PATCH - [hdspm] RayDAT/AIO 1/2] ALSA: Add support
 for RME RayDAT and AIO
Date: Thu, 27 Jan 2011 13:19:18 +0100
Message-ID: <4D4162C6.1050800@faberman.de>
References: <1296066735-11280-1-git-send-email-adi@drcomp.erfurt.thur.de>	<1296066735-11280-2-git-send-email-adi@drcomp.erfurt.thur.de>	<s5htygudb6e.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id DDECE103AB1
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 13:19:20 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
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

On 01/27/11 09:09, Jaroslav Kysela wrote:

>> So, simply move these array definitions to hdspm.c.
> I think that the reason is to share these arrays with hdspmixer.

There's more than hdspmixer out there that needs this data.

> But I agree, that it's better to move these static values to .c files.

The solution is to make them non-static (which was an error on my side).
Replicating information is not a bright idea.


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
