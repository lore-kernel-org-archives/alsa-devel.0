From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA TImers
Date: Thu, 3 May 2007 10:57:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705031054290.8516@tm8103.perex-int.cz>
References: <013B1C915F9462459242424413ABB2645297D9@bnglmail.sirf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 082372449B
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 10:57:58 +0200 (CEST)
In-Reply-To: <013B1C915F9462459242424413ABB2645297D9@bnglmail.sirf.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <NMathew@sirf.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 3 May 2007, Nobin Mathew wrote:

> Hi,
> 
> I am new to ALSA. Can any body explain me the use of timers in ALSA,
> timers like the one in pcm_timer.c

Could you give a more specific question? PCM timers can be used for 
sync among applications and alsa-lib's direct plugins uses these timers 
too (as event source for slave applications).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
