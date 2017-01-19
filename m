From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] ASoC: dapm: Implement and instantiate
	DAI widgets
Date: Thu, 19 Jan 2017 10:43:34 +0300
Message-ID: <20170119074334.GC4398@mwanda>
References: <20170119073826.GA28899@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id F1C1D267847
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 08:43:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170119073826.GA28899@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is another warning some lines later as well:

    sound/soc/soc-dapm.c:3963 snd_soc_dapm_new_dai_widgets()
    error: 'w' dereferencing possible ERR_PTR()

regards,
dan carpenter
