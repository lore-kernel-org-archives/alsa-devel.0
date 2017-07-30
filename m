From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: Re: snd_ctl_add_enumerated_elem_set and TLV
Date: Mon, 31 Jul 2017 00:56:16 +0200
Message-ID: <c352e510-9c89-2411-8491-d400366793d2@iot.bzh>
References: <9eb2ccd3-9574-26fc-cb5b-6defcc59578f@iot.bzh>
 <78debac2-b00f-706d-8beb-497f9ceb02d2@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
 [209.85.128.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC2C266CE1
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 00:56:19 +0200 (CEST)
Received: by mail-wr0-f174.google.com with SMTP id y43so172595207wrd.3
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 15:56:19 -0700 (PDT)
In-Reply-To: <78debac2-b00f-706d-8beb-497f9ceb02d2@ladisch.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thank you. I will write an empty container. Hopefully most clients will 
be happy with it.

I understand that it not a critical BUG, but as you said the flag should 
not be set to readable, when they is no TLV.

On 30/07/17 16:49, Clemens Ladisch wrote:
> Fulup Ar Foll wrote:
>> I'm using snd_ctl_add_enumerated_elem_set to create user controls, I
>> do not understand why it set "TLV readable" option at true by default.
> 
> As far as I can see, the library API has no mechanism to set or clear
> this access right, so it's set by default to allow TLVs for controls
> where it makes sense.
> 
> (In theory, the code could be changed to clear the readable flag when
> there is no TLV.)
> 
>> I have a simple enumeration without TLV. I use snd_ctl_elem_write but
>> do not call snd_ctl_elem_tlv_write. I do no understand how to prevent
>> snd_ctl_elem_info_is_tlv_readable to return true for this control,
> 
> This is not possible at the moment.
> 
>> obviously even if TLV is set as readable, it is empty and reading fail.
> 
> You'll have to write a fake TLV (an empty container).
> 
> 
> Regards,
> Clemens
> 
