From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Thu, 27 Oct 2005 16:02:00 -0400
Message-ID: <1130443320.19492.70.camel@mindpipe>
References: <8a0c36780510261413j2d5673a2tff4603dd59020648@mail.gmail.com>
	 <Pine.HPX.4.33n.0510270958560.2999-100000@studcom.urz.uni-halle.de>
	 <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
	 <1130439051.19492.53.camel@mindpipe>
	 <8a0c36780510271217qc817e06yabc43734713fe180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8a0c36780510271217qc817e06yabc43734713fe180@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Smith <smithbone@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-10-27 at 14:17 -0500, Richard Smith wrote:
> > > Often its not enough to just to power cycle and replug the Audiophile
> > > which sometimes causes kernel oopses.
> >
> > Please post these oopses.  ANY oops is a bug in the kernel, no matter
> > what you did to cause it.
> 
> I'll create some and post them tonight.

Also, arecord | aplay is not too good for debugging because you can't
tell where in the pipe the noise is introduced.  You need to compare the
output of arecord with some "known good" .wav files.

You are using plughw and not hw for both record and playback right?
Otherwise arecord | aplay can't possibly work, because arecord will not
output in S24_3BE format.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
