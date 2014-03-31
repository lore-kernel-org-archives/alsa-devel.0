From: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <joel@weedlight.ch>
Subject: RT priority 99 on soundcard
Date: Mon, 31 Mar 2014 07:18:07 +0200
Message-ID: <1396243087.3927.1.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exsmtp04.agrinet.ch (exsmtp04.agrinet.ch [81.221.254.203])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C0C62650E7
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 07:18:23 +0200 (CEST)
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


Is running on top of soundcard with realtime priority 99 problematic?


/* and now async */ 
{ 
  static const struct timespec req = { 
    0, 
    (250000000 * (1 / 45)), 
  }; 

  if(!AGS_IS_DEVOUT_THREAD(thread)){ 
    nanosleep(&req, NULL); 
  } 
} 
