From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: HIFACE family driver
Date: Tue, 04 Dec 2012 11:22:30 +0100
Message-ID: <50BDCEE6.1070208@amarulasolutions.com>
References: <50A3750A.70401@amarulasolutions.com> <50A3921A.4030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 575092625FF
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 11:22:33 +0100 (CET)
Received: by mail-ea0-f179.google.com with SMTP id i12so1475228eaa.38
 for <alsa-devel@alsa-project.org>; Tue, 04 Dec 2012 02:22:33 -0800 (PST)
In-Reply-To: <50A3921A.4030907@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel

On 11/14/2012 01:44 PM, Daniel Mack wrote:
> Hi Michael,
> 
> On 14.11.2012 18:40, Michael Trimarchi wrote:
>> I have written in my spare time an alsa driver for HIFACE devices
>> family. Now I'm not an alsa expert and I would like to know if you
>> think that it's useful to include it in mainline
>>
>> https://github.com/panicking/snd-usb-asyncaudio
>>
>> The list of usb devices supported
>>
>> https://github.com/panicking/snd-usb-asyncaudio/blob/master/chip.c
> 
> We've already seen this - very cool!
> 
>> The main difference is that I need to use bulk message to talk to the
>> usb dongle and ofcourse there are a lot of improvement that we can do
>> on it. I have already tested on several kernel version and it's
>> already included in some linux distribution. Wait for some feedback
>> ;)
> 
> More than welcome :) You should submit your current version of the code
> in digestable pieces. Maybe the basic driver structure first, and then
> put individual features into additional patches if possible. That way,
> things can be reviewed in-line on the mailing list.
> 
> 

Sorry if I'm late, but I'm very busy. I will try to sort out by the end of the week.

Regards
Michael

> Thanks,
> Daniel
> 
