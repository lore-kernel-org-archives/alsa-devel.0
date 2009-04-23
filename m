From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: .pointer return value
Date: Thu, 23 Apr 2009 19:34:08 +0530
Message-ID: <98769532B4BB14429434178695419EAE4AA6D20B@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BB92103838
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 16:04:26 +0200 (CEST)
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

Hi,

Can anyone educate me on what value should be returned to .pointer function?
	Should I be passing the number of frames played till that point from the time stream started or thnumber of frames played such that the bytes is within the buf_size?

And if I am using, snd_pcm_indirect_playback_pointer, what should be my input to it?
	Should I be passing the number of bytes played till that point from the time stream started or the number of bytes within buf_size?

Thanks,
Harsha
