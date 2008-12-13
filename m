From: "Paulo Cavalcanti" <promac@gmail.com>
Subject: Re: alsa 1.0.18 does not work for Intel onboard cards
Date: Sat, 13 Dec 2008 13:52:24 -0200
Message-ID: <68720af30812130752t6a396948jec7062a7a1aa9092@mail.gmail.com>
References: <68720af30812130723k785e5b4di12b4a3e72c633e2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A2DF24470
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 16:52:25 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so822073yxh.2
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 07:52:24 -0800 (PST)
In-Reply-To: <68720af30812130723k785e5b4di12b4a3e72c633e2b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 13, 2008 at 1:23 PM, Paulo Cavalcanti <promac@gmail.com> wrote:

> Hi,
>
> alsa driver 1.0.18 has been a nightmare for me.
>
> I had a perfectly working sound for my Intel D975XBX2 when using
> alsa driver 1.017. Going to 1.0.18 just muted my front sound.
> Well, maybe not everybody needs a front sound output, but I just
> stick with the 1.01.17 driver.
>
>
Then, I tried an Intel DG45ID mobo, which does not have
any sound at all, with the later alsa driver 1.0.18a (detected as a Generic
DG45).

Going back to alsa driver 1.0.17, from the stock Fedora 10 kernel
(my card is then detected as an IDT 92HD73E1X5),
I have an analogic sound working, but Master, Headphones, and PCM
channels have to be above 90%, for anyone being able to hear anything.
Therefore, the volume is compressed in the upper 10% of the scale.

Furthermore, I have no mic, and no input working (I would like to feed the
output
of my capture card to the input source of the sound card) .
It seems to me that the input (blue jack)  is configured as output,
in the 1.0.17 alsa driver.

I do not know what else I can try, maybe some alsa snapshot,
to fix some of these issues.

Thanks.

-- 
Paulo Roma Cavalcanti
LCG - UFRJ
