From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Mon, 18 Mar 2013 19:51:09 -0700
Message-ID: <5147D29D.70705@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 by alsa0.perex.cz (Postfix) with ESMTP id DCE09265CC5
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 03:51:17 +0100 (CET)
Received: by mail-pb0-f42.google.com with SMTP id xb4so5267pbc.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 19:51:16 -0700 (PDT)
In-Reply-To: <51471B51.4000006@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 03/18/2013 06:49 AM, Daniel Mack wrote:
>>> Yes, I  thought about that for a while as well. In fact, the data format
>>> the device supports on these altsettings is "DSD", but that doesn't have
>>> a defined value in the UAC2 spec (and strictly speaking, DSD is not even
>>> PCM).
>>>
>>> So when a device is as unspecific as 'raw data', there's not much we can
>>> do about that except for exposing the same level of uncertainty down to
>>> the apps, right?
>>
>> Yes.  We can add a new format SND_PCM_FORMAT_RAW, but it's not much
>> better than SND_PCM_FORMAT_SPECIAL after all :)
>
> Yes. If at all, we should add a SND_PCM_FORMAT_DSD, and a quirk for that
> device. But given that there is no application for DSD in userspace
> either, we probably don't need to care.

+1

However, more and more applications are wanting to send non-linear PCM 
data through ALSA.  So, we probably /do/ need to care.

-gabriel
