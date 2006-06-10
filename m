From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Problem with ALSA on PPC
Date: Sat, 10 Jun 2006 11:00:04 +0100
Message-ID: <1149933605.5081.1.camel@localhost.localdomain>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1149902770.13569.10.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-06-09 at 21:26 -0400, Lee Revell wrote:
> On Fri, 2006-06-09 at 18:18 -0400, Lee Revell wrote:
> > I do not have strace on this platform.  How can I determine which file
> > or directory is missing?
> > 
> > /usr/share/alsa/alsa.conf is present as well as the correct device
> > node:
> > 
> > ~ # ls -al /dev/snd/pcmC0D0p 
> > crw-rw----    1 root     29       116,  16 Jun  9
> > 15:54 /dev/snd/pcmC0D0p
> > 
> > What am I doing wrong?
> > 
> 
> I found the problem by installing strace on the PPC board.  alsa-lib is
> looking for its config files using the original path from the build
> host.  Either my build environment is still incorrect or it's a bug -
> probably the former ;-)
> 
> Once I am done maybe I will write an embedded ALSA HOWTO.
> 
> Lee
> 

I had/have a very similar problem with the Dreamcast - I can only use
the oss emulation

Asking about here didn't get me an answer so I await any answers to your
problem with anticipation...

/ # aplay -l
**** List of PLAYBACK Hardware Devices ****
aplay: device_list:230: control open (0): Invalid argument
