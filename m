From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: CMedia 8738 - problems running Jack
Date: Mon, 24 Oct 2005 18:46:27 -0400
Message-ID: <1130193988.23853.69.camel@mindpipe>
References: <5bdc1c8b0510240924w10e1a8d1o499e3739fd8e1923@mail.gmail.com>
	 <5bdc1c8b0510240932o6566fef2q96f1f2a5a970b771@mail.gmail.com>
	 <20051024202157.GA11137@meep>
	 <5bdc1c8b0510241455s1aaf8940gc408902fe06af8f@mail.gmail.com>
	 <20051024223838.GA25313@meep>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051024223838.GA25313@meep>
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
Cc: Mark Knecht <markknecht@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-10-24 at 23:38 +0100, Dave Cunningham wrote:
> It's also pretty confusing why sometimes there are several
> stereo pcm devices to access different channels, and sometimes a
> single pcm device with multiple alsa "channels".  Especially
> since this confusion is presented to the user.
> 

It's not confusing at all, it makes perfect sense.  If you want to play
stereo out the front speakers use the "front" device.  If you want to
play stereo out the rear speakers use the "rear" device.  Etc.  If you
want to play 5.1 surround out of all 6 speakers use the "surround51"
device.

What could be simpler?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
