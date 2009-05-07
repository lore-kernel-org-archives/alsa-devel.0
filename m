From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware mixing
Date: Thu, 7 May 2009 20:05:56 +0530
Message-ID: <98769532B4BB14429434178695419EAE4AD52D66@bgsmsx501.gar.corp.intel.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
	<98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
	<493E31E3.2080504@ladisch.de>
	<98769532B4BB14429434178695419EAE268E0FA6@bgsmsx501.gar.corp.intel.com>
	<493E7B51.3030307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B3806247DC
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 16:36:04 +0200 (CEST)
In-Reply-To: <493E7B51.3030307@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

>I wrote "mixer controls to switch between these settings for each
>substream", i.e., each substream would have its own flag.

If I create a mixer control using snd_kcontrol. When two applications in parallel try to create a stream and change the snd_kcontrol, can you help me understand how I would get the stream type stored in each substream as a flag?

Also, when I get a snd_kcontrol's .set function call, I am not sure how to get the substream specific data in that call?

Thanks,
Harsha
