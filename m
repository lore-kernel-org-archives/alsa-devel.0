From: oeai <oeai@ya.ru>
Subject: Re: EMU-1212m "no Audiodock - no firmware" patch
Date: Sat, 29 Dec 2012 06:45:40 +0400
Message-ID: <50DE5954.4020101@ya.ru>
References: <50AD5347.5040003@ya.ru> <s5h8v9tr1zu.wl%tiwai@suse.de>
Reply-To: oeai@ya.ru
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward12.mail.yandex.net (forward12.mail.yandex.net
 [95.108.130.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 7907B2615D5
 for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2012 03:45:43 +0100 (CET)
In-Reply-To: <s5h8v9tr1zu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <james.dutton@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

aLoha!
Sorry, being so long, i was doing some other things.

i've downloaded the sound.git and somehow just compiled right what i 
needed and changed the code.

i've changed the snd_emu10k1_emu1010_init function so it is now loading 
regs from other function load_patches
     because of that a lot of space has changed, but it is simplier to 
just set to default right now
     and the error in the init function was that it was not calling the 
load_firmware function in the end
     that's the real problem
     and a lot of changes that in the load_patches are just to leave 
audiodock outside if it is not presented
     tried the resume function - it's not working for emu1212 need to 
reload alsa
     i thought of calling dev_create or dev_free but not sure how to use 
it free_emu is hanging up on wake_up
     yeah i've done the exclamation !EMU_HANA_OPTION_DOCK_OFFLINE in 
firmware_thread and added "else if" to avoid occasional error
     well it is Loading!!!
     and looks like no loops occuring.

in the bottom there's a emufx.c patch
Disabled most of unuseful sliders for emu_model cards



-- 
OEAI
