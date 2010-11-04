From: Pontus Oldberg <pontus.oldberg@axis.com>
Subject: VB:  Retrieving original timestamps in dsnoop.
Date: Thu, 4 Nov 2010 12:22:18 +0100
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749BEFE4D80@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC749BEFE4D78@xmail3.se.axis.com>,
	<alpine.LNX.2.00.1010291710060.29422@eeebox2.perex-int.cz>,
	<A612847CFE53224C91B23E3A5B48BAC749BEFE4D79@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D468B1037F9
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 12:23:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 41B0619D13
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 12:23:45 +0100 (CET)
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Rpvn6VBHRRUt for <alsa-devel@alsa-project.org>;
	Thu,  4 Nov 2010 12:23:44 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 2FE0919D74
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 12:23:42 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id 43CC13412C
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 12:23:42 +0100 (CET)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749BEFE4D79@xmail3.se.axis.com>
Content-Language: sv-SE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav,

I have tested the patch you provided and it works perfectly. Thanks a lot.
Is this something that will be pushed to master and/or included in a releas=
e in the future ??

Many thanks
/Pontus
________________________________________
Fr=E5n: Pontus Oldberg
Skickat: den 1 november 2010 09:20
Till: alsa-devel@alsa-project.org
=C4mne: SV: [alsa-devel] Retrieving original timestamps in dsnoop.

Fr=E5n: Jaroslav Kysela [perex@perex.cz]
Skickat: den 29 oktober 2010 17:41
Till: Pontus Oldberg
Kopia: alsa-devel@alsa-project.org
=C4mne: Re: [alsa-devel] Retrieving original timestamps in dsnoop.

On Fri, 29 Oct 2010, Pontus Oldberg wrote:

> Hello, I am working in a gstreamer based project where we are using
> alsasrc to feed the audio pipeline. On of the things that we need to be
> able to do is to get the monotonic timestamp from the alsalib in order
> for our video and audio to be perfectly synchronized. This worked fine
> until we introduced the dsnoop plug-in which creates its own timestamp
> reference. I have played around with the dsnoop plugin and created a
> preliminary fix that gives us the result that we want.
>
> I'd like to know if this looks like the way to go or if this can be
> obtained in any other way. We are using dsnoop in order to be able to
> create two separate audio pipelines, we don't care about stereo, just
> simple mono streams.

Your version is a bit tricky. Could you try my version at:

http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dcommitdiff;h=3D13b5d972d2=
e7a5f0e6f3c066684dbb01fafd5121

                                        Thank you,
                                                Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

Jaroslav,
Thanks, I will try it right away and report back.

/Pontus
________________________________________
