From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: valgrind error in snd_tlv_get_dB_range
Date: Sun, 19 Jan 2014 12:19:44 +0100
Message-ID: <52DBB4D0.1040506@ladisch.de>
References: <52DBA5EB.3070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 136CC261689
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 12:19:57 +0100 (CET)
In-Reply-To: <52DBA5EB.3070104@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ivan Sorokin <vanyacpp@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ivan Sorokin wrote:
> One program (qasmixer -- alsa mixer) on my system prints lots of valgrind errors.

Yes, these are errors in valgrind.

> As I understand the problem is that init_db_range initialize invalid rec->db_info, because snd_hctl_elem_tlv_read failed to fully initialize tlv:

snd_hctl_elem_tlv_read initializes as many bytes as needed.

I'd guess valgrind doesn't notice this because this is done through
an ioctl, in the kernel.


Regards,
Clemens
