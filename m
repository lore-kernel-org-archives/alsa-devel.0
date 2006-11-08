From: witzel.thomas@comcast.net
Subject: Re: Intel ICH programming & ALSA driver
Date: Wed, 08 Nov 2006 14:52:07 +0000
Message-ID: <110820061452.20785.4551EF17000BBCE90000513122070210539C0E0301089BD2040A969B0799@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 -------------- Original message ----------------------
From: "Clemens Ladisch" <cladisch@fastmail.net>
> Thomas Witzel wrote:
> > I'm not sure this really belongs here, but I have nowhere else to ask. I'm 
> > writing an Intel ICH sound driver for Xenomai (real time Linux) and got stuck 
> > with no sound. I'm not doing this for a common audio application but rather 
> > in an attempt to generate an experimental setup with low-cost arbitrary 
> > waveform function generators (which are the sound chips).
> > Long story short, I learned as much as I could from looking at the ALSA driver 
> > and the datasheet.
> 
> Did you read the PRM, too?
Yes, that gave me the instructions on how to do the DMA.
 
> > I'm running the DMA on the PCM OUT I believe, but I get no sound. I
> > set all mixer volume controls to max (and read them back to confirm)
> > and make sure they are unmuted. Codec one is ready, AC97 power is up.
> 
> What codec are you using?  Many codecs must be configured to route the
> sound to the correct output.
On my development machine its a ALC650 (RealTek) in the oldest incarnation (0x414c,0x4720).
If it helps I can post an archive of my code somewhere.

Thanks for your help so far

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
