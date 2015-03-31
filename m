From: Fulup Ar Foll <fulup@breizhme.net>
Subject: 1st draft:  ALSA Json Gateway and HTML5 UI
Date: Tue, 31 Mar 2015 19:35:05 +0200
Message-ID: <551ADAC9.60001@breizhme.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C610D264F0A
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 19:35:07 +0200 (CEST)
Received: by wgoe14 with SMTP id e14so27130659wgo.0
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 10:35:07 -0700 (PDT)
Received: from [10.10.11.101] (sne56-1-88-180-128-218.fbx.proxad.net.
 [88.180.128.218])
 by mx.google.com with ESMTPSA id n6sm17805956wiw.6.2015.03.31.10.35.06
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2015 10:35:06 -0700 (PDT)
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
   I would need some help to finish a json version of amixer.
   Porting cget is done, but for cset I have an issue with
   "snd_hctl_find_elem (handle, id)". I'm not sure what's the right method
   to pass it. I've tried every options I could imagine. But if it works
   on Mint/32bit, it miserably fail on OpenSuse/64. Furthermore amixer.c
   as this strange comment /* FIXME: Remove it when hctl find works ok !!!
   */ and they do not use snd_hctl_find_elem.
   I posted a small C code to highlight the issue at
   [1]https://gist.github.com/fulup-bzh/891e5627be325150337f
   My question is simple, did I miss something ? should I move to lower
   level API ?
   Note: While the painting for my json-gateway is not dry, I nevertheless
   pushed a initial running version with cget at
   [2]https://github.com/fulup-bzh/AlsaJsonGateway
   I also have a small HTML5/UI at
   [3]http://breizhme.net/alsajson/mixers/ajg#/scarlett?card=2
   While UI code is very dependant on each soundcard [in my case
   Scarlett/Focurite] the Json-Gateway is 100% independent of the board.
   If anything one have an idea, please let me know.
   Fulup

References

   1. https://gist.github.com/fulup-bzh/891e5627be325150337f
   2. https://github.com/fulup-bzh/AlsaJsonGateway
   3. http://breizhme.net/alsajson/mixers/ajg#/scarlett?card=2
