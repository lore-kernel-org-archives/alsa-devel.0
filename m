From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] conf: Allow for a directory to be given as
 a config file.
Date: Mon, 12 Sep 2011 08:57:42 +0200
Message-ID: <4E6DAD66.3080204@perex.cz>
References: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
	<1315744838-21911-2-git-send-email-gmane@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id CB5BE2437E
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 08:57:42 +0200 (CEST)
In-Reply-To: <1315744838-21911-2-git-send-email-gmane@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: gmane@colin.guthr.ie
Cc: Colin Guthrie <colin@mageia.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 11.9.2011 14:40, gmane@colin.guthr.ie wrote:
> From: Colin Guthrie <colin@mageia.org>
> 
> When this is done, *.conf files can be placed in that directory and they
> will be processed by as if they were included directly.
> 
> A directory (typically /usr/share/alsa/alsa.conf.d/) has been
> added into the distribution.

Thanks for this patch.


> +@hooks [
> +	{
> +		func load
> +		files [
> +			"@ALSA_CONFIG_DIR@/alsa.conf.d/"

I think that it might be more flexible and analogical to keep the
original configuration file and implement the confdir function - see the
datadir example.

Implemented:

	"{ @func datadir }"

To be added:

	"{ @func confdir }"

See snd_func_datadir() in confmisc.c.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
