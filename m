From: Florian Faber <faber@faberman.de>
Subject: Re: RME HDSP9632, mute headphones
Date: Mon, 11 Oct 2010 07:32:43 +0200
Message-ID: <4CB2A17B.70508@faberman.de>
References: <4CB1ED8F.2010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id B880324158
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 07:32:47 +0200 (CEST)
In-Reply-To: <4CB1ED8F.2010008@gmail.com>
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

On 10/10/10 18:45, Matthew Robbetts wrote:

> I've just acquired myself a HDSP9632 and noticed what I think is a
> missing feature from the drivers (compared to Windows, at least): the
> ability to set the headphones to "mute", in addition to -6dB and -12dB
> of gain. I would find this feature useful.
> 
> Is there a reason it is missing or has it just been overlooked? Or,
> alternatively, am I doing something stupid?

This has nothing to do with the driver. You set the headphone volume
with hdspmixer, like you would do with TotalMix on Windows/Mac.


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
