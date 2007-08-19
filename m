From: Michael Gerdau <mgerdau@tiscali.de>
Subject: Re:
	=?iso-8859-1?q?=5BAlsa-user=5D_Impossible_to_make_su?=
	=?iso-8859-1?q?bwoofer_work_on_a=09Dell_XPS_M1710w?=
Date: Sun, 19 Aug 2007 15:31:56 +0200
Message-ID: <200708191532.11011.mgerdau@tiscali.de>
References: <46C4E23A.5090000@gia.usb.ve>
	<200708171909.49451.mgerdau@tiscali.de>
	<s5h7inunjnw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2371220016987239162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BCE224382
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Aug 2007 15:32:05 +0200 (CEST)
In-Reply-To: <s5h7inunjnw.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============2371220016987239162==
Content-Type: multipart/signed;
  boundary="nextPart45681216.iAJ0KnHGXd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart45681216.iAJ0KnHGXd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Do you mean a problem with the missing LFE?  The missing LFE sounds
> like a different problem.  AFAIK, the device itself _is_ set up
> properly as expected.

I mean the missing LFE.

I can confirm the device otherwise works as adverticed. In fact I only
(kind of) miss the LFE since I read in another post it should be there :-)

> And, if it's about debugging, let's discuss on alsa-devel ML and drop
> Cc from alsa-users.

I've run the current alsa-info.sh as suggested by Tobis Davis (thanks
for the pointer BTW) and had it upload the result automatically.

> Why not patch the code :)

That was my first idea :)

When I boldly started looking at it I realized I'm in for a steep learning
curve. Not that I won't walk that road, but it will take me some time...

=46or a start I downloaded "Writing an alsa driver" and alsa-driver-api and
will start reading it "real soon" (TM)

> As a hint, if it's really a regression, try to revert to the version
> it did work.  Check /proc/asound/card0/codec#* file to see which
> widget is changed by the LFE volume.  That's the vital information.

I don't know whether it actually is a regression or a not-yet-implemented
feature. I do own my XPS M1710 since around March/April 2007 and I don't
recall to have seen it. However sound worked right from the start and until
recently I wasn't even aware there should be a LFE control. In fact the
only "evidence" I have there should be one is already mentioned other post.


That having said:
The link http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh should
probably go into ALSA-Configuration.txt

I also suggest to add a troubleshooting section into the navigation block
of the entry page of alsa wiki (or move the existing one there -- I have
not been able to easily find an existing one though) which mentions this
link as well as all other stuff that a user should be aware of when
reporting a problem.

If it isn't easy to provide concise troubleshooting instructions it would
at least be helpful to give an overview where and how to find the relevant
info in the wiki.

After all the user having a problem often is just starting learning alsa.

Best,
Michael
=2D-=20
 Vote against SPAM - see http://www.politik-digital.de/spam/
 !tagline
 Michael Gerdau       email: mgerdau@tiscali.de
 GPG-keys available on request or at public keyserver

--nextPart45681216.iAJ0KnHGXd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGyEZaUYYhyuxDQc4RAv15AJ9TbbVJszV+BbNDsyyXdC4x3P7KUwCfVo98
uZ54PPgFhVkKvYoJxEe5ioc=
=Wsdj
-----END PGP SIGNATURE-----

--nextPart45681216.iAJ0KnHGXd--

--===============2371220016987239162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2371220016987239162==--
