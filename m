From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] sound: soc: pxa2xx-ac97: prepare and
	unprepare the clocks
Date: Mon, 09 Jun 2014 22:27:45 +0200
Message-ID: <8738fdzv3y.fsf@free.fr>
References: <1402343952-1287-1-git-send-email-robert.jarzmik@free.fr>
 <20140609201156.GO5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 6312626562B
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:27:47 +0200 (CEST)
In-Reply-To: <20140609201156.GO5099@sirena.org.uk> (Mark Brown's message of
 "Mon, 9 Jun 2014 21:11:56 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Jun 09, 2014 at 09:59:12PM +0200, Robert Jarzmik wrote:
>> Add the clock prepare and unprepare call to the driver initialization
>> phase. This will remove a warning once the PXA architecture is migrated
>> to the clock infrastructure.
>
> Applied, please use subject lines matching the usual style for the
> subsystem.
Oh yeah, sorry.
Next time I'll "ALSA: pxa2xx" if that's the correct one ...

Cheers.

-- 
Robert
