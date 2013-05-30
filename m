From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH alsa-lib 2/2] pcm_plugin: Fix return value
	of snd_pcm_rewind
Date: Thu, 30 May 2013 14:05:32 +0200
Message-ID: <51A7408C.1010608@perex.cz>
References: <1369909594-15047-1-git-send-email-david.henningsson@canonical.com>
 <1369909594-15047-2-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id DEE16265150
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:05:33 +0200 (CEST)
In-Reply-To: <1369909594-15047-2-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arun.raghavan@collabora.co.uk
List-Id: alsa-devel@alsa-project.org

Date 30.5.2013 12:26, David Henningsson wrote:
> In case the rewind did not rewind as much as expected, e g due to
> time delay between the latest avail update and the rewind, we must
> properly account for that in the plugin layer.

Thank you very much for this fix.
I applied both patches to alsa-lib's repo.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
