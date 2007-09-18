From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: Current ad1848/cs4231 mce_down code
Date: Tue, 18 Sep 2007 09:28:21 +0200
Message-ID: <20070918092821.773e522c.krzysztof.h1@gmail.com>
References: <46EF2188.60704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 6312124467
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 09:20:59 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1188529nfd
	for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2007 00:20:58 -0700 (PDT)
In-Reply-To: <46EF2188.60704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Sep 2007 02:53:28 +0200
Rene Herman <rene.herman@gmail.com> wrote:


> At (---) we are no longer atomic, so imagine being pre-empted there. When we 
> get back, we may/will well be past end_time and although by now calibration 
> has long finished, we bail out believing we've timed out.
> 
Good catch.

> 
> Moreover, we aren't under lock at all in the cs4231 version (which also 
> means that msleep(1) thing is in fact fine there). Can't we do that for 
> ad1848 as well?
> 

The lock is right thing to do as Trent found out. The in() call writes
to register. On the SMP setup it may backfire (cs4231 does not have
locks but sparc cs4231 has them).

Regards,
Krzysztof
