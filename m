From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] virtual master control for HD-audio
Date: Fri, 21 Dec 2007 20:37:09 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712212030470.8567@tm8103.perex-int.cz>
References: <s5hprx12x6x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A330103892
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 20:37:10 +0100 (CET)
In-Reply-To: <s5hprx12x6x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Dec 2007, Takashi Iwai wrote:

> Hi,
> 
> another thing I'd like to push into the next kernel is the virtual
> master volume control.  As I posted in earlier posts, it adds virtual
> controls that have several slave controls with the same types,
> e.g. Front, Surround, Center, LFE, etc.  Then these are adjusted
> simultaneously via the master control.
> 
> It'd be appreciated if some one can test the patches with HD-audio h/w
> that has no master control yet (e.g. some STAC codecs).
> 
> Note that this won't add the master volumes if there are no real
> volume controls.  Some codecs have really no volume control, and this
> won't help for such devices.
> 
> Two (and one for driver) patches will follow after this.

NAK from my side. I am convinced that this code can be implemented in the 
user space even without any daemon just in the mixer abstract layer using 
standard control elements and using eventually new user controls to store 
data for virtual mixer controls.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
