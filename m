From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Why does `aplay -L' not show PCM's defined in
 ~/.asoundrc ?
Date: Mon, 02 Dec 2013 07:26:23 -0800
Message-ID: <529CA69F.5050308@gmail.com>
References: <529B91C6.8070302@gmail.com> <s5hzjoj8ux6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id AAEAD261AA5
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 16:26:25 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id v10so18379273pde.0
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 07:26:24 -0800 (PST)
In-Reply-To: <s5hzjoj8ux6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12/02/2013 01:27 AM, Takashi Iwai wrote:
>> Why does `aplay -L' not list PCM's that are defined in ~/.asoundrc (i.e.
>> PCM's implemented by plugins)?
[snip]
>
> You need to define the description for your own PCM definition.
> Or set defaults.namehint.showall on in ~/.asoundrc.

Thanks.

-gabriel
