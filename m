From: Ethan Grammatikidis <eekee57@fastmail.fm>
Subject: bug in alsa-plugins: #if SND_PCM_EXTPLUG_VERSION wrong
Date: Wed, 18 Mar 2015 15:58:39 +0000
Message-ID: <1426694319.1220522.242078389.41585360@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 87E6A260422
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:59:58 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 05D2020816
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 11:59:56 -0400 (EDT)
Resent-Message-Id: <20150318155958.0A494119057@web4.nyi.internal>
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

in alsa-plugins 1.0.28 and 1.0.29, mix/*.c contain the following line:

#if SND_PCM_EXTPLUG_VERSION >= 0x102

that 0x102 needs to be 0x10002. i have alsa-lib 1.0.26 installed. its headers define SND_PCM_EXTPLUG_VERSION to 0x10001, corresponding to version number 1.0.1. that #if effectively tests for >= 0.1.2, so attempting to build alsa-plugins 1.0.28 or 1.0.29 results in a long list of errors. SND_CHMAP_MONO, SND_CHMAP_FL, etc are undeclared and snd_pcm_chmap_query_t is an unknown type.

in alsa-plugins 1.0.26 SND_PCM_EXTPLUG_VERSION is not tested. i didn't look at 1.0.27

reporting here because the bug tracker is down.

-- 
Wir mussen wissen, wir werden wissen.
