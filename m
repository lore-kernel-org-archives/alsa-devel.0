From: "shane michael matthews" <shane.michael.matthews@gmail.com>
Subject: Re: Wall Clock Counter
Date: Fri, 15 Sep 2006 10:38:50 -0700
Message-ID: <705aa3f00609151038r7b800cfet7135c09a3c236c1c@mail.gmail.com>
References: <705aa3f00609150906r56f1bda5nefea0fbe3251dee7@mail.gmail.com>
	<1158337693.18762.16.camel@mindpipe>
	<705aa3f00609151034j5a408668lf34cb095dbae582d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <705aa3f00609151034j5a408668lf34cb095dbae582d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 9/15/06, shane michael matthews <shane.michael.matthews@gmail.com> wrote:
> On 9/15/06, Lee Revell <rlrevell@joe-job.com> wrote:
> >  On Fri, 2006-09-15 at 09:06 -0700, shane michael matthews wrote:
> > > Hello group,
> > >
> > > What I want to do is read the value stored in the wall clock counter
> > > on my sound card.  Searching through the alsa documentation and source
> > > it appears that snd_timer_read is the function I want to use.  From
> > > timer.c:
> > >
> > > "The timer implementation uses ring buffer to store information about
> > > timing events. In this buffer is recorded count of ticks and current
> > > tick resolution in nanoseconds."  Is the 'ticks' referred to here the
> > > value in the wall clock counter (It seems to always be set to 5 on my
> > > system)?  If anyone could point me to more documentation I would
> > > greatly appreciate it.
> >
> > The answer to this will be hardware-specific.  In order for
> > snd_timer_read() to work there must be a low level ALSA timer
> > implementation for your sound device.  What soundcard do you use?
> >
> > Lee

The device is:
# lspci
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 01)

I found a manual at:   http://www.intel.com/design/chipsets/manuals/307017.htm
On page 47 it discusses the wall clock.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
