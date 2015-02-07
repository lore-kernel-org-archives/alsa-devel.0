From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some questions about userspace control elements
Date: Sat, 07 Feb 2015 16:45:30 +0100
Message-ID: <54D6331A.5070200@ladisch.de>
References: <54CE10D2.7090903@sakamocchi.jp>
 <54CE675A.80004@ladisch.de>	<54D2B075.4050005@sakamocchi.jp>
 <54D2BD01.6020904@sakamocchi.jp> <54D48BA8.6060104@ladisch.de>
 <54D5713B.2000406@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D631F26050C
 for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2015 16:45:41 +0100 (CET)
In-Reply-To: <54D5713B.2000406@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Feb 6 2015 18:38, Clemens Ladisch wrote:
>> The owner field is used because there is no other field to set the
>> count.
>
> No. In SNDRV_CTL_IOCTL_ELEM_ADD ioctl, struct snd_ctl_elem_info.count
> has the number of elements in this control, there it's an abuse of
> member unrelated to the count.

That is a different count.

struct snd_ctl_elem_info.count allows a control to have multiple values.
For example, a stereo volume control has two values.

kctl.count creates multiple controls.


Regards,
Clemens
