From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: Re: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 15:03:52 +0100
Message-ID: <4CE13DC8.30007@elproma.com.pl>
References: <4CE126FD.7000407@elproma.com.pl>
	<20101115123351.GB3338@sirena.org.uk>
	<4CE139CF.4070400@elproma.com.pl>
	<20101115135053.GC3338@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout.mailmx.agnat.pl
	[193.239.44.238])
	by alsa0.perex.cz (Postfix) with ESMTP id AEAB4103856
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 15:04:11 +0100 (CET)
In-Reply-To: <20101115135053.GC3338@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> You need to register both -
> the device will generally be registered by your arch/ file for the
> board.
>
>   
Yes, I have done this too.
> Could you please verify that you have enabled the debug logging
> requested?  I cannot see any of the additional logging that would be
> generated if this was enabled.
>   
If I understood correctly my sound/soc/soc-core.c looks as following 
(added #define ...):
....
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/initval.h>

#define NAME_SIZE       32

/*my code*/
#define CONFIG_DEBUG_FS
#define DEBUG
/*end of my code*/

static DEFINE_MUTEX(pcm_mutex);
static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);

#ifdef CONFIG_DEBUG_FS
static struct dentry *debugfs_root;
#endif

static DEFINE_MUTEX(client_mutex);
static LIST_HEAD(card_list);
....

best regards,
Greg
