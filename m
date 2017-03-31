From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: Problems with the DP MST audio support patchset
Date: Fri, 31 Mar 2017 01:27:08 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19524854BD@SHSMSX103.ccr.corp.intel.com>
References: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
 <bceb4859-6dc9-b7a8-4d3a-81ac2a1fa907@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524850F3@SHSMSX103.ccr.corp.intel.com>
 <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 91BDB266BCE
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 03:27:12 +0200 (CEST)
In-Reply-To: <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
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
To: Pascal Wichmann <pascal.wichmann@pa-w.de>, Libin Yang <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Pascal,

>-----Original Message-----
>From: Pascal Wichmann [mailto:pascal.wichmann@pa-w.de]
>Sent: Friday, March 31, 2017 12:36 AM
>To: Yang, Libin <libin.yang@intel.com>; Libin Yang
><libin.yang@linux.intel.com>; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] Problems with the DP MST audio support patchset
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA256
>
>Hi,
>
>> Do you mean the issue is caused by the patches
>> 1480992519-108079-1-git-send-email-libin.yang@intel.com?
>I don't know whether the issues are caused directly by the specific patches;
>without them, digital audio does not work at all in my setup. Using analog
>audio however does not have the problems mentioned in my first email.
>
>> I can't see which patches are included you mentioned in the link.
>I am building my kernel from drm-tip. The relevant patches enabling DP M ST
>audio seem to be "ALSA: hda - add DP mst verb support" [0] as well as
>"ALSA: hda - add DP MST audio support" [1].
>
>> Do you know if the DP MST audio mode is used in your case?
>I think it is used; at least dp/hdmi audio does not work at all without building
>against drm-tip. (the outputs are all stated as unplugged and unavailable in
>pavucontrol for example) Is there any way to know for sure?

Get it. Basically, 5.1 audio should work. What format are you using for
testing the 5.1 audio?

Regards,
Libin

>
>Regards,
>Pascal
>
>[0]
>https://cgit.freedesktop.org/drm-tip/commit/?id=13800f397ee3b4996f316b9c
>aa8482cb90edef0d
>[1]
>https://cgit.freedesktop.org/drm-tip/commit/?id=9152085defb6426ce8f9989c
>a27e4450daefbd89
>-----BEGIN PGP SIGNATURE-----
>
>iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAljdM90ACgkQ6+YIa34W
>/zZk8A//YmadcSwYQTJIJKHJREjGSITGPx6wQYA8dix2EvP0frhnL5LEAfzCUD0b
>05H9cc+kBG3z6dIs6yytX6TFtKlqnE/ka1D80+ZYiMf/RTYpowJWXogoPF8iVW68
>MTaUtM5/CGhFF/e1V7AKDX36r5eVKYwKNUIb1vXE+nU6WbuzNrQn/vgwtIboC
>Xsj
>AQVC9RT7sRHnNVNq+WD4NYNSKfTJasnhbGo1+X3eTjY5vcWb/5H3ysaayW9W
>qnkI
>W3jYdoQmWCDZC14dKGnNZJ5J1WlF03qh95bQTJB7CDl66Nqqck621MbSzLp3+
>2xv
>0eliZLcdumLhzu6wjTKcqXsyhejhRYYR25AfKGvB8zbujKnHZOSWO1T5QgJKOVHY
>oAQAgivpmNppGuNBmFKOWDnB5pec+kx3YDo9TnTUhPfXs04vGV0nnzugt9iu9
>STq
>kzhu5fTmRfNK6uImcL4lo8JKmFu8Ws60kO0OcuUh8xd0dFy1vNF4qA0cZZywBG
>p+
>YSsTzKhljHiq2aV1CpG2xMIom1YR38agTVWbL1aeGZf3FZUhD1+G9aLB1Lz6dmf
>g
>lLlne94HGnvgGoJkTx7BR6MRmUDDb4E8sdnx/yGtJ8ILKImAMJBURHfdcv3wp+G
>C
>oihf+BjIdV7BSDFMBxW/UeEM616rmNOGbG7zWxXoH6ZTWB50CwA=
>=8Sl2
>-----END PGP SIGNATURE-----
