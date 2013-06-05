From: "Keyon.Jey" <yang.jie@linux.intel.com>
Subject: [tinycompress]how should I call compress_open for aac
 ltp file playback?
Date: Wed, 05 Jun 2013 14:46:04 +0800
Message-ID: <51AEDEAC.2020705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B52C82619F9
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:44:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ckeepax@opensource.wolfsonmicro.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I am trying to use tinycompress for hwdecoder. everything works fine, 
but after compress_open (with profile = SND_AUDIOPROFILE_AAC level=0 
ch_mode=0 rate_control=0), the playback of my aac-ltp-16bit-48KHz-Stereo 
file is faster than it should be.  Am I wrong?

struct snd_codec {
  __u32 id;
  __u32 ch_in;
  __u32 ch_out;
  __u32 sample_rate;
  __u32 bit_rate;
  __u32 rate_control;
  __u32 profile;
  __u32 level;
  __u32 ch_mode;
  __u32 format;
  __u32 align;
  union snd_codec_options options;
  __u32 reserved[3];
};

Keyon
