From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 3 Feb 2010 20:03:26 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1002031911310.3125@ecabase.localdomain>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
	<6160a5131002011440p52fb1b2dv9d077681544adb8c@mail.gmail.com>
	<4f3252891002021820s677de613m60395a2153c7ec55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EA47103827
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 19:07:03 +0100 (CET)
In-Reply-To: <4f3252891002021820s677de613m60395a2153c7ec55@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 3 Feb 2010, Raymond Yau wrote:

>> - the 'only' change is to make sure the hw_ptr reported in .pointer is
>> NOT the number of samples pushed out to the interface. hw_ptr should
[...]
> if snd_xxx_pointer call back return the next read position , the hw_ptr will
> always be multiple of PCI/PCIe brust size

yep, that's the point I was trying to make in my longish earlier
mail yesterday:
http://article.gmane.org/gmane.linux.alsa.devel/70306

I also presented two solutions for this. So let hw_ptr be a multiple of 
burst/batch size, but compensate by:

1) driver updates runtime->delay in its pointer() callback, or
 	-> finegrained playout delay can be reported even if
 	   hw_ptr is a multiple of burst/batch size
2) use of snd_pcm_status_get_tstamp() (original idea from Eero)
         -> assumes runtime->delay is updated in sync with hw_ptr

Both are possible with existing ALSA infra, and driver and app developers
could just use these, but what is missing is the consensus whether this is 
a valid/allowed thing to do and rely on.
