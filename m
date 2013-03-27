From: Daniel Mack <zonque@gmail.com>
Subject: Re: Support for DSD streams
Date: Wed, 27 Mar 2013 10:53:21 +0100
Message-ID: <5152C191.4040103@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
 <514D9716.4000801@gmail.com>
 <7.0.0.16.2.20130323101939.0605d748@akdesigninc.com>
 <514DF7BB.1030604@gmail.com>
 <7.0.0.16.2.20130323182911.0605db20@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B1C3626506D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 10:54:26 +0100 (CET)
Received: by mail-wi0-f173.google.com with SMTP id ez12so2076436wid.12
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 02:54:26 -0700 (PDT)
In-Reply-To: <7.0.0.16.2.20130323182911.0605db20@akdesigninc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Koch <andreas@akdesigninc.com>
Cc: Jussi Laako <jussi@sonarnerd.net>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, alsa-devel@alsa-project.org, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

On 24.03.2013 02:33, Andreas Koch wrote:
> Hi Daniel,
> 
> At 11:43 AM 3/23/2013, Daniel Mack wrote:
>> Hi Andreas,
>>
>> On 23.03.2013 18:35, Andreas Koch wrote:
>>>> Yes, understood. The thing is just that we shouldn't break exising
>>>> solutions that already rely on this "bandaid".
>>>
>>> You wouldn't break any existing solution based on DoP, because that
>>> solution is dealt with in the application on one side and the DAC on
>>> the other side. The driver and USB transfer both think it is PCM data
>>> that is being sent.
>>
>> Well, that was exactly the problem with your device. With the driver as
>> it was, it exposed a PCM interface which is 16-bit wide, and that was
>> picked by ALSA when playing 16-bit material (because ALSA takes whatever
>> is offered by the hardware natively).
> 
> Not quite - the 16-bit wide interface offered by my DAC is not PCM, 
> but raw data.

For the correct quirks handling, I'd need to know whether all products
with your vendor ID are DSD capable on alt interface settings > 1. Is
that assumption correct or should I narrow it down to the product ID of
the MPD-3?


Thanks,
Daniel
