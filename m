From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [RFC] MIDI over Bluetooth Low Energy
Date: Thu, 1 Oct 2015 12:59:14 +0100
Message-ID: <CAGrhNMwtPVTD6+dNO0GALtzO6pZz=j+dLo7q0uF=b6_m3tBcJg@mail.gmail.com>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
 <560D1893.6040509@ladisch.de>
 <CAGrhNMxmtt-5kZO-6me2sPQYeQ5wcpvonKqzbx7CEB5=RJ724Q@mail.gmail.com>
 <560D1EC2.8010603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CF34266682
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 13:59:15 +0200 (CEST)
Received: by lahh2 with SMTP id h2so73159378lah.0
 for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2015 04:59:14 -0700 (PDT)
In-Reply-To: <560D1EC2.8010603@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Thu, Oct 1, 2015 at 12:53 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Felipe Tonello wrote:
>> On Thu, Oct 1, 2015 at 12:27 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>> Felipe Tonello wrote:
>>>> I am planning to start the support of MIDI BLE profile[1].
>>>>
>>>> I suggest two main goals:
>>>>  * To be transparent to applications, i.e., use rawmidi and sequencer
>>>> ALSA interfaces to interact.
>>>>  * To support peripheral and central BLE roles.
>>>>
>>>> My question is: what is the best way possible of doing it?
>>>
>>> Just write a (user-space) sequencer client.
>>
>> But this will limit to seq interface only. It will not be available
>> via rawmidi interface, right?
>
> Yes.  And why would this be a problem?

None besides the obvious fact that rawmidi interface will be out.

>
>>>> They all have the problem of context switching between bluez plugin
>>>> and alsa midi driver.
>>>
>>> Why would context switches be a problem?
>>
>> It is just too much travelling around.
>
> It hasn't been a problem with any other MIDI application.

It can be for MIDI Multidimensional Polyphonic Expression (MPE)[1] .

[1] https://docs.google.com/document/d/1-26r0pVtVBrZHM6VGA05hpF-ij5xT6aaXY9BfDzyTx8/edit

Felipe
