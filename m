From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: 2.6.26-rc6 snd-pcsp: "Timer resolution is not
	sufficient"
Date: Fri, 20 Jun 2008 07:57:06 +0400
Message-ID: <485B2A92.4000801@aknet.ru>
References: <485AB878.5080101@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id CF8B924517
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 05:56:18 +0200 (CEST)
In-Reply-To: <485AB878.5080101@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.

Rene Herman wrote:
> What's this? 2.6.26-rc6:
> ===
> input: PC Speaker as /class/input/input5
> PCSP: Timer resolution is not sufficient (4000250nS)
> PCSP: Make sure you have HPET and ACPI enabled.
> PC-Speaker initialization failed.
> pcspkr: probe of pcspkr failed with error -5
> ===
> A HPET I do not have, ACPI is enabled and the driver worked fine on a
> previous -rc.
That means that the high-res timer
mode is not available. See
cat /proc/timer_list
It should contain the lines like
  .resolution: 1 nsecs
1 nsecs means a high-res mode.
Some large values (like 4000250)
means low-res.
Try adding the hrtimers people to
CC if this is a problem.
