From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - get realtime ELD info when
 codec suspended
Date: Tue, 25 Jun 2013 11:02:27 +0200
Message-ID: <51C95CA3.7000001@canonical.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <1372074324-13563-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5hmwqfvizc.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833B68@SHSMSX104.ccr.corp.intel.com>
 <s5hk3ljvhu2.wl%tiwai@suse.de> <51C83FC5.3090005@canonical.com>
 <s5h38s7vf2v.wl%tiwai@suse.de> <51C94A80.70709@canonical.com>
 <s5hobauzkse.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id EF01226520A
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 11:02:29 +0200 (CEST)
In-Reply-To: <s5hobauzkse.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/25/2013 09:55 AM, Takashi Iwai wrote:
> At Tue, 25 Jun 2013 09:45:04 +0200,
> David Henningsson wrote:
>>> There is a low power mode that allows the jack detection, but this is
>>> different from the aggressive power-saving with runtime D3.
>>
>> If "aggressive power-saving with runtime D3" is the same as
>> AZX_DCAPS_PM_RUNTIME, this is also enabled for analog codecs connected
>> to a Lynx point controller.
>>
>> It looks like userspace have problems getting notifications for e g
>> headphone insertion on Lynx point controllers, so this is not only an
>> HDMI/DP problem?
>
> Yes.
>
>> Trying to read up a little on this, there seem to be an option to set
>> the WAKEEN register to have jack detection working even when the
>> controller is in D3. (refer HDA specification 4.5.9.2:
>> Codec Wake From System S0, Controller D3.)
>> But it seems we do not (yet) use this feature. Is this something that
>> could/should be implemented to fix the jack detection problems that
>> seems to be happening otherwise?
>
> It sounds feasible, at least for traditional jack detection of analog
> pins.  But I'm not sure whether this would help for the Intel graphics
> case.  Just need testing.

Xingchao, what are your thoughts about using WAKEEN to wakeup both Lynx 
point and Haswell HDMI?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
