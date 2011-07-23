From: Juan Pablo Bouza <jpbouza@hotmail.com>
Subject: Re: M-Audio FTU issues
Date: Sat, 23 Jul 2011 01:25:39 -0300
Message-ID: <BAY155-w3656D5BC71E045132965FBB6310@phx.gbl>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>,
	<4E045058.6000405@showlabor.de>,
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>,
	<4E04B42E.2080906@ladisch.de>,
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>,
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>,
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>,
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>,
	<BAY155-w40601505DEAEF2C675FB21B64F0@phx.gbl>,
	<CACTFLAPTo2jGftr2G25yyw5Dn6rBv=ayk+y1Ny6JhnYDwF9BPQ@mail.gmail.com>,
	<BAY155-w44BFA897C126A8D60923D6B64F0@phx.gbl>,
	<CACTFLAPqLjFeDykeysvG=LhQaYQKBeM352EkcZ9jDDEVjWg7Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s8.bay0.hotmail.com (bay0-omc3-s8.bay0.hotmail.com
	[65.54.190.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 77990103809
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jul 2011 06:25:46 +0200 (CEST)
In-Reply-To: <CACTFLAPqLjFeDykeysvG=LhQaYQKBeM352EkcZ9jDDEVjWg7Rg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zonque@gmail.com
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, alsa-devel@alsa-project.org, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org


Thanks for the reply Daniel!

Well, I've patched and compiled Takashi's kernel... still no luck, no playback.
The good thing is that I also compiled this same kernel without patching and playback did work, so I assume there's something wrong with the patch I'm applying??

What I do is simply opening Audacity and trying to play a sound file. With the patched kernel Audacity says that it can't open the device for playback. I also tried jack and it won't start in playback or duplex mode.
As I said, recording does work ok.... And also, the kernel without patching works in all modes.

So... can you give me a link to the patch, just in case the patch I'm using has something wrong (although no errors are displayed when patching)

Secondly, is there a way I can debug the playback error? Some command line that could tell me why it can't open the device?

By the way, I'm in Kubuntu 10.04 and I'm compiling the kernel with kernel-package 12.036.

Sorry for being such a pain!! Thanks!!



PS: here's the output of the patching process:

root@ARTURITO:/usr/src/sound-2.6# patch -p1 <86547-001.bin 
patching file include/linux/usb/ch9.h
patching file sound/usb/card.h
patching file sound/usb/pcm.c
patching file sound/usb/pcm.h
patching file sound/usb/quirks.c
Hunk #1 succeeded at 753 (offset 109 lines).
patching file sound/usb/urb.c
patching file sound/usb/urb.h
root@ARTURITO:/usr/src/sound-2.6# 




> Date: Fri, 22 Jul 2011 10:42:26 +0200
> From: zonque@gmail.com
> To: jpbouza@hotmail.com
> CC: gdiffey@gmail.com; tiwai@suse.de; clemens@ladisch.de; alsa-devel@alsa-project.org; linuxaudio@showlabor.de; blablack@gmail.com
> Subject: Re: [alsa-devel] M-Audio FTU issues
> 
> On Thu, Jul 21, 2011 at 10:31 PM, Juan Pablo Bouza <jpbouza@hotmail.com> wrote:
> >
> > Yes, I know about the duplex mode kernel crash... But anyway, playback is just broken with the patch and my compilation...
> 
> All others reported success on this. Are you really playing a plain .wav file?
> 
> > Against what version of kernel 3 is the patch supposed to work?
> 
> On top of Takashi's master branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> > Is there any additional kernel configuration option I should or should not use in order to make the patch work??
> 
> You should have of course have a kernel which does in general support
> the FTU, but nothing more.
> 
> 
> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
 		 	   		  
