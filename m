From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: AC97 related build problem with CVS
Date: Sun, 28 Nov 2004 23:14:26 -0800
Message-ID: <87is7pcejx.fsf@sycorax.lbl.gov>
References: <1100933119.6879.9.camel@krustophenia.net>
	<s5hfz32do0r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfz32do0r.wl@alsa2.suse.de> (message from Takashi Iwai on
 Mon, 22 Nov 2004 14:14:12 +0100)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Sat, 20 Nov 2004 01:45:19 -0500,
> Lee Revell wrote:
>> 
>> This must be related to the AC97 changes committed recently.  CVS from
>> yesterday works, but today I get:
>> 
>> make[1]: Entering directory
>> `/home/rlrevell/kernel-source/linux-2.6.9-rc3-mm3-T3'
>>   Building modules, stage 2.
>>   MODPOST
>> *** Warning:
>> "snd_ac97_restore_iec958" [/home/rlrevell/cvs/alsa/alsa-driver/pci/ac97/snd-ac97-codec.ko] undefined!
>> *** Warning:
>> "snd_ac97_restore_status" [/home/rlrevell/cvs/alsa/alsa-driver/pci/ac97/snd-ac97-codec.ko] undefined!
>
> Fine on my system.  I don't think I missed the cvs commit....
> Could you verify again?  Did you get the compile warning during
> compilation of ac97_codec.c and ac97_patch.c?

snd_ac97_restore_iec958 and snd_ac97_restore_status are defined only
if the kernel is configured with CONFIG_PM defined. there are some
missing #ifdef CONFIG_PM in ac97_patch.c.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
