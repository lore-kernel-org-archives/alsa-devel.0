From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: need help understanding overrun/underrun
Date: Fri, 20 Aug 2010 15:14:06 +0530
Message-ID: <98769532B4BB14429434178695419EAE0523526CDA@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id CF82C1038DE
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 11:44:38 +0200 (CEST)
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

Hi

I had modified the arecord application to call snd_pcm_writei() with the output of snd_pcm_readi(). Basically a loopback.

When we execute, I see the calls return EPIPE (lot of overruns and a few underruns). Can anyone help me understand why there are underrun/overrun being printed? Is it because of the serial call of reads and writes? Is there any issue with the driver I am using? Can you suggest some ways to overcome these messages?

Thanks,
Harsha
