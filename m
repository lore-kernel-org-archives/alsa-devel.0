From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Subject: Help debugging a sound problem
Date: Mon, 13 Mar 2017 06:43:50 +0000
Message-ID: <AM2PR07MB1027F3B5CB106FB3AACC1A78A1250@AM2PR07MB1027.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0127.outbound.protection.outlook.com [104.47.1.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 6565B2666E1
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 07:43:52 +0100 (CET)
Content-Language: es-ES
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

Hi all,


This is my first email to the list. I've joined to it because I don't know where to look for help.


We have a iMX6 (ARM) board with a STA559BW audio codec connected by the I2S interface.

We are using a 3.14.52 kernel with a custom sta559 codec driver based on the TAS5709 codec

driver. Our system has the alsa library 1.0.28. Our application uses SDL 1.2.15 to handle the sound

system.


When we run the application the sound system works ok, but when we leave the application running

without playing any sound for one night then next morning we found the sound is delayed more or less

one second from when the sound is played until the sound it's heard. Traces in the SDL audiocallback

are ok, the same as when the sound is played ok.


Another clue. An 'aplay' executed in another console is played ok with no delay.


Another one. If the application process is attached with gdb and then deattached then the sounds works

ok again!


Any help is welcome in order to begin to debug this situation.


Thanks!

Jorge
