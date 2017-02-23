From: =?UTF-8?Q?R=c3=a9mi_Pincent?= <mr.lahorde@laposte.net>
Subject: [Bug report] dmix on armv8
Date: Thu, 23 Feb 2017 16:46:26 +0100
Message-ID: <46451130-4651-855e-b055-7ef6c9e4537e@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpoutz2.laposte.net (smtpoutz299.laposte.net [178.22.154.199])
 by alsa0.perex.cz (Postfix) with ESMTP id C0311266860
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 16:46:30 +0100 (CET)
Received: from smtpoutz2.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout011 (Postfix) with ESMTP id D98ED52BC13
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 16:46:29 +0100 (CET)
Received: from smtpoutz2.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout011 (Postfix) with ESMTP id CB33152B81E
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 16:46:29 +0100 (CET)
Received: from lpn-prd-vrin004 (lpn-prd-vrin004.prosodie [10.128.63.5])
 by lpn-prd-vrout011 (Postfix) with ESMTP id 9311752BC13
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 16:46:29 +0100 (CET)
Received: from lpn-prd-vrin004 (localhost [127.0.0.1])
 by lpn-prd-vrin004 (Postfix) with ESMTP id 814A0710AC1
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 16:46:29 +0100 (CET)
Received: from [192.168.132.10] (a4h-creativity-lab3.inrialpes.fr
 [194.199.16.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lpn-prd-vrin004 (Postfix) with ESMTPSA id 375AE710AC5
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 16:46:27 +0100 (CET)
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

Here is my alsa config :
http://www.alsa-project.org/db/?f=d8c96ba81442526650f277e0b7d43dfb6fd668a4

On raspberry I cannot use dmix plugin, when I run a speaker-test with a very simple config using dmix (refer given 
config in alsa result), its stays stuck.
When I use default alsa config (direct use of hw:0,0 without dmix), mixing is done as said here :

    NOTE: For ALSA 1.0.9rc2 and higher you don't need to setup dmix for analogue output. Dmix is enabled by default for
    soundcards which don't support hardware mixing. You still need to set it up for digital outputs.

Here are some users having same problem 
http://raspberrypi.stackexchange.com/questions/57787/using-the-alsa-dmix-plugin-on-raspbian-jessie . I'm not sure it is 
an alsa problem. But alsa developers could help solving this issue.

regards
lah
