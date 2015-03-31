From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Speaker burnout
Date: Tue, 31 Mar 2015 15:57:15 +0500
Message-ID: <551A7D8B.4030107@gmail.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <551A6A15.1070605@canonical.com>
 <1427796392.581386.247465613.43178C71@webmail.messagingengine.com>
 <551A7A4D.203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D19E2614F4
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 12:56:42 +0200 (CEST)
Received: by wibgn9 with SMTP id gn9so20926659wib.1
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 03:56:41 -0700 (PDT)
In-Reply-To: <551A7A4D.203@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, "Nikita N." <nikitan@operamail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

31.03.2015 15:43, David Henningsson wrote:
>   2) From the person with the hardware, we will need alsa-info (
> https://wiki.ubuntu.com/Audio/AlsaInfo ), and also the max volume where
> this does not happen. Is -6 dB good enough? -12 dB? I don't know - this
> is something someone with the hardware must tell us, it cannot simply be
> guessed.

Another useful piece of information would be what Windows does here.

Please generate a -36 dB 1000 Hz sine wave in Audacity, save as a wav 
file, play at the maximum volume in Windows, record with a mobile phone 
(you can use software such as Tape Machine which turns AGC off in the 
phone). Ideally, the mobile phone should be placed on the table to avoid 
movements. Play the same wav file in linux (with a known safe 
attenuation), also record the sound without moving the mobile phone. 
Compare the recordings in Audacity to find out the attenuation done by 
Windows.

-- 
Alexander E. Patrakov
