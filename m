From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 2/3 v3] alsa-lib: fixed coverity reported
 issues under "RESOURCE_LEAK" checker.
Date: Tue, 05 Apr 2011 10:45:30 +0300
Message-ID: <1301989530.16314.252.camel@Sudarshan.research.nokia.com>
References: <1301907239-1873-1-git-send-email-sudarshan.bisht@nokia.com>
	<1301907239-1873-2-git-send-email-sudarshan.bisht@nokia.com>
	<4D9A0032.6010601@gmail.com>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C65E1039FB
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 09:47:52 +0200 (CEST)
In-Reply-To: <4D9A0032.6010601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Steve Calfee <stevecalfee@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-04-04 at 10:30 -0700, ext Steve Calfee wrote:
> On 04/04/11 01:53, sudarshan.bisht@nokia.com wrote:
> 
> > @@ -1847,6 +1848,7 @@ int snd_config_delete(snd_config_t *config)
> >  		list_del(&config->list);
> >  	free(config->id);
> >  	free(config);
> > +	config = NULL;	  	
> >  	return 0;
> >  }
> 
> I don't see how this could be correct. You free memory, clear the
> calling param pointing to it and then return? What is the point of
> nulling the local pointer?
yes,  this is not needed actually. 
> 
> Regards, Steve


Thanks,

-Sudarshan 
