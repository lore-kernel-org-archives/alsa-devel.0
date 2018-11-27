From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] conf: Move UCM profile snippets into
 ucm-includes subdirectory
Date: Tue, 27 Nov 2018 14:19:09 +0100
Message-ID: <ce15165e-9609-cb31-bc78-dad68dc78bde@perex.cz>
References: <20181127130852.7567-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E4DA26770D
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 14:19:14 +0100 (CET)
In-Reply-To: <20181127130852.7567-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Dne 27.11.2018 v 14:08 Takashi Iwai napsal(a):
> We have placed UCM profile snippets to be included by the main config
> files also in the same directory, src/conf/ucm, it confuses alsaucm
> program that scans over all subdirectories.  It thinks such a file is
> also the main config file, and spews errors like:
>   % alsaucm
>   ALSA lib utils.c:67:(uc_mgr_config_load) could not open configuration file /usr/share/alsa/ucm/bytcr/bytcr.conf
>   ALSA lib parser.c:1427:(load_master_config) error: could not parse configuration for card bytcr
>   alsaucm: unable to obtain card list: No such file or directory
> 
> For avoiding this, move UCM profile snippets into the own root
> directory, src/conf/ucm-includes, and include them by changing the
> include with "<searchdir:ucm-includes>".
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
