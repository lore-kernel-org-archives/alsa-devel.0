From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA - Add support for the OQO Model 2
Date: Sun, 03 Feb 2008 12:53:09 -0800
Message-ID: <1202071989.24072.154.camel@razman.gruemaster.com>
References: <1201822394.23369.108.camel@razman.gruemaster.com>
	<s5hejbw3mc8.wl%tiwai@suse.de>
	<1201878104.24072.22.camel@razman.gruemaster.com>
	<s5hmyqk1zh0.wl%tiwai@suse.de>  <s5h7ihlu98n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id E042D103889
	for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2008 21:53:11 +0100 (CET)
In-Reply-To: <s5h7ihlu98n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks, boss.


On Sun, 2008-02-03 at 20:32 +0100, Takashi Iwai wrote:

> At Fri, 01 Feb 2008 16:13:47 +0100,
> I wrote:
> > 
> > At Fri, 01 Feb 2008 07:01:44 -0800,
> > Tobin Davis wrote:
> > > 
> > > On Fri, 2008-02-01 at 13:14 +0100, Takashi Iwai wrote:
> > > 
> > >     At Thu, 31 Jan 2008 15:33:14 -0800,
> > >     Tobin Davis wrote:
> > >     > 
> > >     > This patch adds support for the OQO Model 2 Ultra Mobile PC.
> > >     > 
> > >     > 
> > >     > Signed off by Tobin Davis <tdavis@dsl-only.net>
> > >     
> > >     Thanks.  I'll apply it after 1.0.16 release.
> > > 
> > > When's the next release window?  My contact at IDT (Sigmatel) was hoping to get
> > > it in this release, he just didn't get back to me with the test results until
> > > yesterday.
> > 
> > 1.0.16 will be released in the next week.
> > As Jaroslav already announced, we want to avoid patches except for bug
> > fixes until the release.
> 
> On the second thought, it's easier to integrate this patch right now
> because it's very local and cannot break others.  So, I applied OQO
> patch to HG tree to be merged to 1.0.16.
> 
> 
> thanks,
> 
> Takashi
