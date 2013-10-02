From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Realtek ALC286 SONY Vaio Pro 13 Ubuntu 13.10
Date: Wed, 02 Oct 2013 08:17:44 +0200
Message-ID: <524BBA88.9040004@canonical.com>
References: <524652C0.5040207@uwo.ca> <52492D48.102@canonical.com>
 <524A67F1.5020300@uwo.ca> <524A6B88.2080802@canonical.com>
 <524B8139.2040309@uwo.ca> <524BA634.1010108@canonical.com>
 <CAN8cciZJeEg9dYai5kHFFgKgOeVTBTKAXdPzNUkuYN_V0v067g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C5061264FEE
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 08:17:45 +0200 (CEST)
In-Reply-To: <CAN8cciZJeEg9dYai5kHFFgKgOeVTBTKAXdPzNUkuYN_V0v067g@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>, Yuval Levy <ylevy@uwo.ca>, Takashi Iwai <tiwai@suse.de>, 1228689@bugs.launchpad.net, David Chen <david.chen@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 10/02/2013 07:09 AM, Raymond Yau wrote:
>>>
>>> I have added this information to the bug report
>>> <https://bugs.launchpad.net/bugs/1228689>
>>> where I also post my comments so that they are more persistent and
>>> available to other users with similar issues.
>>>
> 
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=abdd8f510686da0a58e475bc0143d1069e5f53da
> 
> ALSA: hda - Apply ALC269 VAIO fix-up to all Sony laptops with ALC269
> We've applied a fix-up for ALC269 VAIO only for two models.  But all Sony
> VAIO models with ALC269 codec seem to require the similar fix.
> Let's apply it with vendor-id mask.
> 
> Does it mean that the Fixup need to check whether node 0x19 must be valid
> Mic pin if Sony Vaio pro 13 alc286 does not use node  0x19?

Yeah, that's a valid point - we should try different vref values for pin
0x18 to see if any of them works to enable headset mic (and possibly
also get rid of the noise in headphones).


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
