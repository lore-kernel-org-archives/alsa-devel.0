From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] tlv320aic3x: control additions and cleanups
Date: Fri, 5 Dec 2008 15:02:20 +0200
Message-ID: <bd7b27490812050502o331d4f5dn2c9bbb3c4fd36169@mail.gmail.com>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
	<20081204184751.GE21010@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by alsa0.perex.cz (Postfix) with ESMTP id A743710381C
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 14:02:21 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so4681261wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 05:02:20 -0800 (PST)
In-Reply-To: <20081204184751.GE21010@buzzloop.caiaq.de>
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
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org, u.luckas@road.de
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 4, 2008 at 8:47 PM, Daniel Mack <daniel@caiaq.org> wrote:

> Hi Mark,
>
> On Thu, Dec 04, 2008 at 06:37:47PM +0000, Mark Brown wrote:
> > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > > Signed-off-by: Uli Luckas <u.luckas@road.de>
> > Did you write this patch or did Uli?  If you wrote it the line for Uli
> > should be an Acked-by, if he wrote it then your Signed-off-by should
> > come second and it should have a From: for him at the top.
>
> We're working on it together and share a git repository. I commited the
> patch, sent it over to Uli to double-check it and he signed off on it
> after I did it in the first place.
>
> I thought in such cases, two Signed-off-by: lines coming right after the
> other is the way to go, but I can also change it to an 'Acked-by' if you
> like.
>
> I'll wait for Jarkko's comments and repost.
>
> I just checked & tested a fix which changes those "xxx DAC Playback Switch"
to "xxx Playback Switch" are correct. That would also allow to develop new
"xxx Playback Volume" controls and gain 9 dB more of output level :-)


Jarkko
