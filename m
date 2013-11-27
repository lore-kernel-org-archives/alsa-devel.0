From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Enable mute/mic-mute LEDs for
 more Thinkpads with Conexant codec
Date: Wed, 27 Nov 2013 14:21:51 +0800
Message-ID: <52958F7F.5010504@canonical.com>
References: <1385522812-29678-1-git-send-email-hui.wang@canonical.com>
 <5295805C.8060104@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DA4B5261AED
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 07:21:57 +0100 (CET)
In-Reply-To: <5295805C.8060104@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, hui.wang@canonical.com, alsa-devel@alsa-project.org, yk@canonical.com, alex.hung@canonical.com
List-Id: alsa-devel@alsa-project.org

On 11/27/2013 01:17 PM, David Henningsson wrote:
> On 11/27/2013 04:26 AM, Hui Wang wrote:
>> Most Thinkpad Edge series laptops use conexant codec, so far although
>> the codecs have different minor Vendor Id and minor Subsystem Id, but
>> they all belong to the cxt_5066 family, this change can make the
>> mute/mic-mute LEDs support more generic among cxt_5066 family.
> Hi Hui and thanks for your patch!
>
> It's also nice that you have tested the patch on several machines and
> found it to be working.
>
> As for the actual implementation - as the rest of the thinkpad-acpi code
> is copy-pasted between patch_realtek and patch_conexant, I think this
> would also apply here, i e, no code in hda_local.h, instead copy from
> patch_realtek to patch_conexant as necessary.
>
> While copy-pasting code is not the most elegant of solutions, I got the
> impression from Takashi that he preferred that for now.
OK, got it, I will send a V2 patch according to your suggestion.

Regards,
Hui.
>> Cc: Alex Hung <alex.hung@canonical.com>
>> Cc: David Henningsson <david.henningsson@canonical.com>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   sound/pci/hda/hda_local.h      | 22 ++++++++++++++++++++++
>>   sound/pci/hda/patch_conexant.c |  3 +++
>>   sound/pci/hda/patch_realtek.c  | 20 --------------------
>>   3 files changed, 25 insertions(+), 20 deletions(-)
>>
