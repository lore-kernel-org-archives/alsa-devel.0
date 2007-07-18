From: chris@idlelion.net
Subject: Re: cs46xx thinkpad resume fix - #bug1946
Date: Wed, 18 Jul 2007 08:51:45 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0707180848510.18643@tick.idlelion.net>
References: <20070714155552.GA2896@prog3> <s5h8x9gya3m.wl%tiwai@suse.de>
	<s5hps2rwbgy.wl%tiwai@suse.de> <20070717222642.GA28159@prog3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 413A81038F9
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jul 2007 15:51:53 +0200 (CEST)
In-Reply-To: <20070717222642.GA28159@prog3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Kysilka <pavelk@bsys.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Would this also apply to bug #305?

I'm happy to test this on CentOS 5 then Fedora 7 on a 600X, and write up 
the needed steps for ThinkWiki until the patch is included in the 
distributions.

Chris



On Wed, 18 Jul 2007, Pavel Kysilka wrote:

> On Tue Jul 17, 2007 at 12:50:21PM +0200, Takashi Iwai wrote:
>
>  Hi Takashi,
>
> good news below.
>
>> At Mon, 16 Jul 2007 11:24:45 +0200,
>> I wrote:
>>>
>>>
> <cut/>
>>> Oh, thanks for hunting this long-standing bug!
>>>
>>> I think, however, it cannot be applied as it is.
>>> First, snd_cs46xx_start_dsp() calls cs46xx_dsp_load_module(), and the
>>> latter function isn't designed for the PM resume.  We'd need a special
>>> resume function just for clearing area & reloading the dsp images
>>> according to the already loaded DSP modules.
>>>
>>> Second, __devinit prefix for snd_cs46xx_start_dsp() has to be removed
>>> if it's called from the PM handler.
>>
>> Looking at the code more deeply, I suspect whether it really works
>> when CONFIG_SND_CS46XX_NEW_DSP=y.  snd_cs46xx_start_dsp() involves
>> with many calls that add SCBs and co, which will eventually overflow.
>>
>> I made a patch blindly to do the resume work in a saner way, but of
>> course, it's totally untested.  Could you check whether it works?
>
> Patch works perfectly.
>
> Tested option:
> - kernel compiled with and without CONFIG_SND_CS46XX_NEW_DSP=y
> - play pcm stream, suspend, resume and pcm stream is playing
> - play pcm stream, stop playing pcm stream, suspend, resume and play pcm stream
>
> If you need log from resume from notebook, I'll send you this log.
>
>>
>>
>> thanks,
>>
>> Takashi
>>
>
> Many thanks
>    Pavel
>
>
> ________ Information from NOD32 ________
> This message was checked by NOD32 Antivirus System for Linux Mail Servers.
> http://www.eset.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
