From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [PATCH 2/3 v3] alsa-lib: fixed coverity reported
 issues under "RESOURCE_LEAK" checker.
Date: Mon, 04 Apr 2011 10:30:26 -0700
Message-ID: <4D9A0032.6010601@gmail.com>
References: <1301907239-1873-1-git-send-email-sudarshan.bisht@nokia.com>
	<1301907239-1873-2-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E1A4510380C
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 19:30:32 +0200 (CEST)
Received: by pvf33 with SMTP id 33so1660878pvf.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Apr 2011 10:30:30 -0700 (PDT)
In-Reply-To: <1301907239-1873-2-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sudarshan.bisht@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/04/11 01:53, sudarshan.bisht@nokia.com wrote:

> @@ -1847,6 +1848,7 @@ int snd_config_delete(snd_config_t *config)
>  		list_del(&config->list);
>  	free(config->id);
>  	free(config);
> +	config = NULL;	  	
>  	return 0;
>  }

I don't see how this could be correct. You free memory, clear the
calling param pointing to it and then return? What is the point of
nulling the local pointer?

Regards, Steve
