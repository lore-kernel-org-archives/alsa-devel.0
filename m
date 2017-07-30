From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_ctl_add_enumerated_elem_set and TLV
Date: Sun, 30 Jul 2017 16:49:22 +0200
Message-ID: <78debac2-b00f-706d-8beb-497f9ceb02d2@ladisch.de>
References: <9eb2ccd3-9574-26fc-cb5b-6defcc59578f@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CED79266C9B
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 16:49:43 +0200 (CEST)
In-Reply-To: <9eb2ccd3-9574-26fc-cb5b-6defcc59578f@iot.bzh>
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
To: Fulup Ar Foll <fulup.arfoll@iot.bzh>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Fulup Ar Foll wrote:
> I'm using snd_ctl_add_enumerated_elem_set to create user controls, I
> do not understand why it set "TLV readable" option at true by default.

As far as I can see, the library API has no mechanism to set or clear
this access right, so it's set by default to allow TLVs for controls
where it makes sense.

(In theory, the code could be changed to clear the readable flag when
there is no TLV.)

> I have a simple enumeration without TLV. I use snd_ctl_elem_write but
> do not call snd_ctl_elem_tlv_write. I do no understand how to prevent
> snd_ctl_elem_info_is_tlv_readable to return true for this control,

This is not possible at the moment.

> obviously even if TLV is set as readable, it is empty and reading fail.

You'll have to write a fake TLV (an empty container).


Regards,
Clemens
