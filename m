From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - [hdspm] RayDAT/AIO 1/2] ALSA: Add support
 for RME RayDAT and AIO
Date: Thu, 27 Jan 2011 11:44:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101271143420.6272@eeebox2.perex-int.cz>
References: <1296066735-11280-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1296066735-11280-2-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5htygudb6e.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
	<20110127102757.GH15327@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E221103AAA
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 11:44:35 +0100 (CET)
In-Reply-To: <20110127102757.GH15327@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Jan 2011, Adrian Knoth wrote:

> On Thu, Jan 27, 2011 at 09:09:05AM +0100, Jaroslav Kysela wrote:
>
>>>> +char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
>>>
>>> Err, no, array definitions should be never in a header file.
>>> It doesn't matter whether it's static or not.  The definition should
>>> be in *.c file where it's used.
>
> We have more than one C file using this information...
>
>>> So, simply move these array definitions to hdspm.c.
>>
>> I think that the reason is to share these arrays with hdspmixer.
>
> Exactly. hdspmixer needs this information, too. If we move it to the C
> file, we would need to duplicate the information in hdspmixer. And then
> we forget about it next time hdspm.h needs to be updated.
>
>
>> But I agree, that it's better to move these static values to .c files.
>
> Ok, I've sent a follow-up patch to avoid to send the whole 180k patch
> for the 4th time.
>
> I'll now duplicate this information and send a patch against hdspmixer.
> I feel that there should be a better solution like getting the channel
> mapping from the driver (sysfs, proc, ioctl or whatever), but that's for
> some other time.

Thanks. I applied your patches to my git tree with some slight subject 
modifications. Please, Takashi, do a cherry-pick. Thanks.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
