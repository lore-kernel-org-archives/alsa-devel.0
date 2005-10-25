From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: CMedia 8738 - problems running Jack
Date: Mon, 24 Oct 2005 21:51:58 -0400
Message-ID: <1130205118.28314.15.camel@mindpipe>
References: <5bdc1c8b0510240924w10e1a8d1o499e3739fd8e1923@mail.gmail.com>
	 <5bdc1c8b0510240932o6566fef2q96f1f2a5a970b771@mail.gmail.com>
	 <20051024202157.GA11137@meep>
	 <5bdc1c8b0510241455s1aaf8940gc408902fe06af8f@mail.gmail.com>
	 <20051024223838.GA25313@meep> <1130193988.23853.69.camel@mindpipe>
	 <20051025002420.GB11137@meep>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051025002420.GB11137@meep>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Cunningham <spark@xdev.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-10-25 at 01:24 +0100, Dave Cunningham wrote:
> On Mon, Oct 24, 2005 at 06:46:27PM -0400, Lee Revell wrote:
> >On Mon, 2005-10-24 at 23:38 +0100, Dave Cunningham wrote:
> >> It's also pretty confusing why sometimes there are several
> >> stereo pcm devices to access different channels, and sometimes a
> >> single pcm device with multiple alsa "channels".  Especially
> >> since this confusion is presented to the user.
> >> 
> >
> >It's not confusing at all, it makes perfect sense.  If you want to play
> >stereo out the front speakers use the "front" device.  If you want to
> >play stereo out the rear speakers use the "rear" device.  Etc.  If you
> >want to play 5.1 surround out of all 6 speakers use the "surround51"
> >device.
> >
> >What could be simpler?
> >
> >Lee
> 
> It would be great if it were like that, but this is how it
> appears to me:
> 
> name: C-Media PCI DAC/ADC
> 
> has 6 channels, only 2 of which seem to work, whereas
> 
> name: C-Media PCI 2nd DAC
> 
> seems to have 2 channels.

Tell us how you think the mixer should look then file a feature request.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
