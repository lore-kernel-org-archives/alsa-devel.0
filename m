From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: HDMI LPE audio on Intel Compute Stick 2nd Gen (CHT)
Date: Sun, 22 Oct 2017 18:55:34 +0530
Message-ID: <81ca62d9-f75c-a81e-8170-eb999cb448f6@linux.intel.com>
References: <CAFXWsS_V=nG8C+NM8qmtjdoZoWrsTnTFNR16kU05NNsx=c0-5Q@mail.gmail.com>
 <7827e954-d9d0-4737-5e47-13e0e69fd92d@linux.intel.com>
 <CAFXWsS8THagHnx9BPurw4+3a+xH6DP653MjwjTSkYhU3zLmZHQ@mail.gmail.com>
 <11e337a4-0656-50d3-3c16-56cc437a32c7@linux.intel.com>
 <s5hfuadvjz5.wl-tiwai@suse.de>
 <CAFXWsS9i0f7vpdiCBtxkzOpQ_aC9C2w0vJ6qoTr__1UzDugzGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 82601267024
 for <alsa-devel@alsa-project.org>; Sun, 22 Oct 2017 15:25:11 +0200 (CEST)
In-Reply-To: <CAFXWsS9i0f7vpdiCBtxkzOpQ_aC9C2w0vJ6qoTr__1UzDugzGw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian W MORRISON <ianwmorrison@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/22/17 6:30 PM, Ian W MORRISON wrote:
> On 21 October 2017 at 03:53, Takashi Iwai <tiwai@suse.de> wrote:
> 
>> On Fri, 20 Oct 2017 17:54:45 +0200,
>> Pierre-Louis Bossart wrote:
>>>
>>> On 10/20/17 8:45 AM, Ian W MORRISON wrote:
>>>>> I've just noticed that non of the kernels from v4.13 and up run on my
>>>>>> Intel Compute Stick (2nd gen Cherry Trail STK1AW32SC) unit and have
>>>>>> HDMI LPE audio working.
>>>>>>
>>>>>
>>>>> I have not tested HDMI in a while but I am not aware of any issues
>> either.
>>>>> There were some patches recently to fix PulseAudio problems and I
>> suppose
>>>>> some folks used a recent kernel?
>>>>>
>>>>>
>>>> It actually happened since v4.12 as now I get three HDMI LPE Audio
>> devices
>>>> show up with 'aplay -l' rather than just one. Only 'device 2' works so
>> if I
>>>> change the sink to use that device I get sound. So basically it can be
>>>> fixed in userland however I'm seeing others with different devices also
>>>> complaining how audio is broken and I think it is something that many
>> users
>>>> don't know to fix. Is it worth looking into further or just leaving it
>> as a
>>>> known issue?
>>>
>>> I don't think it's a bug, it's a feature...
>>> The jack information tells you which device is connected/active, so
>>> userspace has all the data needed to select the right routing.
>>
>> Right, it's a new feature that was recently added, for supporting
>> multiple HDMI/DPs.  The latest PA should be able to check the jack
>> detection of each port, so that it can switch to the actually
>> connected one.
>>
>>
>> Takashi
>>
> 
> Thanks for the explanation. The PA package for Ubuntu is a bit behind (v8
> for 16.04 LST and v10 for latest 17.10) so it will be easier for users just
> to edit /etc/pulse/default.pa in the interim. But is there a way to stop
> the multiple and repeating "Audio Port: ASoC: no backend DAIs enabled for
> Audio Port" messages in dmesg from occurring without modifying the distro's
> kernel?

That issue comes from the mixer configuration (or lack thereof) or 
missing UCM files, it's not really a kernel issue.
We've talked in the past of moving existing UCM files to a new repo 
(with a clarified license) and adding the ones I maintained, it's likely 
to happen after we are done with the open-source firmware (SOF) 
integration which requires some plumbing to the life of distros easier.
