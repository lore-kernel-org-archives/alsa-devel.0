From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Use LPIB position fix for Acer
	AO751h
Date: Thu, 28 Feb 2013 09:49:23 +0100
Message-ID: <512F1A13.8090507@canonical.com>
References: <1362035910-6594-1-git-send-email-david.henningsson@canonical.com>
 <s5hmwuonbs8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 28842264F23
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 09:49:26 +0100 (CET)
In-Reply-To: <s5hmwuonbs8.wl%tiwai@suse.de>
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
Cc: 1132562@bugs.launchpad.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/28/2013 08:21 AM, Takashi Iwai wrote:
> At Thu, 28 Feb 2013 08:18:30 +0100,
> David Henningsson wrote:
>>
>> The user reports a regression (choppy audio), and that
>> position_fix=1 (or position_fix=4) fixes the issue.
>>
>> This is a Poulsbo controller (8086:811b (rev 07)), so might be
>> worth checking if other Poulsbo machines suffer from the same bug.
>>
>> Cc: stable@vger.kernel.org [v3.7+]
>> BugLink: https://bugs.launchpad.net/bugs/1132562
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> Please check whether the latest sound git tree works as is.
> We enabled the LPIB delay counting for Poulsbo there, and it may fix
> most cases.

The test was done on a 3.8 based kernel. Isn't LPIB delay counting 
enabled there as well?

(Alsa-info is here: https://launchpadlibrarian.net/132247367/AlsaInfo.txt )

>
>
> Takashi
>
>
>> ---
>>   sound/pci/hda/hda_intel.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 4cea6bb6..3505f1e 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -3114,6 +3114,7 @@ static bool check_hdmi_disabled(struct pci_dev *pci)
>>    * white/black-listing for position_fix
>>    */
>>   static struct snd_pci_quirk position_fix_list[] = {
>> +	SND_PCI_QUIRK(0x1025, 0x0244, "Acer AO751h", POS_FIX_LPIB),
>>   	SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_LPIB),
>>   	SND_PCI_QUIRK(0x1028, 0x01de, "Dell Precision 390", POS_FIX_LPIB),
>>   	SND_PCI_QUIRK(0x103c, 0x306d, "HP dv3", POS_FIX_LPIB),
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
