From: "Ing. Jozef Sakalos" <jsakalos@bigfoot.com>
Subject: Re: Alsa mixer for KDE
Date: Wed, 30 Apr 2003 21:33:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304302133.57828.jsakalos@bigfoot.com>
References: <E198Alp-0004WE-00@sc8-sf-list2.sourceforge.net> <200304301001.50711.jsakalos@bigfoot.com> <200304302036.42116.esken@kde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304302036.42116.esken@kde.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Esken <esken@kde.org>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Chris,

I'm REALLY pleased that kmix is alsa mixer. How should I compile it 
to enable alsa? (I compiled my KDE 3.1.1 myself - on SuSE 8.0)

Regards,
Ing. Jozef Sakalos

On Wednesday 30 April 2003 20:37, you wrote:
> On Wednesday 30 April 2003 10:02, Ing. Jozef Sakalos wrote:
> > Hi Pavel,
> >
> > I am also searching for good alsa mixer for X and especially
> > for KDE. I'm placing this message in alsa-user and alsa-devel
> > mailing
>
> I really have to comment on this. Why don't you use KMix?
>
> > probaly you shouldn't except any further development. KDE kmix
> > is usable for simple tasks - this is oss mixer.
>
> KMix is ALSA, when you configure it to inlcude ALSA support. You
> can also compile in both ALSA- and OSS-Support (Depends on the
> packer, IIRC SuSE does so). KMix then decides which driver to
> use: Uses ALSA if there are ALSA-Mixers available, else uses OSS.
>
> > - have nice but simple interface (maybe with the possibility of
> > two
>
> yes
>
> > rows of controls - my Audigy 2 has about 40 controls)
>
> You can have two tabs instead. Current version (from CVS)
> automatically distributes controls on 1-3 tabs (Primary controls,
> Secondary controls, Switches). Specilized ALSA Switch-Handling is
> a TODO (e.g. does not need a slider).
>
> > - have hidable controls
>
> yes
>
> > - have movable controls
>
> no. but a nice idea.
>
> > - have one slider for left&right + balance with skip to center
>
> yes
>
> > - have possibility to create group of controls with a "Group
> > Master"
>
> no. But a nice idea.
>
> > - have configurable control names
>
> no
>
> > - use autoupdate (it should reflect changes made by other
> >   mixers/applications immediately)
>
> yes (dock icon and panel applet need some work).
>
> > - have mute/unmute ALL function
>
> (yes) => Just mute the master. 95% of all souncarads have a
> master.
>
> > - have the possibility to define,save and restore multiple
> > settings
>
> I like this very much. Unfortunately lost this ability in KDE2.
> :-(
>
> > - have the possibility to dock in panel like KDE kmix does
>
> Obviously yes
>
> > - have lirc interface (lirc is SW for IR remote controlling)
>
> Not directly, but you can fully "remote control" KMix
>
> > - be for KDE, gnome and all others
>
> Yes. KDE applications just run under X11. No problem starting
> under gnome, or under other Window managers.
>
> > - have everything else what somebody else can dream out
>
> For exaple Panel applet, global keyboard shortcuts
>
> > to change settings from a script (for example while handling a
> > multimedia keyboard events).
>
> yes. But for multimedia keyboard events, there is
> built-in-support. You can either use kmixctrl (limited interface)
> or dcop (full interface).
>
> > There are many others on the internet but I haven't found an
> > ideal one. Let me know if you are more successful.
>
> Well, obviously for me as author KMix is the optimal thing. Feel
> free to add wishes to the KMix wishlist (use http://bugs.kde.org
> and mark the new "bug" as "wish").
>
> Chris



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
