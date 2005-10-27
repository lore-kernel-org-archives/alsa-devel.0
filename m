From: Richard Smith <smithbone@gmail.com>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Thu, 27 Oct 2005 16:01:40 -0500
Message-ID: <8a0c36780510271401s74613f4bgd2a66faa393b055e@mail.gmail.com>
References: <8a0c36780510261413j2d5673a2tff4603dd59020648@mail.gmail.com>
	 <Pine.HPX.4.33n.0510270958560.2999-100000@studcom.urz.uni-halle.de>
	 <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
	 <1130439051.19492.53.camel@mindpipe>
	 <8a0c36780510271217qc817e06yabc43734713fe180@mail.gmail.com>
	 <1130443320.19492.70.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130443320.19492.70.camel@mindpipe>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
> Also, arecord | aplay is not too good for debugging because you can't
> tell where in the pipe the noise is introduced.  You need to compare the
> output of arecord with some "known good" .wav files.

It's pretty obvious when it happens.  The noise is all there is.  Its
not noise on top of the audio, its _completely noise_.   Sounds just
like you hooked it up to a white or pink noise generator.  Loud too.

> You are using plughw and not hw for both record and playback right?

I was using many differnt permutations.

> Otherwise arecord | aplay can't possibly work, because arecord will not
> output in S24_3BE format.

Well thats good to know and may explain a few things.  It dosen't
complain.  What about -t raw?

Hmm. so how can I test the 24/96kHz mode then?

--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
