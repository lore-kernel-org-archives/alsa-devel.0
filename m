From: James Cameron <quozl@laptop.org>
Subject: Mixer control appears twice in alsamixer
Date: Fri, 11 Sep 2015 17:49:48 +1000
Message-ID: <20150911074948.GC10084@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E0F26155B
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 09:50:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.real-time.com (Postfix) with ESMTP id 88DE44E97A2
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 02:50:12 -0500 (CDT)
Received: from zimbra.real-time.com ([127.0.0.1])
 by localhost (zimbra.real-time.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eBGYvEh9jr2q for <alsa-devel@alsa-project.org>;
 Fri, 11 Sep 2015 02:50:11 -0500 (CDT)
Received: from esk.lan (pa114-73-190-73.pa.nsw.optusnet.com.au [114.73.190.73])
 by zimbra.real-time.com (Postfix) with ESMTPSA id 497444E978D
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 02:50:11 -0500 (CDT)
Content-Disposition: inline
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

G'day,

I've a mixer control for "Analog Mic Boost" which appears twice in
alsamixer --view all, and once in amixer.  How do I cause it to appear
only once in alsamixer?

amixer shows both Playback and Capture channels for the control:

--

Simple mixer control 'Analog Mic Boost',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 8
  Mono: 8 [100%]

--

The control is declared with:

/* {0, +20, +24, +30, +35, +40, +44, +50, +52}dB */
static unsigned int mic_bst_tlv[] = {
	TLV_DB_RANGE_HEAD(7),
	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
	1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
	2, 2, TLV_DB_SCALE_ITEM(2400, 0, 0),
	3, 5, TLV_DB_SCALE_ITEM(3000, 500, 0),
	6, 6, TLV_DB_SCALE_ITEM(4400, 0, 0),
	7, 7, TLV_DB_SCALE_ITEM(5000, 0, 0),
	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
};

static const struct snd_kcontrol_new rt5631_snd_controls[] = {
...
	SOC_SINGLE_TLV("Analog Mic Boost", RT5631_MIC_CTRL_2,
		       RT5631_MIC1_BOOST_SHIFT, 8, 0, mic_bst_tlv),
...
}

I'm working on alc5631/rt5631 in a local branch of either 3.0 or 3.5
for the OLPC XO-1.75 and XO-4.  But the declaration seems no different
in 4.2, apart from the name of the control.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/rt5631.c?id=refs/tags/v4.2#n176

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/rt5631.c?id=refs/tags/v4.2#n233

-- 
James Cameron
http://quozl.linux.org.au/
