From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA 1.0.15rc1
Date: Sat, 1 Sep 2007 10:07:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0709011002250.7587@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz>
	<20070831152353.GA28438@frodo.home.lxtec.de>
	<20070831174958.GB28438@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B66E24179
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Sep 2007 10:07:37 +0200 (CEST)
In-Reply-To: <20070831174958.GB28438@frodo.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: alsa-devel@alsa-project.org, pkg-alsa-devel@lists.alioth.debian.org
List-Id: alsa-devel@alsa-project.org

On Fri, 31 Aug 2007, Elimar Riesebieter wrote:

> On Fri, 31 Aug 2007 the mental interface of
> Elimar Riesebieter told:
> 
> [...]
> > Is there a tool to extract the text similar formatted as the old
> > "v1-0-14rc4--v1-0-14.txt"? Isn't it usual to package a changelog to
> > the sources?
> 
> Well using lynx (print to file) and some vim actions are doing the
> trick, But anyway, shouldn't it be included in sources?

It's probably better to extract the wiki source text from <textarea> tag 
when you download the edit page (only html entities like &lt; etc. should 
be converted back to text):

http://www.alsa-project.org/main/index.php?title=Changes_v1.0.14_v1.0.15rc1&action=edit

Actually, I have no plans to add this history to source files. Anyone can 
get this information from www or extract it from the HG repository.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
