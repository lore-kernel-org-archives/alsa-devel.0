From: Shane Walton <dsrelist@yahoo.com>
Subject: Re: ALSA-0.9.0rc2 and RME HammerFall
Date: Wed, 4 Sep 2002 11:04:58 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020904180458.8061.qmail@web20810.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul,

Here is the details, the rest is what I could gather
from an execution in ddd:

         ALSA lib pcm_hw.c:579: (snd_pcm_hw_open)
SNDRV_PCM_IOCTL_PVERSION failed:  Inappropriate ioctl
for device
          failed to open audio device default
(Inappropriate ioctl for device)
 
snd_pcm_hw_open is looks like this:
     snd_pcm_hw_open(pcmp, name, card, device,
subdevice, stream, mode)
          pcmp = 0x4022465e
          name = 0x0
          card = 0 
          device = 0 
          subdevice = -1
          stream = SND_PCM_STREAM_CAPTURE
          mode = 0
 
the line inside snd_pcm_hw_open that is failing
contains this function call:
     ioctl(fd, SNDRV_PCM_IOCTL_PVERSION, &ver)
         fd = 7
         &ver = 6

--- Paul Davis <pbd@op.net> wrote:
> >Is there any know problems with 0.9.0rc2/Linux
> >2.4.19/RME HammerFall.  I had a working application
> >using 0.9.0beta6/Linux/2.2.19/RME HammerFall, since
> I
> >am changing to a Intel P4 arch, I can't get the
> beta6
> >to work.  It fails on an ioctl with something about
> a
> >PVERSION...  I would like to use a new version of
> ALSA
> 
> more information on the error is needed.
> 
> --p


=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
