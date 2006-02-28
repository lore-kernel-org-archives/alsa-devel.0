From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [PATCH] Add support for Acer TravelMate and
Date: Tue, 28 Feb 2006 18:54:08 -0500
Message-ID: <1141170850.5860.69.camel@mindpipe>
References: <200602282345.k1SNjPfu020504@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602282345.k1SNjPfu020504@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Rimas Kudelis <rq@akl.lt>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-01 at 10:15 +1030, Jonathan Woithe wrote:
> > On Wed, 2006-03-01 at 09:52 +1030, Jonathan Woithe wrote:
> > > The "CD" input on the ALC260 is an analog input.  It expects the CD drive to
> > > do all the audio decoding and present an ordinary stereo signal to this pin. 
> > > If when playing a CD and enabling the "CD" control you get no audio that
> > > strongly suggests that there is no audio signal running to that pin.
> > > However, if there is no analog connection to the ALC260 one does wonder
> > > precisely how these systems are expected to play CDs.  The only option 
> > > left would be for software to read the raw CD bitstream (which isn't a straight
> > > audio bitstream), decode it and then send the resulting audio bitstream to
> > > the DAC.  Given that CD drives are more than capable of doing all this it would
> > > surprise me if this were the case.
> > > 
> > > One thing worth checking though - have you tested *all* ALC260 inputs with
> > > the CD playing?  Maybe Acer connect the CD audio to some other ALC260 pin. 
> > 
> > I would not be surprised if some vendors were leaving out the DAC from
> > their CD drives, and expect you to play audio CDs in digital mode.  I
> > believe this is how Windows Media Player works by default (it also
> > allows it to generate visual effects from the CD audio).
> 
> Ah, right.  I wasn't aware of that.  If that's its default behaviour then
> perhaps the Acers do expect the OS to use digital mode for playing CDs. If
> this proves to be the case then we'll revise the "acer" model to omit the CD
> controls.

Are #1843 and #1847 related to this problem?  Those both involve Acer
systems but with Sigmatel codecs rather than Realtek.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
