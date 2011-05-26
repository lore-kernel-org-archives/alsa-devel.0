From: "Soulard, MathieuX" <mathieux.soulard@intel.com>
Subject: Suspecting a bug in plugin_ops.h
Date: Thu, 26 May 2011 14:19:15 +0100
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018817731F032@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 935A91038AD
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 15:20:02 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,


I'm using alsalib and I checked its code because of one issue I have.

I did not yet solved my issue, but I think I saw a bug in alsa-lib that I would like to share with you.

It is located in [alsa-lib]/src/pcm/plugin_ops.h in the inline function sx24s().

static inline u_int32_t sx24s(u_int32_t x)
{
        if(x&0x00008000)
                return x|0x000000FF;
        return x&0xFFFFFF00;
}

I think that 0x00008000 should be replaced by 0x00000800.



Thanks
Regards

Mathieu
