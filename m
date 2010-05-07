From: Daniel Mack <daniel@caiaq.de>
Subject: Re: usbaudio: Support for USB audio v2.0 devices
Date: Fri, 7 May 2010 15:22:01 +0200
Message-ID: <20100507132201.GU30801@buzzloop.caiaq.de>
References: <4BD6E564.5050100@freemail.gr> <4BD6E737.8030805@gmail.com>
	<20100427140735.GD30804@buzzloop.caiaq.de>
	<4BD702F0.6080108@gmail.com>
	<20100427154346.GH30801@buzzloop.caiaq.de>
	<4BD71E73.5020106@gmail.com>
	<20100427173329.GI30801@buzzloop.caiaq.de>
	<4BDDAEB2.2010303@gmail.com>
	<20100503205558.GM30801@buzzloop.caiaq.de>
	<4BE4135C.80009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EA8A10389E
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 15:22:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BE4135C.80009@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Source <thesourcehim@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 05:19:24PM +0400, The Source wrote:
> Bisect results:
> 
> 23caaf19b11eda7054348452e1618d4512a86907 is the first bad commit
> commit 23caaf19b11eda7054348452e1618d4512a86907
> Author: Daniel Mack <daniel@caiaq.de>
> Date:   Thu Mar 11 21:13:25 2010 +0100

Thanks a lot! I'll have a close look again where I might have broken
anything. I'll let you know.

Daniel


> 
>     ALSA: usb-mixer: Add support for Audio Class v2.0
> 
>     USB Audio Class v2.0 compliant devices have different descriptors and a
>     different way of setting/getting min/max/res/cur properties. This patch
>     adds support for them.
> 
>     Signed-off-by: Daniel Mack <daniel@caiaq.de>
>     Cc: Clemens Ladisch <clemens@ladisch.de>
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> :040000 040000 db0691095b20f0872c9042e6498ce40693d69241
> 7cd9e29352fd45e50968b4a17891d1c3225aaba9 M    include
> :040000 040000 981c7c69fc8695281929677ebccf3bdae5ef41de
> c5bec5c3954278601ec4b29226f4671333262f04 M    sound
> 
