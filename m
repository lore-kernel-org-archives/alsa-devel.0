From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: multiple USB soundcards crashes, please help
Date: Fri, 13 Mar 2009 11:47:35 +0100
Message-ID: <7c5010d60903130347x14325642i4415925f7deb5cb3@mail.gmail.com>
References: <7c5010d60903111208k1e637a21xde4007e9c0ddbd4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f161.google.com (mail-fx0-f161.google.com
	[209.85.220.161])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FFD91037EC
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 11:47:36 +0100 (CET)
Received: by fxm5 with SMTP id 5so127323fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 03:47:35 -0700 (PDT)
In-Reply-To: <7c5010d60903111208k1e637a21xde4007e9c0ddbd4b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Dev <alsa-devel@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Takashi,

please can you help me getting this issue started? I would like to go
in deep and help solve this issue.

Would you please tell me how to be useful? (which kind of info to
gather, which people-mailing list to write to, etc.)

Thanks in advance,
Giovanni

On Wed, Mar 11, 2009 at 8:08 PM, Giovanni Maruzzelli
<gmaruzz.lists@gmail.com> wrote:
> Dear ALSA developers,
>
> my application needs to use multiple USB soundcards (based on standard
> cm-108 chipset) for I/O.
>
> Seems to me that with recent kernels (after 2.6.21) this is almost impossible:
>
> -if you use uhci_hcd it crashes with 4 running soundcards (cannot
> submit datapipe: not enough bandwidth)
> -if you use ehci_hcd it crashes way before (device resets)
>
> With older kernels, at least uhci_hcd seems to work. This maybe is
> related to the reworking of the bandwidth management into the uhci_hcd
> introduced in 2.6.21.
>
> I'm available to and I would be glad to help you ALSA developers with
> all the information possible: just tell me wich infos you need and
> I'll gather all the infos for you.
>
> You can test the problem with:
> arecord -Dplughw:0 | aplay plughw:0 &
> arecord -Dplughw:1 | aplay plughw:1 &
> arecord -Dplughw:2 | aplay plughw:2 &
> arecord -Dplughw:3 | aplay plughw:3 &
>
