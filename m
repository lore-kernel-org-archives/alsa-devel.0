From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: pcm,
 rename variables in prep for ping/pong
Date: Thu, 03 Sep 2009 12:24:26 -0700
Message-ID: <4AA017EA.8080006@boundarydevices.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
	<200909031206.21020.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D40510383B
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 21:24:38 +0200 (CEST)
In-Reply-To: <200909031206.21020.david-b@pacbell.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Brownell <david-b@pacbell.net>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

David Brownell wrote:
> On Monday 31 August 2009, Troy Kisky wrote:
>> -       int master_lch;         /* Master DMA channel */
>> -       int slave_lch;          /* linked parameter RAM reload slot */
>> +       int asp_master_lch;     /* Master DMA channel */
>> +       int asp_link_lch[2];    /* asp parameter link channel, ping/pong */
> 
> If you're going to rename things, may I suggest getting
> rid of "lch" ... use either "channel" or "link", since
> those are the two basic hardware roles in EDMA.
> 
> The original "lch" ("logical channel") terminology was
> an IMO misguded attempt to hide the distinction between
> channels and links.  But links can not be used when a
> channel is required, so that attempt was doomed to fail.
> (Channels could double as links, but as a rule that's
> not done since they're relatively scarce.)
> 
> - Dave
> 
> 
> 
I agree, but can that be a separate patch...
