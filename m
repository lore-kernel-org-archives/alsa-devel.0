From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: ymfpci : four speakers with OSS-emulation ?
Date: Wed, 13 Mar 2002 15:01:11 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NGBBLNODKDFPBFMBBFAFMEKNCDAA.James@superbug.demon.co.uk>
References: <Pine.LNX.4.10.10203130918180.10800-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Received: from anchor-post-36.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.94])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA08034
	for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2002 16:00:23 +0100
In-Reply-To: <Pine.LNX.4.10.10203130918180.10800-100000@sorrow.ashke.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Adam K Kirchhoff <adamk@voicenet.com>
Cc: Xavier ALLAMIGEON <xavier.allamigeon@libertysurf.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

try
alsaplayer -Dsurround40 foo.mp3

That works on a sb live.

Cheers
James


> -----Original Message-----
> From: Adam K Kirchhoff [mailto:adamk@voicenet.com]
> Sent: 13 March 2002 14:26
> To: James Courtier-Dutton
> Cc: Xavier ALLAMIGEON; alsa-devel@alsa-project.org
> Subject: RE: [Alsa-devel] ymfpci : four speakers with OSS-emulation ?
>
>
>
> On Wed, 13 Mar 2002, James Courtier-Dutton wrote:
>
> > What command line do you use for aplay, alsaplayer.
>
> $ alsaplayer foo.mp3
>
> Will play on the front speakers.
>
> $ alsaplayer -Dhw:0,2 foo.mp3
>
> Will play on the rear speakers.
>
> I had almost this exact same conversation on this mailing list last month
> and we came to the conclusion that there is no way to get the output to
> default to both the front and rear speakers with the current setup.
>
> Adam
>
> > For the device name, you can use "default", "front", "rear" and
> "surround40"
> > with a SB Live.(The card I have.) instead of "plug:0,0" or similar.
> >
> > What device names do you use for the ymfpci ?
> > Cheers
> > James
> >
> > > -----Original Message-----
> > > From: Adam K Kirchhoff [mailto:adamk@voicenet.com]
> > > Sent: 13 March 2002 13:58
> > > To: James Courtier-Dutton
> > > Cc: Xavier ALLAMIGEON; alsa-devel@alsa-project.org
> > > Subject: RE: [Alsa-devel] ymfpci : four speakers with OSS-emulation ?
> > >
> > >
> > >
> > > Well, the ymfpci driver (with native Alsa support) only uses the front
> > > speakers by default, unless the application (ie. aplay, alsaplayer) is
> > > told the use the rear speakers. In either case, you can still only get
> > > output on either the front or the rear :-)  So rewriting the
> application
> > > wouldn't necessarily solve the problem.
> > >
> > > Even if that wasn't the case, and rewring the application did
> resolve the
> > > issue, it doesn't really do the end user any good if they have to wait
> > > around for every application (some of which may now be
> unsupported) to be
> > > rewritten to support Alsa natively :-)
> > >
> > > Adam
> > >
> > > On Wed, 13 Mar 2002, James Courtier-Dutton wrote:
> > >
> > > > Why not just change the app to support alsa 0.9.x.
> > > > alsa 0.9.x is now in kernel 2.5.x, so the app should really move to
> > > > supporting it anyway.
> > > > Cheers
> > > > James
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: alsa-devel-admin@lists.sourceforge.net
> > > > > [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Xavier
> > > > > ALLAMIGEON
> > > > > Sent: 12 March 2002 21:11
> > > > > To: alsa-devel@alsa-project.org
> > > > > Subject: [Alsa-devel] ymfpci : four speakers with OSS-emulation ?
> > > > >
> > > > >
> > > > > 	Good evening,
> > > > > I have installed the alsa-driver0.9.0beta12 on my MDK8.1 (kernel
> > > > > 2.4.18), and
> > > > > my rear speakers work. For example with "aplay -Dhw:0,2 foo.wav".
> > > > > Is this possible to use the four speakers together under alsa or
> > > > > under the
> > > > > OSS emulation, with a sound card based on the ymfpci modules ?
> > > > > I know it works with a SBLive!. Besides, I have seen that
> there are
> > > > > interesting configuration files in /usr/share/alsa. What must I
> > > > > do if I want
> > > > > the changes of these files to take effect ?
> > > > > Thanks for all !
> > > > >
> > > > > _______________________________________________
> > > > > Alsa-devel mailing list
> > > > > Alsa-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > > >
> > > >
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > > >
> > >
> >
> >
>
>
>


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
