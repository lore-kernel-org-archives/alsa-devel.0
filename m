From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: dapm: Simplify list creation in
	dapm_dai_get_connected_widgets()
Date: Tue, 04 Aug 2015 20:51:14 +0200
Message-ID: <55C109A2.6000101@metafoo.de>
References: <20150804173850.GA28511@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-223.synserver.de (smtp-out-223.synserver.de
 [212.40.185.223])
 by alsa0.perex.cz (Postfix) with ESMTP id A09B0260532
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 20:51:15 +0200 (CEST)
In-Reply-To: <20150804173850.GA28511@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/04/2015 07:38 PM, Dan Carpenter wrote:
> Hello Lars-Peter Clausen,
> 
> The patch 1ce43acff0c0: "ASoC: dapm: Simplify list creation in
> dapm_dai_get_connected_widgets()" from Jul 26, 2015, leads to the
> following static checker warning:
> 
> 	sound/soc/soc-dapm.c:1199 snd_soc_dapm_dai_get_connected_widgets()
> 	warn: inconsistent returns 'mutex:&card->dapm_mutex'.
> 	  Locked on:   line 1194
> 	  Unlocked on: line 1199
> 

Thanks, I'll send a fix.
