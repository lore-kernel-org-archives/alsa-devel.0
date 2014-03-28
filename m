From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
 underuns
Date: Fri, 28 Mar 2014 09:42:52 +0100
Message-ID: <5335360C.9060806@ladisch.de>
References: <loom.20140326T163743-253@post.gmane.org>
 <CAN8ccib45znh-JbH57EhfbPNQg_fginmX9Tbr=yKMmd4D=iygQ@mail.gmail.com>
 <CAN8cciZkGx5XBO+u0b7V9YN8VU_rz8ckL8B=6oBFJr+-Yg8cxw@mail.gmail.com>
 <CAN8cciYy4V4StjqRfPpgZ8JMEYZrvpJYCBjfZtNhcn_2enRx6g@mail.gmail.com>
 <loom.20140327T213645-260@post.gmane.org>
 <CAN8ccibOwd24r-qCrcnrZXaPy5We6dB=GccDyTR_qS-rPns1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7035B26549C
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 09:42:56 +0100 (CET)
In-Reply-To: <CAN8ccibOwd24r-qCrcnrZXaPy5We6dB=GccDyTR_qS-rPns1uw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, andoru <andoru.blah@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/cmipci.c?id=1c583063a5c769fe2ec604752e383972c69e6d9b
>
> you have to dump the value of the register and increase the number of
> trials to find out whether you can get a valid value

As shown in the bug, the register fails continuously; this is not
a transient failure that could be worked around like in that commit.

>>> Seem bug in adding channel map to iec958 instead of analog
>>
>> What does that mean?

Nothing relevant to this problem.

>> What should I do with those patches?

Nothing.


Regards,
Clemens
