From: LemonZou <qlwy_15@163.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Fri, 18 Sep 2015 00:41:18 +0000 (UTC)
Message-ID: <loom.20150918T022524-444@post.gmane.org>
References: <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150403153414.b8de8df914664d7d7967120c@ao2.it>
 <20150414150236.3e8288307124a43941ab94f7@ao2.it>
 <552D1EE3.6090707@linux.intel.com> <20150624101613.GK19530@localhost>
 <20150625055046.GT19530@localhost>
 <20150625122125.72a1d72b4d3aa886d68fa3eb@ao2.it>
 <20150625164717.GU19530@localhost>
 <20150626150528.f9fdee3942f7e975d23dd701@ao2.it>
 <20150627144745.GX19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id E4B0C26588F
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 02:50:06 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1ZcjsK-0005Z6-Od
 for alsa-devel@alsa-project.org; Fri, 18 Sep 2015 02:50:05 +0200
Received: from 58.20.96.77 ([58.20.96.77])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 02:50:04 +0200
Received: from qlwy_15 by 58.20.96.77 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 02:50:04 +0200
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


Yes, with ssp0 firmware, my board sound work too, but the mic don't work,
when using arecord -f dat -t wav -d 5 foobar.wav, the record data is 0.

hexdump foobar.wav 
0000000 4952 4646 a624 000e 4157 4556 6d66 2074
0000010 0010 0000 0001 0002 bb80 0000 ee00 0002
0000020 0004 0010 6164 6174 a600 000e 0000 0000
0000030 0000 0000 0000 0000 0000 0000 0000 0000
*
00ea62c

my analog microphone is connected to the IN2+ and MIC_BIAS1 codec pins
I set alsa as :
Stereo ADC MIXL ADC1 on
Stereo ADC1 Mux ==> ADCL
RECMIXL INL on
RECMIXL BST2 on
pcm1_out mix 0 codec_in1 on
