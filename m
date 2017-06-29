From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Fwd: Issue on Linux 4.12-rc7 on iMX6 based board
Date: Thu, 29 Jun 2017 08:37:41 -0300
Message-ID: <CAOMZO5C1HSN2m4P34GQq2+SKB+kmm9WUjr37T_Q_W6LwCQQQFQ@mail.gmail.com>
References: <7ab79167-fa6c-4aea-0545-48d0522d5d77@eurekelettronica.it>
 <d7d15b1d-ac7f-4b45-b7e6-e4cdc0d5cc65@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C04266991
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 13:37:42 +0200 (CEST)
Received: by mail-qt0-f181.google.com with SMTP id i2so71646349qta.3
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 04:37:42 -0700 (PDT)
In-Reply-To: <d7d15b1d-ac7f-4b45-b7e6-e4cdc0d5cc65@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gianluca <gianlucarenzi@eurekelettronica.it>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Gianluca,

On Wed, Jun 28, 2017 at 12:34 PM, gianluca
<gianlucarenzi@eurekelettronica.it> wrote:

> Hello list,
>
> I have some issue using the sgtl5000 on two custom boards based with iMX6.
> One board has iMX6DL and the other has iMX6QP.
>
> The issue is I have a (dramatically high) strange value on mixer settings
> (looks like a int32 limit or similar)
>
> This is the output of amixer:
>>
>> # amixer
>> Simple mixer control 'Headphone',0
>>   Capabilities: pvolume pswitch pswitch-joined
>>   Playback channels: Front Left - Front Right
>>   Limits: Playback 0 - 127
>>   Mono:
>>   Front Left: Playback 0 [2147483647%] [-51.50dB] [on]
>>   Front Right: Playback 0 [2147483647%] [-51.50dB] [on]

Double check the codec hardware: is I2C communication working, are you
able to dump the SGTL5000 registers, check the codec power supplies,
MCLK, etc.
