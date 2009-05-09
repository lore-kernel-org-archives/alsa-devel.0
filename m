From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Sun, 10 May 2009 00:11:39 +0200
Message-ID: <20090509221139.GC23851@tango.0pointer.de>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de>
	<20090507124651.GA3968@tango.0pointer.de>
	<s5hiqkd2gra.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id BF086244A0
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 00:11:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiqkd2gra.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

On Thu, 07.05.09 15:18, Takashi Iwai (tiwai@suse.de) wrote:

> > > Fixing it isn't too difficult with vmaster stuff in the driver side,
> > > but this breaks the compatibility, and hard to find the real test
> > > machines nowadays.  In short, "don't touch a working system unless it
> > > gets broken" phase.
> > 
> > Breaks compatibility with what exactly? OSS?
> 
> Yes, and old ALSA-native apps without PA.

Hmm. why exactly should that happen? I mean, the ALSA mixer API knew
definitions like snd_mixer_selem_channel_id since about the beginning
of time. Just making use of it shouldn't cause breakage in programs.

And even when if it does, this would be the 'softest' kind of breakage
one can think of. Also, most of the apps in question are Free Software
and could hence be fixed easily.

> > May I assume that they always are dependant?
> 
> If both exist, then they should be dependent, and Master should be
> really Master.

Hmm, ok. So you say "Master" in this case is more "outside" and
"Front" is more to the "inside", right? I.e. from the applications PoV
Front is first, Master follows as last step, right?

> > Hmm, could you be more explicit which apps you think would break? I
> > mean, the ALSA mixer API always allowed multichannel audio, however no
> > driver actually made use of that. If a client is using the ALSA mixer
> > API properly it should not break. And if it doesn't use it properly
> > it's not ALSA's fault...
> 
> kmix surely won't work.  GNOME mixer?  I don't think it would.

The new GNOME mixer links against PA, so it would support it
indirectly. ;-)

> Many media players (new and old) support a mixer adjustment more or
> less, and certainly many of they won't work with multi channels.

But to which effect? The worst thing that could happen is that they
wouldn't show the Surround channels properly. But usually they
wouldn't show that anyway..

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
