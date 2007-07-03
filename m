From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: Remove dynamic configuration from alsa-lib
Date: Tue, 3 Jul 2007 12:44:35 -0700
Message-ID: <20070703124435.4f6a739b@jutz-fc6.na.corp.dmxmusic.com>
References: <468A9F7E.3030806@tse.gov.br>
	<75b66ecd0707031215m609685aje041010626d7a5d@mail.gmail.com>
	<468AA38D.3030301@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E64210384D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 21:41:15 +0200 (CEST)
In-Reply-To: <468AA38D.3030301@tse.gov.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Cc: alsa-devel@alsa-project.org, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Jul 2007 16:29:17 -0300
"Fausto Carvalho Marques SIlva" <fausto@tse.gov.br> wrote:

> Lee Revell wrote:
> 
> >I doubt there's an easy way - why would you want to do that?
> >  
> >
> Because i have a "embedded device" that does not need the alsa.conf.

Might i suggest IWAI-san's 'salsa' lib? I *think* it forgo's the conf
stuff.


> My configuration is only:
> 
> pcm.default {
> 	type hw
> 	card 0
> 	device 0
> }
> 
> ctl.default {
> 	type hw
> 	card 0
> }
> 
> 
> No need for anything else...
> Could be a "program" that runs with a configure option ( 
> --conf-dynamic=<my-alsa.conf> ) for generating a
> static structure for "feeding" pcm, control,rawmidi and others...

I have been down this road for the exact same reason that you specify
and i have given up :-).

Matter of fact, i actually found that i *needed* stuff that is only
made available via settings in the /usr/share/alsa tree.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
