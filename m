From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [alsa-devel] Bug? Sound support for at91sam9x5-wm8731 based boards
Date: Wed, 20 Nov 2013 17:23:56 +0100
Message-ID: <CACQ1gAh7UAkT1s_=gOKpzEt5bm9FAGf0gL-yM6=r5ch7bMksBA@mail.gmail.com>
References: <1384878685-1515-1-git-send-email-tony@atomide.com>
 <1384878685-1515-3-git-send-email-tony@atomide.com>
 <031f01cee547$950b5670$bf220350$@com>
 <CACQ1gAgykmgPKY4SHujnNtm4Sr=wt5knLkQL-MRS_pC73bOi4Q@mail.gmail.com>
 <033601cee552$7c2c2570$74847050$@com>
 <CACQ1gAhvS7PSbK0SuhrB8TPS8Rkd-AdqZ-=T+Ntjyx7PsR7XaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACQ1gAhvS7PSbK0SuhrB8TPS8Rkd-AdqZ-=T+Ntjyx7PsR7XaQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhong Li <zql@glomationinc.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2013/11/20 Richard Genoud <richard.genoud@gmail.com>:
> [added Nicolas Ferre and Bo Shen ]
>
> 2013/11/19 Zhong Li <zql@glomationinc.com>:
>>
>> One of the testing hardware is the Atmel at91sam9g25-ek (the CPU module and the carrier board).  We tried both the 2.6.39 patched with the Atmel patches and the mainline 3.12-rc.  The command to test the sound is just the simple aplay <sound-test-file>.  The wav file is available here, https://drive.google.com/file/d/0B3TSFX4Mq9PoeTdJOGVaZk5rTWM/edit?usp=sharing.
>>
>> Thanks
>
> Ok, I reproduce the bug on g35-ek with a v3.11.7+(sam9x5 sound patches) kernel
>
> So, *sometimes*,  the left and right channel are swapped. ( I found
> also the ratio 1 out of 6 (but once it has happened, it seems to be
> more often))
> I tested that with the file given by Zhong Li, and with a file I
> created with audacity (440Hz only on right channel).
> I could see at the scope that the channels are swapped before the
> w8731 codec (the data on the TD line are sometime on the low edge of
> TF, instead of always being on the high edge (I2S mode)).
> There's, in both cases, a clock period (TK) between the rising/falling
> edge of TF and the 1st data bit on TD, so the mode is always I2S, and
> the channel data are swapped.
>
> I'll try to have a look (but I don't have much time right now)
>
> If someone could test that on a sam9g20 or a WM8904 based board, since
> they share the same DAI format, they may have the same problem.

After reading the sources (mainly sound/soc/atmel/atmel_ssc_dai.c), I
don't understand how the right and left channel are synchronized.
(which one will be on TF rising edge, and which one on TF falling edge
?)
In the SSC_TCMR register, the start event is TF_FALLING when there
only one channel (i.e. mono source always on left channel)
With a stereo source, it's TF_EDGE (Detection of any edge on TF
signal) ; so the samples are transferred on rising and falling edge.
I didn't see anything in the SSC what could synchronize the first
sample with a TF falling edge.
Or I missed something ?

Nicolas, Bo, any idea ?

Richard.
