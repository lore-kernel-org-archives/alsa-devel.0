From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Some questions about userspace control elements
Date: Sun, 08 Feb 2015 19:57:25 +0900
Message-ID: <54D74115.4070202@sakamocchi.jp>
References: <54CE10D2.7090903@sakamocchi.jp>	<54CE675A.80004@ladisch.de>	<54D2B075.4050005@sakamocchi.jp>	<54D2BD01.6020904@sakamocchi.jp>
 <54D48BA8.6060104@ladisch.de>	<54D5713B.2000406@sakamocchi.jp>
 <54D6331A.5070200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 82ED42605D1
 for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2015 11:57:30 +0100 (CET)
In-Reply-To: <54D6331A.5070200@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Feb 8 2014 00:45, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> On Feb 6 2015 18:38, Clemens Ladisch wrote:
>>> The owner field is used because there is no other field to set the
>>> count.
>>
>> No. In SNDRV_CTL_IOCTL_ELEM_ADD ioctl, struct snd_ctl_elem_info.count
>> has the number of elements in this control, there it's an abuse of
>> member unrelated to the count.
> 
> That is a different count.
> 
> struct snd_ctl_elem_info.count allows a control to have multiple values.
> For example, a stereo volume control has two values.
> 
> kctl.count creates multiple controls.

Oh, I confused these two 'count's... I'm OK that the count member in
struct snd_kcontrol means the number of controls (elements) with the
same type, and the count member in struct snd_ctl_elem_info means the
number of values in a controls, then the event occurs every controls,
not for values.


Thanks

Takashi Sakamoto
