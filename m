From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Problem with ALSA on PPC
Date: Mon, 12 Jun 2006 12:41:36 +0100
Message-ID: <1150112496.21190.38.camel@localhost.localdomain>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
	<1149933605.5081.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1149933605.5081.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-06-10 at 11:00 +0100, Adrian McMenamin wrote:
> On Fri, 2006-06-09 at 21:26 -0400, Lee Revell wrote:
> > On Fri, 2006-06-09 at 18:18 -0400, Lee Revell wrote:
> > > I do not have strace on this platform.  How can I determine which file
> > > or directory is missing?
> > > 
> > > /usr/share/alsa/alsa.conf is present as well as the correct device
> > > node:
> > > 
> > > ~ # ls -al /dev/snd/pcmC0D0p 
> > > crw-rw----    1 root     29       116,  16 Jun  9
> > > 15:54 /dev/snd/pcmC0D0p
> > > 
> > > What am I doing wrong?
> > > 
> > 
> > I found the problem by installing strace on the PPC board.  alsa-lib is
> > looking for its config files using the original path from the build
> > host.  Either my build environment is still incorrect or it's a bug -
> > probably the former ;-)

Fwiw, I've been using OE 

http://www.openembedded.org/

to do all my embedded (non x86) ALSA user space building. It's quite
simple and I've not had any issues wih building alsa-* yet. It even
creates the device nodes and puts all the config files in the correct
place in your target file system.


> 
> I had/have a very similar problem with the Dreamcast - I can only use
> the oss emulation
> 
> Asking about here didn't get me an answer so I await any answers to your
> problem with anticipation...
> 
> / # aplay -l
> **** List of PLAYBACK Hardware Devices ****
> aplay: device_list:230: control open (0): Invalid argument
> 
> 

I've had a similar issue in the past. I could see the alsa device nodes
under /dev/snd and could see the pcms in /proc/asound/pcm, although I
had error messages like this when opening the devices in alsa mode. OSS
mode worked fine.

It turned out that my alsa nodes were not in the target file
systems  /etc/device_table file. After adding them to this file and
rebooting, alsa worked fine.  

HTH

Liam 
