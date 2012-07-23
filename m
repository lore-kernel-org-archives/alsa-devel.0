From: alberto Villa <a.villa@seletech.com>
Subject: Using MMAP feature
Date: Mon, 23 Jul 2012 09:13:24 +0200
Message-ID: <500CF994.5090901@seletech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtplq01.aruba.it (smtpweb21.aruba.it [62.149.158.21])
 by alsa0.perex.cz (Postfix) with SMTP id 74AB4264EEF
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 09:13:23 +0200 (CEST)
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

Hello,

I'm going to use the MMAP feature of ALSA. I understood I have to use 
snd_pcm_mmap_begin and snd_pcm_mmap_commit functions, but I can't 
understand the meaning of some parameters in  the snd_pcm_mmap_begin 
function: when I call this function in order to have access to the 
capture stream on a call like this:

err = snd_pcm_mmap_begin(capture, &c_area, &c_offset, &c_frames);

it keeps to return c_frames = 0: is it right ? what does  this mean? is 
the buffer full so that I can read samples or the available contiguous 
space to be read is 0?

Thank you,

Alberto

-- 
Dr. Villa Alberto
Sw Engineer

SeleTech srl
via Collodi, 8 20052 Monza (MI)
tel: +39 039 5962000
fax: +39 039 9716905
email: a.villa@seletech.com
web: www.seletech.com
      www.seletech.eu
