From: Erik de Castro Lopo <mle+la@mega-nerd.com>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Tue, 27 Oct 2015 07:00:59 +1100
Message-ID: <20151027070059.7b2ad05e164ea10341e62f99@mega-nerd.com>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
 <CAN8ccibw4HrMp7RZYQpsSYRFc02=0pOXBj+XwCj4eUueLAfcpA@mail.gmail.com>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hendrix.mega-nerd.net (hendrix.mega-nerd.net [203.206.230.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AB542608B1
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 21:01:02 +0100 (CET)
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
 by hendrix.mega-nerd.net (Postfix) with SMTP id C6455C06BF
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 07:00:59 +1100 (AEDT)
In-Reply-To: <CAN8ccibw4HrMp7RZYQpsSYRFc02=0pOXBj+XwCj4eUueLAfcpA@mail.gmail.com>
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

Raymond Yau wrote:

> Do your sound card driver support 0.5 second buffer?

If it doesn't, it should return an error instead of just not working.

Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
