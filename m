From: "MONTANARO Luciano (MM)" <luciano.montanaro@magnetimarelli.com>
Subject: [PATCH] Wrap hw_ptr to boundary in pcm_ioplug
Date: Tue, 4 Mar 2014 12:51:36 +0100
Message-ID: <67BA5DEFFBE7BF46B4C53F7E5FC5AD44344700ED7C@MXCL13.fgremc.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.ex2007.fiatgroup.com (mx1.ex2007.fiatgroup.com
 [129.35.118.116])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C1F32656E9
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 12:51:38 +0100 (CET)
Content-Language: it-IT
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The function snd_pcm_ioplug_hw_ptr_update() always increased the hw_ptr
by delta, without wrapping it to the boundary. This would lead to
problems when after many hours, the hw_ptr would overflow.
---
 src/pcm/pcm_ioplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index a90c844..c1c3a98 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -60,7 +60,7 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
                        delta = hw - io->last_hw;
                else
                        delta = pcm->buffer_size + hw - io->last_hw;
-               io->data->hw_ptr += delta;
+               snd_pcm_mmap_hw_forward(io->data->pcm, delta);
                io->last_hw = hw;
        } else
                io->data->state = SNDRV_PCM_STATE_XRUN;
--
1.7.0.4






--
Luciano Montanaro
EntryNAV - Audio Software Integrator
Magneti Marelli Electronic Systems
Viale Carlo Emanuele II 150, Venaria Reale (To)
Tel. (+39) 011 6879765





VISITA IL NOSTRO NUOVO SITO WEB! - VISIT OUR NEW WEB SITE!   www.magnetimarelli.com

Confidential Notice: This message - including its attachments - may contain proprietary, confidential and/or legally protected information and is intended solely for the use of the designated addressee(s) above. If you are not the intended recipient be aware that any downloading, copying, disclosure, distribution or use of the contents of the above information is strictly prohibited.
If you have received this communication by mistake, please forward the message back to the sender at the email address above, delete the message from all mailboxes and any other electronic storage medium and destroy all copies.
Disclaimer Notice: Internet communications cannot be guaranteed to be safe or error-free. Therefore we do not assure that this message is complete or accurate and we do not accept liability for any errors or omissions in the contents of this message.
