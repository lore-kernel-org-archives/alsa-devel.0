From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Sat, 29 Oct 2005 21:02:37 +0100
Message-ID: <20051029200236.GA2037@palantir8>
References: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com> <Pine.HPX.4.33n.0510281416340.24464-100000@studcom.urz.uni-halle.de> <8a0c36780510281134gce42934v61b094b072d8f841@mail.gmail.com> <1130525464.4363.55.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1130525464.4363.55.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 28, 2005 at 02:51:03PM -0400, Lee Revell wrote:
> On Fri, 2005-10-28 at 13:34 -0500, Richard Smith wrote:
> > Next I tried to get jackd up but jackd dosen't like S24_3BE and if I
> > use plughw I get XRUNS. 
> 
> Known issue.  JACK doesn't like plughw but does not support big endian
> formats.  See jackit-devel archives for a patch.

Almost right :). Jack expects the same endianness of the CPU and sound
card. Patches:
http://sourceforge.net/tracker/index.php?func=detail&aid=1289682&group_id=39687&atid=425939

-- 
Martin


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
