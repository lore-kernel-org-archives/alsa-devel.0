From: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
Subject: Re: [PATCH] alsa: correct nonsensical sysfs device
	symlinks
Date: Thu, 25 Jan 2007 10:36:55 -0500
Message-ID: <806dafc20701250736yc5c3048u14ec98e9b6b92574__2499.35253891653$1169739680$gmane$org@mail.gmail.com>
References: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>
	<20070125042616.GA21813@kroah.com>
	<806dafc20701250611u9935049ja8f88deb2aac4d40@mail.gmail.com>
	<45B8C9A3.6060107@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5C641325
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 16:36:57 +0100 (MET)
Received: by nz-out-0506.google.com with SMTP id l8so415037nzf
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 07:36:56 -0800 (PST)
In-Reply-To: <45B8C9A3.6060107@drzeus.cx>
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
> Christopher "Monty" Montgomery wrote:
> >
> > My machines and the fedora rawhide machines using the 2.6.20-rcX
> > releases look nothing like what you pasted.  If they did, hald would
> > be working...  (I'll note that bugs have also been logged against
> > Pulse and HAL by users having trouble, so it's not just us.)
>
> On my vanilla 2.6.20-rc5, I get the same structure as Greg. Yet hal
> still doesn't pick stuff up as it should.

Interesting to know.  Looking more closely, it looks like machines
here are split between the messed up output I forwarded previously and
the output that is expected.  All of my personal boxes are messed up.

Having looked at HAL earlier, it appeared to have code to parse the
new format but if it desn't work, it doesn't work.  Updating HAL is
relatively easy but I can't test the changes on my own boxes because
they have the messed up /sys/class/sound structure.

Monty

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
