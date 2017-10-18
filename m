From: Rob Duncan <rduncan@tesla.com>
Subject: snd_pcm_ioplug_avail_update() confusion
Date: Tue, 17 Oct 2017 23:03:57 -0700
Message-ID: <dw77emh8ux0z76.fsf@tesla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0122.outbound.protection.outlook.com [104.47.38.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AB7C266FEA
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 08:04:01 +0200 (CEST)
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

I'm working on an external IO plugin based on ioplug and I'm confused
about the behavior of snd_pcm_ioplug_avail_update().  Specifically this
call (src/pcm/pcm_ioplug.c:657):

    result = io->data->callback->transfer(io->data, areas, offset, size);

Why isn't there a subsequent call to snd_pcm_mmap_appl_forward() like
there is in ioplug_priv_transfer_areas()?  It seems that without such a
call the captured data will be lost, or have I missed something?

Thanks,

Rob.
