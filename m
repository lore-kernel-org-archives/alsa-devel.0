From: "Zhang wei" <zhangwei@vimicro.com>
Subject: about snd_pcm_writei() parameter
Date: Tue, 16 Apr 2013 16:21:12 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A082F2BC4@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (unknown [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EEAC265074
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 10:21:18 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi all.

 

Is there have some limitation on the parameter size of the interface: 

 

snd_pcm_sframes_t snd_pcm_readi(snd_pcm_t *pcm, void *buffer,
snd_pcm_uframes_t size)?

 

should be the SIZE as any value ? For example, set the size <
period_size, ok?

 

does the parameter depend on the period_size?              

 

Thanks a lot.

----

BR

zw
