From: Justin Cormack <justin@street-vision.com>
Subject: RE: Why does Alsa sometimes not find the HDSP 9652? -
	SOLVED
Date: 29 Dec 2003 18:50:08 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072723808.20678.3.camel@lotte.street-vision.com>
References: <NDBBLGIKBJENLAMOLFHGAELHEFAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGAELHEFAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Ah. that explains why I have never seen it - I always let my machines
boot up from grub on the full timeout and most of them have pretty slow
bootup processes. It is probably best to retry for 1 minute or so in
module init to allow for very fast boots (after all the pci id has
matched, so only broken hardware will never succeed).

Justin



On Mon, 2003-12-29 at 18:37, Mark Knecht wrote:
> Hi Justin,
>    It looks like I solved this problem in the last few days. The issue
> appears to driven by how Alsa, or possibly the snd-hdsp driver specifically,
> attempts to discover the HDSP 9652, and the fact that my machine is
> moderately fast. I think this is a bug, or at least an opportunity to allow
> for some boot time tuning in Alsa somewhere, and I've reported it to Thomas
> privately.
> 
>    On my machine, and Athlon XP 2600+, I use System Commander 7 to partition
> the drives and to boot to DOS or Linux, and then grub to boot the Linux
> kernel I'm interested in. Currently SC7 has a timeout value of 20 seconds
> and grub has a time out value of 8 seconds.
> 
>    What I've found is that if I boot the machine and do not speed up the
> boot by hitting enter in either of these programs, then Alsa finds the HDSP
> 9652 100% of the time. However, if I boot but hit enter as early as possible
> in both programs then Alsa misses the HDSP 9652 100% of the time.
> 
>    So, the answer is just giving the machine enough time before starting the
> Alsa discovery processes.
> 
>    Owing to my hardware background and use of FPGA's in other areas, the
> Xilinx FPGA on the HDSP 9652 uses an outboard Flash chip to hold it's
> configuration code. (Sometimes called firmware here, but not really
> firmware.) This data is read out of the Flash chip in a fairly slow serial
> bitstream and takes some time. My suspicion is that by hitting the enter key
> twice I get to the Alsa boot stage too early, the configuration code is not
> loaded, and the driver cannot find the card even after 100 tries. If I don't
> hit enter, the configuration operation gets the extra 28 seconds and that is
> more than enough time to load the config code before the Alsa driver looks
> for the card.
> 
>    I've never been comfortable with the message 'failed after 100
> iterations'. To me this is not a good way to look for hardware since as
> machines speed up the amount of time you are giving gets shorter, so
> possibly Thomas will address this sometime in the future. Until then I'll
> just look for the smallest value I can make the boot time and still get the
> card to be recognized.
> 
>    I hope this helps someone in the future not have this problem. Thanks for
> your help.
> 
> Cheers,
> Mark
> 
> > -----Original Message-----
> > From: alsa-devel-admin@lists.sourceforge.net
> > [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Mark Knecht
> > Sent: Sunday, December 21, 2003 9:14 AM
> > To: Justin Cormack
> > Cc: Alsa-Devel
> > Subject: Re: [Alsa-devel] Why does Alsa sometimes not find the HDSP
> > 9652?
> >
> >
> > Justin,
> >    I'm running Alsa-1.0.0rc2. How much more up to date could I be?
> >
> >    Also, this is an HDSP 9652 which has the firmware on the board. Why
> > is a firmware loader required at all?
> >
> >    Possibly you're on to something I don't see yet? Maybe something is
> > left over from an older version and causing problems?
> >
> > Let me know,
> > Mark
> >
> > On Sun, 2003-12-21 at 09:11, Justin Cormack wrote:
> > > On Sun, 2003-12-21 at 16:03, Mark Knecht wrote:
> > > > Justin,
> > > >    Hi. Thanks. syslog from that series of boots is attached.
> > > >
> > > > Note the first boot, line 304 looks like this:
> > > >
> > > > Dec 20 05:43:46 Wizard kernel: ALSA
> > > > ../../alsa-kernel/pci/rme9652/hdsp.c:807: wait for FIFO status <= 0
> > > > failed after 100 iterations
> > > > Dec 20 05:43:46 Wizard kernel: RME Hammerfall-DSP: no cards found
> > >
> > > ah. Update your alsa to the latest version. This is the old firmware
> > > loader bug. It is fixed now (but there is a seperate loader hdsploader
> > > that you have to run).
> > >
> > > Justin
> > >
> > >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: IBM Linux Tutorials.
> > Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> > Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> > Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> >
> >
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
