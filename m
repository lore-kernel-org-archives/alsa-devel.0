From: ThomasJF <tsepp2001@t-online.de>
Subject: non-blocking mode example
Date: Sat, 12 Aug 2017 13:58:25 +0200
Message-ID: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 525DD266F0A
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 13:58:27 +0200 (CEST)
Received: from fwd08.aul.t-online.de (fwd08.aul.t-online.de [172.20.26.151])
 by mailout06.t-online.de (Postfix) with SMTP id 06CFD41C8A60
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 13:58:27 +0200 (CEST)
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

Hi,

could anyone please link me to or show me a small demo example, like 
"pcm_min.c" with working snd_pcm_open in SND_PCM_NONBLOCK - mode? 
Standard I/O transfers or Event waiting routines. I get both working - 
but only in blocking mode.

I want to stop/pause with commands inside a tcp-server.

Regards
Thomas
