From: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
Subject: Re: [PATCH] alsa: correct nonsensical sysfs device
	symlinks
Date: Thu, 25 Jan 2007 10:57:25 -0500
Message-ID: <806dafc20701250757n3dcb38b7ma5f8423ab3de9850@mail.gmail.com>
References: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>
	<20070125042616.GA21813@kroah.com>
	<806dafc20701250611u9935049ja8f88deb2aac4d40@mail.gmail.com>
	<45B8C9A3.6060107@drzeus.cx>
	<806dafc20701250736yc5c3048u14ec98e9b6b92574@mail.gmail.com>
	<45B8CF7E.2040908@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6445B324
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 16:57:26 +0100 (MET)
Received: by nz-out-0506.google.com with SMTP id l8so419397nzf
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 07:57:25 -0800 (PST)
In-Reply-To: <45B8CF7E.2040908@drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: fedora-desktop-list@redhat.com, alsa-devel@alsa-project.org, jrb@redhat.com, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, mclasen@redhat.com, Lennart Poettering <lennart@poettering.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On 1/25/07, Pierre Ossman <drzeus@drzeus.cx> wrote:

> There is some option about deprecated sysfs stuff. Perhaps this is the
> cause of your twisted tree. It's off here:
>
> # CONFIG_SYSFS_DEPRECATED is not set

It is set.  It is also set in the default config, so plently of people
are running with a broken sysfs tree.

I assume we agree that even if that's set, the tree should not be
outright broken like it is (the compatability mode should actually be
compatable, ie, work, right? :-)  Given that, is my patch correct?
What was there (plugging the old 'dev' arg into the new call's
'parent' makes no sense) is clearly wrong.

And it's clear my pacth is incomplete, as it doesn't correct the
device entries for the other entries.

Monty

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
