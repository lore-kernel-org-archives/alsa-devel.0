From: Jose B <jose.cuerv0@yahoo.com>
Subject: Re: snd_seq_system_info_get_cur_ports function
Date: Sun, 28 Jul 2013 01:06:08 -0400
Message-ID: <51F4A6C0.1060505@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm20-vm3.bullet.mail.ne1.yahoo.com
 (nm20-vm3.bullet.mail.ne1.yahoo.com [98.138.91.150])
 by alsa0.perex.cz (Postfix) with ESMTP id 370F3261724
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 07:06:12 +0200 (CEST)
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

Dear Devs,

I've been working on a wrapper to oversimplify using the alsa midi 
sequencer, and for it I was writing a function to quickly check if any 
new ports were registered on the sequencer after the application using 
the wrapper starts up. I noticed there is no function for getting the 
current port count but there is one for getting the current number of 
sequencer clients :

snd_seq_system_info_get_cur_clients(const snd_seq_system_info_t *info)

Shouldnt there be a corresponding function for getting the current port 
count as seen below? Or is it just missing from the documentation?

snd_seq_system_info_get_cur_ports(const snd_seq_system_info_t *info)

    -- It doesn't show in code::blocks' autocomplete so i'm guessing it
    wasn't written yet.

Is anyone willing to check this out please? It would be really handy to 
have this func.

Thanks, and happy dev-ing

Jose'
