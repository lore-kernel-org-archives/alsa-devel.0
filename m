From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Bug in emu10k1 multichannel support
Date: Thu, 10 Feb 2005 19:59:22 -0500
Message-ID: <1108083562.15438.4.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>
	 <41FE5838.4060907@glocalnet.net>
	 <1108073865.11177.6.camel@krustophenia.net>
	 <420BEF63.60402@machinehasnoagenda.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <420BEF63.60402@machinehasnoagenda.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Shayne O'Connor <forums@machinehasnoagenda.com>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-11 at 10:33 +1100, Shayne O'Connor wrote:
> >Thanks, I have found and fixed the bug.
> >
> >http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v009.patch
> >
> >I believe the patch should now be mergeable.  All known bugs have been
> >fixed, and since I announced it on LAU and LAD the patch has had fairly
> >widespread testing.
> >
> >I will break the patch up and post one patch per file in the next few
> >days.
> >  
> >
> does this one have both the capture and playback patches? if not, would
> it be possible to combine the two, because i haven't had any success
> patching the cvs alsa driver that already contains the capture (or is
> that playback?) patch ...
> 
> i'm currently using the 008 patch, without too much drama ... except the
> slightly frustrating capturing of playback channels along with ac97 ...
> though this could be due to incorrect mixer settings ...

No version 009 does not have the capture patch because I am trying to
get the size of the patch down to merge it.

I just tested version 009 with ALSA CVS and it works fine.  Can you try
deleting the ALSA CVS directory, checking it out again and applying the
patch?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
