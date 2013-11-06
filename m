From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/2] ALSA: hda - Force buffer alignment for
 Haswell HDMI controllers
Date: Wed, 06 Nov 2013 10:42:02 +0100
Message-ID: <527A0EEA.5000601@canonical.com>
References: <1383670831-12067-1-git-send-email-tiwai@suse.de>	<5279FA77.3060102@canonical.com>
 <s5h38naeydh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B6B2608CA
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 10:42:03 +0100 (CET)
In-Reply-To: <s5h38naeydh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/06/2013 09:19 AM, Takashi Iwai wrote:
> At Wed, 06 Nov 2013 09:14:47 +0100,
> David Henningsson wrote:
>>
>> On 11/05/2013 06:00 PM, Takashi Iwai wrote:
>>> Haswell HDMI audio controllers seem to get stuck when unaligned buffer
>>> size is used.  Let's enable the buffer alignment for the corresponding
>>> entries.
>>>
>>> Since AZX_DCAPS_INTEL_PCH contains AZX_DCAPS_BUFSIZE that disables the
>>> buffer alignment forcibly, define AZX_DCAPS_INTEL_HASWELL and put the
>>> necessary AZX_DCAPS bits there.
>>
>> A name question - haswell for me is both the HDMI controller and the
>> controller for analog codecs.
> 
> The analog codecs are on LynxPoint or such, not directly connected to
> Haswell CPU.

Fair enough, I stand corrected. I guess I just usually bunk the entire
platform together and call it "Haswell".


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
