From: =?iso-8859-1?Q?Ren=E9_Kermis?= <kermis@gmx.de>
Subject: Re: Updated: via8233 driver -- testers wanted
Date: Fri, 31 May 2002 10:51:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <004401c20880$5f095b40$6abc5f86@kermit>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I can't get the driver (cvs-version 1.18) running on a VT8233A (EPoX 8K3A+).
I get the following error when trying to play a sound file with aplay:

ALSA lib pcm_hw.c:413:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:
Input/Output error

dmesg-output:

ALSA ../alsa-kernel/core/pcm_lib.c:1871: playback write error (DMA or IRQ
trouble?)
...
ALSA ../alsa-kernel/core/pcm_native.c:1093: playback drain error (DMA or IRQ
trouble?)


Any suggestions?
René


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
