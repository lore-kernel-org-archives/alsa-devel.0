From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
	mode support
Date: Mon, 3 Sep 2018 10:24:58 +0900
Message-ID: <163823ec-3f37-afa8-91c3-dabbe9fe31f2@sakamocchi.jp>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
 <d553d212-d3ce-ec5f-86f3-062cd51d50ec@sakamocchi.jp>
 <1535504395.3198.7.camel@intel.com>
 <0b596f65-d71d-0999-c817-3fb76f055e95@sakamocchi.jp>
 <1535757482.23424.19.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BC6E267657
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 03:25:02 +0200 (CEST)
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so7843043plb.11
 for <alsa-devel@alsa-project.org>; Sun, 02 Sep 2018 18:25:02 -0700 (PDT)
In-Reply-To: <1535757482.23424.19.camel@intel.com>
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
To: "Guedes, Andre" <andre.guedes@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 1 2018 08:18, Guedes, Andre wrote:
>> I have another concern of buffering in a perspectives of delay of
>> task
>> scheduling.
>>
>> The interval of task scheduling for this plugin is decided mainly by
>> the value of 'frames_per_pkt', given by users. In your documentation,
>> the value is 6[1]. Of cource this is an example but in this case the
>> interval is calculated as 125us at 48.0kHz. In my opinion, task
>> scheduling in Linux kernel brings deadline misses for the interval,
>> in most cases such as major Linux distribution on usual personal
>> computers. When considering about the fact that recent motherboards
>> implements Intel I210/220 series, it's better to care for the low-
>> level
>> realtime systems, in my opinion.
> 
> Agreed.
> 
> To mitigate this scheduling issue, a follow-up patchset will extend the
> plugin to leverage the ETF qdisc [1] which will be available on next
> kernel release. The idea is: instead of sending one AVTP packet at
> every interval, the plugin will send several AVTP packets at once,
> configuring their Tx time accordingly, so it can "sleep" for longer
> periods of time. The goal is to ease on task scheduling by
> offloading  packet transmissions to the NIC.

A feature to queue packets with a transmission timing is mandatory for
applications to implement this kind of time-awareness packet
transmission protocol on general purpose operating system which has less
guarantees of its real-time capability.

In a case of IEC 61882-1/6 on IEEE 1394 bus, controllers of 1394 OHCI[1]
allows applications to queue several packets to corresponding
isochronous cycle. As a result, the controller can transfer each packet
at each isochronous cycle.

 From my curiousity, would I ask you to explain about usage of the
ETF 'qdisk' for this kind of applications? How relevant hardware
guarantees timing of transmission for queued packets? Or network stack
on Linux kernel govern the transmission timing in the proposed
patchset?[2].

[1] 1394 Open Host Controller Interface Specification Release 1.1 (2000, 
Promoters of the 1394 Open HCI)
http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/ohci_11.pdf
[2] [PATCH v2 net-next 00/14] Scheduled packet Transmission: ETF
https://marc.info/?l=linux-netdev&m=153065819412748


Thanks

Takashi Sakamoto
