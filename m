From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question on wait_for_avail function
Date: Wed, 05 Jun 2013 11:17:23 +0200
Message-ID: <51AF0223.5020901@ladisch.de>
References: <1794d77072add642c43309c0a06bfadb.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7E8C4261A03
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 11:17:28 +0200 (CEST)
In-Reply-To: <1794d77072add642c43309c0a06bfadb.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gsantosh@codeaurora.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

gsantosh@codeaurora.org wrote:
> 2) HAL issues pause in parallel to the write

This is illegal.
<http://www.alsa-project.org/main/index.php/SMP_Design> says:
| The use of returned handles [such as snd_pcm_t*] must be serialized in
| the application using own locking scheme.

If you want to issue a pause while waiting for data to be written, use
non-blocking writes.


Regards,
Clemens
