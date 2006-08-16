From: Ben B <kernel@bb.cactii.net>
Subject: Re: hda-intel "nobody cared"
Date: Wed, 16 Aug 2006 23:08:21 +0200
Message-ID: <20060816210821.GA2143@cactii.net>
References: <20060816195750.GA32709@cactii.net>
	<1155759849.7338.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1155759849.7338.6.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell <rlrevell@joe-job.com> uttered the following thing:
> On Wed, 2006-08-16 at 21:57 +0200, Ben B wrote:
> > I've been trying to get pesky suspend/resume working on an HP NC6400
> > notebook, and have got almost everything worked out except for audio
> > resume, which is not quite right.
> > 
> By DSP do you literally mean /dev/dsp (aka ALSA's OSS emulation), or do
> you mean any process that uses an audio device?  ALSA does not
> use /dev/dsp.

By DSP I mean something that plays audio (eg as opposed to mixer or
midi devices) via ALSA.

> Is there any difference in behavior if you configure your apps to use
> OSS vs. ALSA?

I just had more of a poke around and it seems I'm only getting this
problem when artsd is running under KDE. Artsd is configured to use
ALSA, as so:

  artsd -F 10 -S 4096 -a alsa -d -s 30 -m artsmessage -c drkonqui -l -f

If I kill artsd and then suspend whilst audio is playing via another app,
in this case ogg123, both with OSS and ALSA output devices configured, 
I don't get the problem.

Perhaps this could go to the arts people, but I think if I'm seeing a
kernel problem, then this should be dealt with in the kernel drivers.

Ben


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
