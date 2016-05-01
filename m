From: Petr Kulhavy <brain@jikos.cz>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Sun, 1 May 2016 20:59:35 +0200
Message-ID: <e163b954-0c4b-b859-0e15-ea113d2f5ddd@jikos.cz>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
 <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
 <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
 <CAOMZO5BM-EM0s5zWUmbRMkzV11Az9D+KLmQJ7dgv_RvKX9mihg@mail.gmail.com>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep19.mx.upcmail.net (fep19.mx.upcmail.net [62.179.121.39])
 by alsa0.perex.cz (Postfix) with ESMTP id B922C2604DF
 for <alsa-devel@alsa-project.org>; Sun,  1 May 2016 21:00:06 +0200 (CEST)
Received: from edge02.upcmail.net ([192.168.13.237]) by viefep17-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20160501185936.KIDO28889.viefep17-int.chello.at@edge02.upcmail.net>
 for <alsa-devel@alsa-project.org>; Sun, 1 May 2016 20:59:36 +0200
In-Reply-To: <CAOMZO5BM-EM0s5zWUmbRMkzV11Az9D+KLmQJ7dgv_RvKX9mihg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

On 01/05/16 20:47, Fabio Estevam wrote:
> On Sun, May 1, 2016 at 3:43 PM, Petr Kulhavy <brain@jikos.cz> wrote:
>
>> Hi Fabio,
>>
>> and did that work for you?
>> In my DTS file I made a few more changes, see below.
> No, as explained in my earlier e-mail the system hangs after running aplay.
>
> However, the same hang happens with NXP kernel.
>
> Have you tried setting bit20 of GPR1 register?
>
> Which NXP kernel did you use that provides audio functionality on mx6ul-evk?
I have not tried setting the bit 20 of the GPR1 register. How would that 
be set?

Both the 3.x and 4.1 work for me. However you need to set the headphone 
volume to non-zero and especially the pcm output mixer (unmute),
otherwise the audio path is not routed through and the codec is switched 
off due to power saving (and generates no bclk and lrclk).
This confused me as well, but after setting the mixer playback stasrts 
working with the Freescale kernel.

Petr
