From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Fri, 22 Mar 2013 09:11:01 +0100
Message-ID: <514C1215.9010708@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 11E1326627F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 09:11:02 +0100 (CET)
Received: by mail-wi0-f181.google.com with SMTP id hj8so289762wib.8
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 01:11:01 -0700 (PDT)
In-Reply-To: <514B79DA.6030203@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

Hi Jussi,
Hi Andreas,

On 21.03.2013 22:21, Jussi Laako wrote:
> On 03/18/2013 03:49 PM, Daniel Mack wrote:
>> Yes. If at all, we should add a SND_PCM_FORMAT_DSD, and a quirk for that
>> device. But given that there is no application for DSD in userspace
>> either, we probably don't need to care.
> 
> Yes there is? At least my application. And I'd be happy to support any 
> custom format created for the purpose... :)

Ah, interesting. So what *are* you using right now for your transport in
userspace? Is your application abusing standard PCM interfaces that are
'known' to be in fact DSD? How do other DACs expose their interfaces in
the Linux world, and which ones did you test your application with?

If there's actual need for a new SND_PCM_FORMAT, it would be easy to
patch it through all the layers down to userspace.

> I would propose to create custom 8-bit sample formats for DSD purposes, 
> similar to the ASIO formats. Practically two main ones, byte with oldest 
> bit in MSB and byte with oldest bit in LSB. And maybe the "DSD-wide" one 
> which is 8-bit DSD sample.

Andreas, which modes does the MPD-3 accept exactly on its two 'raw data'
interfaces? The only hint I have is that one of it is 8-bit and the
other is 16-bit, but given the lack of a proper test setup for this
format, I can't currently test anything.


Thanks,
Daniel
