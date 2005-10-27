From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Thu, 27 Oct 2005 10:00:02 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510270958560.2999-100000@studcom.urz.uni-halle.de>
References: <8a0c36780510261413j2d5673a2tff4603dd59020648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8a0c36780510261413j2d5673a2tff4603dd59020648@mail.gmail.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richard Smith wrote:
> On 10/26/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Wed, 2005-10-26 at 14:16 -0500, Richard Smith wrote:
> > > What I haven't made work is recording.  Using arecord and hw:0,0 just
> > > gives silence and hw:0,1 white noise.
> >
> > What about arecord with plughw:0,0 and plughw:0,1?
>
> Hmm not sure.  I was actually testing with -t raw and  -f S24_3BE so
> thats why I was using hw.
>
> I'll try the plughw tonight.  What format should I use?

/proc/asound/cardX/stream0 lists all supported sample formats.
Please try every one.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
