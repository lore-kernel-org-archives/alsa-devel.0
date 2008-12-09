From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware mixing
Date: Tue, 9 Dec 2008 08:54:14 +0530
Message-ID: <98769532B4BB14429434178695419EAE268A8273@bgsmsx501.gar.corp.intel.com>
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
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 296B31037EC
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 04:24:45 +0100 (CET)
In-Reply-To: <75b66ecd0812081915w1f718d7dp605ea2bbc6c099d9@mail.gmail.com>
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
