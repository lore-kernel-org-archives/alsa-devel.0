From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Gitcompile for Kernel 3.2?
Date: Mon, 13 Aug 2012 06:48:22 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F345181D3603@CRETE.nmmu.ac.za>
References: <35FE09CFAB387A4BA7ACDDED49F345181D00D8@CRETE.nmmu.ac.za>
 <s5h3940mpcd.wl%tiwai@suse.de>
 <35FE09CFAB387A4BA7ACDDED49F345181D0496@CRETE.nmmu.ac.za>
 <s5hlihrhu3k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 935D5265276
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 08:18:58 +0200 (CEST)
In-Reply-To: <s5hlihrhu3k.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Just to close out this thread: all of my problems seem to have stemmed from overzealous use of the --with-cards option <sheepish grin>.  Both the alsa-driver-build.git/sound.git and alsa-driver.git/kmirror.git approaches gitcompile just fine on Ubuntu 12.04 and Ubuntu-Studio 12.04 (with 3.2 vanilla and lowlatency kernels, respectively) when compiled as suggested below.  I think I've lost pulseaudio somewhere in the process, but I'll hunt that down some other day.  Thank-you again, Takashi.

Mark Brand.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: 07 August 2012 12:31 PM
To: Brand, Mark (Mr) (Summerstrand Campus South)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Gitcompile for Kernel 3.2?

% mkdir $HOME/build
% cd $HOME/build
% git clone git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
% git clone git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
% cd alsa-driver-build
% ./gitcompile --with-debug=full --enable-dynamic-minors --with-moddir=updates
% sudo make install-modules


Takashi

________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
