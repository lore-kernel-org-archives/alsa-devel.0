From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] Fix forward/rewind support in iec958
 plugin
Date: Fri, 25 Apr 2014 10:09:37 +0200
Message-ID: <535A1841.8070208@ladisch.de>
References: <5358F356.3020701@canonical.com>
 <1398350406-10347-1-git-send-email-patrakov@gmail.com>
 <CAN8cciadq+=36DcMufwDD=M5=0EAdnkUxPv8b9Ga5JHWqg1-Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 48A9226535B
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 10:09:38 +0200 (CEST)
In-Reply-To: <CAN8cciadq+=36DcMufwDD=M5=0EAdnkUxPv8b9Ga5JHWqg1-Hg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
>> When forwarding or rewinding, the frame counter was not updated. This
>> could result in corrupted channel status words or misplaced Z-type
>> preamble.
>
> Do you mean it is the responsibility for a52 and dca plugin to return the
> SAFE value returned by snd_pcm_rewindable and snd_pcm_forwardable since
> they enocde the audio and padding zeros and write to IEC958 ?

The a52/dca plugins create data to be transferred over S/PDIF, but this
does not imply they use the iec958 plugin.

The iec958 plugin is used for sound cards that do not have a hardware
IEC958 encoder.  This is very unlikely nowadays.


Regards,
Clemens
