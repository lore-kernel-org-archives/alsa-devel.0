From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Thu, 28 Mar 2013 01:45:23 +0200
Message-ID: <51538493.40309@sonarnerd.net>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F61A26533F
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:45:24 +0100 (CET)
In-Reply-To: <1364427144-30036-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 03/28/2013 01:32 AM, Daniel Mack wrote:
> In particular, this adds definitions and descriptions for G.723 and
> DSD types.

Daniel,

It would be important to document the correct bit order for the DSD 
sample types to avoid confusion. There are two different conventions in 
use, oldest bit in MSB and oldest bit in LSB... (be aware that at some 
point in not too distant future someone could ask for the other one)


Andreas,

Am I right to assume that in your case it's the same as for DoP, IOW, 
oldest in MSB?


Thanks,

	- Jussi
