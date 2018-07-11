From: Harald Schuster <schuster@technikum-wien.at>
Subject: Re: poll blocked after prepare state
Date: Wed, 11 Jul 2018 08:54:48 +0000
Message-ID: <20180711085448.Horde.i_RZ0FUK1Gk9efjLRzRhEgF@webmail.technikum-wien.at>
References: <20180621104224.Horde.WJU_RKtLDLoAGMPfW3FREnA@webmail.technikum-wien.at>
 <20180622132921.Horde.VdiLUhoIz-J3ymTOC0qkzL5@webmail.technikum-wien.at>
 <s5h7emq3oxb.wl-tiwai@suse.de>
 <20180622183612.Horde.zlSuz13lBOQlZHX62qPNxF5@webmail.technikum-wien.at>
 <s5hd0wgdvn0.wl-tiwai@suse.de>
 <20180625095902.Horde.IP1UVAcUOineuktGUtPeR52@webmail.technikum-wien.at>
 <s5hzhzjyriz.wl-tiwai@suse.de>
 <20180625134315.Horde.3aYK199Y2wKOF9JnRDEG3Qh@webmail.technikum-wien.at>
 <s5hlgb3yntu.wl-tiwai@suse.de>
 <20180630101020.Horde.AjJAhdX9TE7cFNB1y6xcE_L@webmail.technikum-wien.at>
 <20180703104138.Horde.j4jzVQNyS4AoF4yPJhMc3Vw@webmail.technikum-wien.at>
 <20180711072727.Horde.JcILA71f0WklgGMdKJP5EEi@webmail.technikum-wien.at>
 <s5hbmbep6sr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bifrost.technikum-wien.at (bifrost.technikum-wien.at
 [195.245.225.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CA5CF267712
 for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2018 10:54:48 +0200 (CEST)
In-Reply-To: <s5hbmbep6sr.wl-tiwai@suse.de>
Content-Disposition: inline
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


Zitat von Takashi Iwai <tiwai@suse.de>:

> On Wed, 11 Jul 2018 09:27:27 +0200,
> Harald Schuster wrote:
>>
>> Hi
>> So I found out that the problem only occours when the dshare Plugin is
>> used! When the normal hw is used the problem does not exist. Is there
>> any knwon problem with the dshare plugin that the playback stops or is
>> there a workaraund?
>
> Let me ask again like a broken record: did you check with the latest
> alsa-lib?
>
> And, please don't top-post unless you have to do so.
>

I tested it with alsa-lib 1.1.2 because i can not update to a newer  
version and the error still exists.


>
> thanks,
>
> Takashi
>
>
>> br Harald
>>
>> Zitat von Harald Schuster <schuster@technikum-wien.at>:
>>
>> > Hi
>> > I found out that the error occours when the snd_pcm_read_areas
>> > function is called in a special order. When the function
>> > snd_pcm_read_areas is not called or it is called between the
>> > snd_pcm_dshare_starts it works fine. The Codec is already running
>> > because the mic path is working fine.
>> >
>> > pb_thread_func (alsa_dev.c): Underrun
>> > snd_pcm_read_areas(pcm.c): Before snd_pcm_start()
>> > snd_pcm_generic_start(pcm_generic.c):
>> > snd_pcm_hw_start
>> > snd_pcm_hw_start
>> > pb_thread_func (alsa_dev.c): Underrun 0x74395c80
>> > snd_pcm_write_areas(pcm.c): Before snd_pcm_start()
>> > snd_pcm_dshare_start
>> > snd_pcm_write_areas(pcm.c): Before snd_pcm_start()
>> > snd_pcm_dshare_start
>> > snd_pcm_write_areas(pcm.c): Before snd_pcm_start()
>> > snd_pcm_dshare_start
>> > snd_pcm_write_areas(pcm.c): Before snd_pcm_start()
>> > snd_pcm_dshare_start
>> >
>> >
>> >
>> > Zitat von Harald Schuster <schuster@technikum-wien.at>:
>> >
>> >> We found out that in some cases after the underrun the
>> >> snd_pcm_dshare_start function is called and in some cases
>> >> snd_pcm_dshare_start and the snd_pcm_hw_start function is called.
>> >> When both functions are called the codec stops playback.
>> >>
>> >> Zitat von Takashi Iwai <tiwai@suse.de>:
>> >>
>> >>> On Mon, 25 Jun 2018 15:43:15 +0200,
>> >>> Harald Schuster wrote:
>> >>>>
>> >>>> Hi
>> >>>> The codec is the TI tlv320aic3x and the buffersize is set to 64 and
>> >>>> the periodsize is set to 32 in the asound.conf. We use the pjProject
>> >>>> for the audioprocessing and the internal period time is 4ms and the
>> >>>> sample rate is 8000 Hz. The second codec is a USB codec which has no
>> >>>> problems. Our scenario is that a incoming VOIP call is connected to
>> >>>> the both codec (I2s and USB) and the USB codec starts the playback
>> >>>> without any problems and the tlv320 sometimes works but when a
>> >>>> underrun accours it crash!
>> >>>
>> >>> Is it really so hardware-specific problem?
>> >>>
>> >>> And, did you follow the recent development / fixes if it's about
>> >>> dshare plugin?  There have been lots of changes.
>> >>>
>> >>> I'm not asking about updating the kernels.  The question is rather
>> >>> about alsa-lib.
>> >>>
>> >>>
>> >>> Takashi
>> >>>
>> >>>>
>> >>>> best regards Harald
>> >>>>
>> >>>>
>> >>>> Zitat von Takashi Iwai <tiwai@suse.de>:
>> >>>>
>> >>>>> On Mon, 25 Jun 2018 11:59:02 +0200,
>> >>>>> Harald Schuster wrote:
>> >>>>>>
>> >>>>>>
>> >>>>>> Hi
>> >>>>>> We are not able to update our system. We are using USB codecs which
>> >>>>>> are working fine but they are using the snd_pcm_hw_prepare function.
>> >>>>>> The Problem only exists for the I2S codec in our system. When i
>> >>>>>> changed the buffer size in the asound.conf for the codec the problem
>> >>>>>> allready exists but it arise not so often because there is not so
>> >>>>>> often a underrun. Is there any hint where i could lock for the
>> >>>>>> problem?!
>> >>>>>
>> >>>>> Well, with that little information, it's hard to advice anything...
>> >>>>>
>> >>>>>
>> >>>>> Takashi
>> >>>>>
>> >>>>>> br Harald
>> >>>>>>
>> >>>>>> Zitat von Takashi Iwai <tiwai@suse.de>:
>> >>>>>>
>> >>>>>>> On Fri, 22 Jun 2018 20:36:12 +0200,
>> >>>>>>> Harald Schuster wrote:
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>> Zitat von Takashi Iwai <tiwai@suse.de>:
>> >>>>>>>>
>> >>>>>>>> > On Fri, 22 Jun 2018 15:29:21 +0200,
>> >>>>>>>> > Harald Schuster wrote:
>> >>>>>>>> >>
>> >>>>>>>> >> I found out that an underrun occours and so the
>> >>>>>>>> pcm_prepare function
>> >>>>>>>> >> for pcm_direct is called and then pcm_start_dshare is  
>> called. Both
>> >>>>>>>> >> functions returns without any error but the playback path
>> >>>>>>>> is blocked
>> >>>>>>>> >> in the snd_pcm_wait_nocheck function. I read that there
>> >>>>>>>> was an similar
>> >>>>>>>> >> problem before in the group but i didn't found any
>> >>>>>>>> solution. Is this a
>> >>>>>>>> >> problem in the driver and how can i go forward to fix it.
>> >>>>>>>> The codec is
>> >>>>>>>> >> a tlv320aic3x-audio. Thanks for your help.
>> >>>>>>>> >
>> >>>>>>>> > Does this happen with the very latest alsa-lib git version?
>> >>>>>>>> > Just to be sure.
>> >>>>>>>> >
>> >>>>>>>> >
>> >>>>>>>> > Takashi
>> >>>>>>>> > _______________________________________________
>> >>>>>>>> > Alsa-devel mailing list
>> >>>>>>>> > Alsa-devel@alsa-project.org
>> >>>>>>>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>>>>>>
>> >>>>>>>> Hi
>> >>>>>>>> We are using k4.1.15-6QP+ga2066af.
>> >>>>>>>
>> >>>>>>> I'm asking the alsa-lib, not kernel.
>> >>>>>>>
>> >>>>>>> And 4.1.x is very old...  Please check either 4.17.x or latest Linus
>> >>>>>>> tree whether the problem persists, too.
>> >>>>>>>
>> >>>>>>>
>> >>>>>>> Takashi
>> >>>>>>> _______________________________________________
>> >>>>>>> Alsa-devel mailing list
>> >>>>>>> Alsa-devel@alsa-project.org
>> >>>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>>>>
>> >>>>>>
>> >>>>>>
>> >>>>>> _______________________________________________
>> >>>>>> Alsa-devel mailing list
>> >>>>>> Alsa-devel@alsa-project.org
>> >>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>>>>
>> >>>>> _______________________________________________
>> >>>>> Alsa-devel mailing list
>> >>>>> Alsa-devel@alsa-project.org
>> >>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>>
>> >>>>
>> >>>>
>> >>>> _______________________________________________
>> >>>> Alsa-devel mailing list
>> >>>> Alsa-devel@alsa-project.org
>> >>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>>
>> >>> _______________________________________________
>> >>> Alsa-devel mailing list
>> >>> Alsa-devel@alsa-project.org
>> >>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>
>> >>
>> >>
>> >> _______________________________________________
>> >> Alsa-devel mailing list
>> >> Alsa-devel@alsa-project.org
>> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
>> >
>> >
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
