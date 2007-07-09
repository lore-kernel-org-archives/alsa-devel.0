From: Dan Aloni <da-x@monatomic.org>
Subject: Re: ALC882 on Abit AW9D-MAX
Date: Tue, 10 Jul 2007 00:20:54 +0300
Message-ID: <20070709212054.GA8359@localdomain>
References: <20070412100959.GA8944@localdomain> <s5hmz1dwz2u.wl%tiwai@suse.de>
	<20070412211141.GA8625@localdomain>
	<s5hy7kwvakg.wl%tiwai@suse.de> <s5hd521hnlw.wl%tiwai@suse.de>
	<20070420104946.GA22826@localdomain> <s5hy7knwbt8.wl%tiwai@suse.de>
	<20070420111318.GA3134@localdomain> <s5hmz13w26e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from noname.neutralserver.com (noname.neutralserver.com
	[70.84.186.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 0246B103896
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 23:20:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmz13w26e.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 20, 2007 at 04:28:09PM +0200, Takashi Iwai wrote:
> At Fri, 20 Apr 2007 14:13:18 +0300,
> Dan Aloni wrote:
> > 
> > On Fri, Apr 20, 2007 at 01:00:03PM +0200, Takashi Iwai wrote:
> > > At Fri, 20 Apr 2007 13:49:47 +0300,
> > > Dan Aloni wrote:
> > [...]
> > > > case 4 originally does {1<=3,3<=2,2<=1}, my working fix effectively 
> > > > adds {1<=2,2<=1}, which means we need to do {1<=1,3<=2,2<=3}, or just
> > > > {3<=2,2<=3}.
> > > > 
> > > > Right?
> > > 
> > > Sounds so.  Could you attach the content of /proc/asound/card0/codec#*
> > > file to re-check?
> > 
> > Okay. I got the following output *with* my fix applied:
> 
> Thanks.  Apparently the default pin config values are wrong, so it's a
> BIOS bug.
> 
> I reread the pin-configuration spec and my last patch is correct.  The
> configuration of 7.1 outputs is Front/CLFE/Rear/Side.  So, I committed
> a patch to HG tree.
> 
> Now about your fix.  I think the best way is to override the pin
> default configuration.  The patch below is the fix on the top of the
> latest ALSA HG tree.  Use hg.alsa-project.org since
> hg-mirror.alsa-project.org seems (again) out of sync right now.

The patch works great with 2.6.22.

Thanks.

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il
