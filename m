From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [linux-audio-dev] jack and S24_3BE
Date: Fri, 28 Oct 2005 17:00:31 -0400
Message-ID: <1130533231.4363.139.camel@mindpipe>
References: <8a0c36780510281158v20818ba6h4424772005f63d07@mail.gmail.com>
	 <1130529260.16535.34.camel@localhost.localdomain>
	 <8a0c36780510281309m2ce6a258mff18c52a78c06a1@mail.gmail.com>
	 <1130531053.16535.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130531053.16535.36.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com, The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-10-28 at 16:24 -0400, Paul Davis wrote:
> On Fri, 2005-10-28 at 15:09 -0500, Richard Smith wrote:
> > >
> > > i believe that the patch already exists.
> > 
> > Sweet.  Where?  I googled for jack & S24_3BE but nothing showed up.
> > 
> 
> http://sourceforge.net/tracker/?group_id=39687&atid=425939
> 
> 
> 

"hw:1,0 is iec958 for capture and analogue/headphone for
playback
hw:1,1 is analogue for capture and iec958 for playback"

Now this is just silly.  We should probably seize the opportunity to fix
this in the ALSA driver (or alsa-lib) now, as there seem to be very few
working setups to break.  I don't want to repeat the emu10k1
multichannel device numbering snafu.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
