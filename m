From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: "Negative" volume settings in a kcontrol
Date: Thu, 02 May 2013 16:13:00 +0200
Message-ID: <5182746C.1070603@topic.nl>
References: <51824609.30405@canonical.com> <1367498241.8766.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob08.myregisteredsite.com
 (atl4mhob08.myregisteredsite.com [209.17.115.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CEB482615DC
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 16:13:02 +0200 (CEST)
Received: from mail.hostingplatform.com ([10.30.71.208])
 by atl4mhob08.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r42ED1Lv018879
 for <alsa-devel@alsa-project.org>; Thu, 2 May 2013 10:13:01 -0400
In-Reply-To: <1367498241.8766.3.camel@localhost>
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

Some codec registers need negative values. For example,
sound/soc/codecs/tlv320aic32x4.c specifies this:

  75 static DECLARE_TLV_DB_SCALE(tlv_step_0_5, 0, 50, 0);

  78         SOC_DOUBLE_R_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
  79                         AIC32X4_RDACVOL, 0, 0x30, 0, tlv_step_0_5),


It's incomplete. The actual range is from -63.5dB to +24dB in 0.5 dB 
steps. The 8-bit value is interpreted as a signed 8-bit integer, so to 
get -3dB the register value must be -6 or 0xFA.

For some reason, the author seemed to think that no one would ever want 
to lower the volume of the output, so he just limited the range to 
0..24dB. Or, more likely, like me he did not have a clue how to 
configure this.

There are quite a few more registers like this, usually the range is 
limited in both negative and positive ranges.

How do I explain that to Alsa?

(and on a side note "amixer" doesn't accept negative values either)
