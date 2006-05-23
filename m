From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: 2.6.17-rc4-mm3
Date: Tue, 23 May 2006 17:35:11 -0400
Message-ID: <1148420112.12529.169.camel__29469.74684387$1148420201$gmane$org@mindpipe>
References: <20060522022709.633a7a7f.akpm@osdl.org>
	 <6bffcb0e0605231407v11453f63t8b7335fd614ccdf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8C7E317B
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 23:35:15 +0200 (MEST)
In-Reply-To: <6bffcb0e0605231407v11453f63t8b7335fd614ccdf9@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-23 at 23:07 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 22/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/
> >
> [snip]
> >  git-alsa.patch
> 
> I have noticed small problem with ALSA.
> When I boot 2.6.17-rc4-mm3 everything is ok, then I switch to
> 2.6.17-rc4-git11 - everything is ok. But when I switch back to
> 2.6.17-rc4-mm3 PCM is mute (off), Spread Front to Surround and
> Center/LFE is off, Channel Mode is set to 2ch (should be 6ch).
> 
> /sbin/alsactl -v
> alsactl version 1.0.11rc2
> 
> This is an user space tools bug?

If the mixer controls changed between those versions, then alsactl will
be unable to completely restore the mixer state.

Otherwise the problem is with your userspace tools.  I think KDE likes
to save/restore mixer settings on its own and its ALSA support is
horribly buggy.

It would help if you determine what app is saving/restoring the mixer
settings.

Lee




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
