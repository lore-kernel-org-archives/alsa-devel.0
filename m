From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: 2.6.26-rc6 snd-pcsp: "Timer resolution is not
	sufficient"
Date: Sat, 21 Jun 2008 11:00:49 +0400
Message-ID: <485CA721.2080806@aknet.ru>
References: <485AB878.5080101@keyaccess.nl> <485B2A92.4000801@aknet.ru>
	<485C55E8.3090703@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E39C103875
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Jun 2008 09:00:02 +0200 (CEST)
In-Reply-To: <485C55E8.3090703@keyaccess.nl>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello.

Rene Herman wrote:
> In this case the problem was the ACPI PM-Timer (CONFIG_X86_PM_TIMER) got
> disabled. Re-enabling it, snd-pcsp is working fine again.
Note that this option is available
only if you enable CONFIG_EMBEDDED.
Most people will just never see it.
