From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Default enabling of mixer controls
Date: Tue, 9 Jun 2009 09:57:39 +0300
Message-ID: <200906090957.39758.peter.ujfalusi@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030591A896@dbde02.ent.ti.com>
	<20090608143910.GA6413@rakim.wolfsonmicro.main>
	<5A47E75E594F054BAF48C5E4FC4B92AB030591A9D1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id AB1EF24544
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 08:58:01 +0200 (CEST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030591A9D1@dbde02.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 09 June 2009 06:45:24 ext Aggarwal, Anuj wrote:
> > Hrm, you'll be missing some internal DAPM state updates.  Currently the
> > most direct way to do that would be to go through the actual control
> > interface and there's not a particularly nice way of doing that that
> > from the kernel that I'm aware of.

Should the snd_soc_dapm_sync(codec); need to be called after the register =

updates?

> >
> > Is this not something you can have user space do?
>
> [Aggarwal, Anuj] Since this was by default enabled in my earlier codec
> driver, I wanted to make the change transparent to the end user. However,
> since the same can be done from user space too, it should not be a problem
> for my customer.

I think this should be done by the user space as well. I have had plans to =

disable all paths by default on the twl4030 codec, and let the user space t=
o =

configure for the given board. At least that is what we are doing in our =

custom board.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

P=E9ter
