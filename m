From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Status of M-Audio Audiophile USB
Date: Fri, 28 Oct 2005 17:15:24 -0400
Message-ID: <1130534124.4363.154.camel@mindpipe>
References: <8a0c36780510271056q5bf98a9p9d8f05f8816fbf4@mail.gmail.com>
	 <Pine.HPX.4.33n.0510281416340.24464-100000@studcom.urz.uni-halle.de>
	 <8a0c36780510281134gce42934v61b094b072d8f841@mail.gmail.com>
	 <1130525389.4363.53.camel@mindpipe>
	 <8a0c36780510281201p4958ade5je270e39c33608c4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8a0c36780510281201p4958ade5je270e39c33608c4f@mail.gmail.com>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-10-28 at 14:01 -0500, Richard Smith wrote:
> > Because arecord | aplay does not account for the inherent realtime
> > constraint.  I suspect "nice -n -20 arecord | nice -n -20 aplay" would
> > work.
> 
> I'll try and see.
> 
> > Keep in mind that 24/96 full duplex over USB 1.1 is really pushing the
> > USB bandwidth limits.  Most people I talk to report that this doesn't
> > work reliably on any OS.
> 
> Why would it only doing USB 1.1?  I thought this was USB 2.0 device.

Argh, sorry.  I can never remember whether "full speed" or "high speed"
is the faster one.  That's what happens when you let the idiots from
marketing name the protocol.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
