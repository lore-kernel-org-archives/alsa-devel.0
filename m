From: Flavio Protasio Ribeiro <flaviopr@microsoft.com>
Subject: Conversion to int16_t and resolution loss with rate
	converter plugins
Date: Thu, 5 Apr 2018 03:05:04 +0000
Message-ID: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0111.outbound.protection.outlook.com [104.47.37.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 176882673D3
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 05:05:07 +0200 (CEST)
Content-Language: en-US
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

Hi Folks,



The libsamplerate and speex rate converter plugins only implement the convert_s16 callback from snd_pcm_rate_ops_t. This has ALSA convert the buffer to int16_t before handing it over to the plugin for resampling. On devices with more than 16 effective bits, this implies words gets truncated and bits are lost.



Specifically for libsamplerate, the resampling is internally implemented with floats, so truncating to 16 bits does not offer a computational benefit.



I get why only convert_s16 is implemented for plugins that aren't part of the main alsa-lib package. The more generic convert callback comes with the burden having the plugin support conversion from/to any of the ALSA data types (or alternatively, having the plugin source include plugin_ops.h and its dependencies). So here's what I propose: replace convert_s16 with a convert_s32 callback which uses int32_t instead of int16_t. This would preserve all bits from the device and keep the plugin interface simple. Of course this means plugins have to be updated to use convert_s32 and rebuilt.



Thoughts?



-Flavio
