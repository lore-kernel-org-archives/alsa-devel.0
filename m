From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: 2.6.26-rc6 snd-pcsp: "Timer resolution is not
	sufficient"
Date: Sat, 21 Jun 2008 03:00:41 +0200
Message-ID: <485C52B9.4010607@keyaccess.nl>
References: <485AB878.5080101@keyaccess.nl> <485B2A92.4000801@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id E83331038A7
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Jun 2008 03:00:04 +0200 (CEST)
In-Reply-To: <485B2A92.4000801@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20-06-08 05:57, Stas Sergeev wrote:

CCed onto linux-kernel to possibly help future googlers...

> Rene Herman wrote:

>> What's this? 2.6.26-rc6:
>> ===
>> input: PC Speaker as /class/input/input5
>> PCSP: Timer resolution is not sufficient (4000250nS)
>> PCSP: Make sure you have HPET and ACPI enabled.
>> PC-Speaker initialization failed.
>> pcspkr: probe of pcspkr failed with error -5
>> ===
>> A HPET I do not have, ACPI is enabled and the driver worked fine on a
>> previous -rc.
> 
> That means that the high-res timer > mode is not available. See
> cat /proc/timer_list
> It should contain the lines like
>   .resolution: 1 nsecs
> 1 nsecs means a high-res mode.
> Some large values (like 4000250)
> means low-res.
> Try adding the hrtimers people to
> CC if this is a problem.

In this case the problem was the ACPI PM-Timer (CONFIG_X86_PM_TIMER) got 
disabled. Re-enabling it, snd-pcsp is working fine again.

It does seem a bit off that you needs something as (relatively) modern 
as an ACPI timing source (or HPET, or ...) to drive something quite as 
legacy as the PC speaker, but oh well.

Rene.
