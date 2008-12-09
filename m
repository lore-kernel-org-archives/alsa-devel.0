From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware mixing
Date: Tue, 9 Dec 2008 08:56:22 +0530
Message-ID: <98769532B4BB14429434178695419EAE268A8280@bgsmsx501.gar.corp.intel.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
	<98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812081915w1f718d7dp605ea2bbc6c099d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id EEFC11037FC
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 04:26:38 +0100 (CET)
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I was thinking to pass this information from snd_pcm_t->private_data. This gets copied to substream->private_data internally which would reach the driver. Am I right here?

-----Original Message-----
From: Harsha, Priya 
Sent: Tuesday, December 09, 2008 8:54 AM
To: 'Lee Revell'
Cc: alsa-devel@alsa-project.org
Subject: RE: [alsa-devel] question on hardware mixing

I have a DSP engine with FW. I need to pass this information to the FW which does some processing for voice and music differently.

Thanks,
Harsha


-----Original Message-----
From: rlrevell@gmail.com [mailto:rlrevell@gmail.com] On Behalf Of Lee Revell
Sent: Tuesday, December 09, 2008 8:46 AM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] question on hardware mixing

On Sat, Dec 6, 2008 at 1:56 AM, Harsha, Priya <priya.harsha@intel.com> wrote:
> Hi,
>
> Thanks.
>
> A quick follow up question. In the trigger function - I see that from substream->runtime->private_data, voice specific parameters are extracted. How and can somehow user space fill in some private data to the driver so that driver can process voice in a different way and music in a different way?
>

What exactly do you want to do differently?

Lee
