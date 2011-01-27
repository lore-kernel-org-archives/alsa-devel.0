From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH - [hdspm] RayDAT/AIO 1/2] ALSA: Add	support
	for RME RayDAT and AIO
Date: Thu, 27 Jan 2011 11:27:57 +0100
Message-ID: <20110127102757.GH15327@ltw.loris.tv>
References: <1296066735-11280-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1296066735-11280-2-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5htygudb6e.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 229DE103AAA
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 11:28:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 09:09:05AM +0100, Jaroslav Kysela wrote:

>>> +char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
>>
>> Err, no, array definitions should be never in a header file.
>> It doesn't matter whether it's static or not.  The definition should
>> be in *.c file where it's used.

We have more than one C file using this information...

>> So, simply move these array definitions to hdspm.c.
>
> I think that the reason is to share these arrays with hdspmixer.

Exactly. hdspmixer needs this information, too. If we move it to the C
file, we would need to duplicate the information in hdspmixer. And then
we forget about it next time hdspm.h needs to be updated.


> But I agree, that it's better to move these static values to .c files.

Ok, I've sent a follow-up patch to avoid to send the whole 180k patch
for the 4th time.

I'll now duplicate this information and send a patch against hdspmixer.
I feel that there should be a better solution like getting the channel
mapping from the driver (sysfs, proc, ioctl or whatever), but that's for
some other time.


HTH

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
