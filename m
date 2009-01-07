From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: alsa-info security/privacy concerns
Date: Wed, 7 Jan 2009 17:14:12 +0800
Message-ID: <20090107091412.GA14855@localhost>
References: <20090107075333.GA806@localhost>
	<Pine.LNX.4.61.0901070920060.8273@tm8103.perex-int.cz>
	<20090107083306.GA5282@localhost> <s5hmye3sd0g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id B6C101037E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 10:14:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmye3sd0g.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Travis Place <wishie@wishie.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 07, 2009 at 11:04:31AM +0200, Takashi Iwai wrote:
> At Wed, 7 Jan 2009 16:33:06 +0800,
> Wu Fengguang wrote:
> > 
> > Hi Jaroslav,
> > 
> > On Wed, Jan 07, 2009 at 10:22:13AM +0200, Jaroslav Kysela wrote:
> > > On Wed, 7 Jan 2009, Wu Fengguang wrote:
> > > 
> > > > Greetings,
> > > > 
> > > > The auto-uploading behavior of http://www.alsa-project.org/alsa-info.sh
> > > > makes it act like a spyware.
> > > 
> > > The script always prompts before the upload action, so user can break it. 
> > > Just read the first dialog.
> > 
> > What I'd like to add is a dedicated dialog for the warning message and
> > let users interactively choose between yes/no for uploading.
> > 
> > Doesn't it sound reasonable?
> 
> [Added Travis to Cc]
> 
> I like the idea.   We can give the following options:
> 
> - the greeting dialog informs that the script collects info, waits
>   for Y/N or OK button.
> - when --upload option is given, the data will be automatically
>   uploaded.
> - when --no-upload option is given, the data is just stored locally
>   and quit.
> - when neither options are given, show a dialog to ask to upload or
>   not.

Good ideas, I'd embrace them!

Thanks,
Fengguang
