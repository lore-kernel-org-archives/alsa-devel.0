From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 1/5]alsa:patch_realtek.c Add SSID table for
	MacBookAir2, 1
Date: Tue, 08 Jun 2010 10:50:29 -0700
Message-ID: <4C0E82E5.6010807@gmail.com>
References: <1275865793-7357-1-git-send-email-justinmattock@gmail.com>
	<s5h39wxk1p6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id EA63324495
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 19:50:29 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3176232fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 10:50:29 -0700 (PDT)
In-Reply-To: <s5h39wxk1p6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/08/2010 08:01 AM, Takashi Iwai wrote:
> At Sun,  6 Jun 2010 16:09:49 -0700,
> Justin P. Mattock wrote:
>>
>> This adds the SSID number to snd_pci_quirk for the
>> MacBookAir2,1 taken from codec#0 at:
>> http://launchpadlibrarian.net/49455483/Card0.Codecs.codec.0.txt
>> keep in mind I do not have one of these machines on hand
>> so please if you do have this machine please test for me..
>>
>>   Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>
> I applied this one (after rearranging the quirk list order).
>
> Also the patch 3 and 5, both one-liner additions of a quirk, are
> applied, too, since they got tested somehow in bug reports.
>
> Could you rebase your changes for the proper MBA 1,1 and imac 7,1
> against the latest sound tree so that anyone can test them?  If they
> work better, then we can apply later your changes in addition.
>
>
> Thanks!
>
> Takashi


o.k. rebased these two against
the latest sound tree..noticed
a couple of messups which are fixed now
(Note to myself: when tired don't code)..

hopefully people test these and see..

cheers,

Justin P. Mattock
