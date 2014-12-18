From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Thu, 18 Dec 2014 10:10:01 +0000
Message-ID: <5492A7F9.8090602@eml.cc>
References: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
 <CAN8cciZE+rHGuCHWjXbFi43ofR2k5w=P-hBvy4P69+Xeo5PVxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 00107261685
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 11:10:05 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 79D2320ACF
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 05:10:05 -0500 (EST)
In-Reply-To: <CAN8cciZE+rHGuCHWjXbFi43ofR2k5w=P-hBvy4P69+Xeo5PVxA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: nstoughton@aether.com, tiwai@suse.de, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

Thanks for the feedback :)

On 18/12/14 01:05, Raymond Yau wrote:
>  >
>  > Add notion of TSTAMP_CLASS (SYSTEM/AUDIO) as per Pierre's suggestion.
>  > Add snd_pcm_start_at()
>  >
>
> Do your implementation need to set specific start threshold to prevent
> the driver automatically start when you fill the buffer ?


> Do the driver allow to start when there is no data ?
>

It's the responsibility of the client to set the start threshold to a 
safe and responsible value.

It might suit some applications to allow both threshold start _and_ 
start_at: My implementation doesn't preclude this.

Cheers,
Tim
