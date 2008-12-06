From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware mixing
Date: Sat, 6 Dec 2008 12:26:52 +0530
Message-ID: <98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id F0E8624479
	for <alsa-devel@alsa-project.org>; Sat,  6 Dec 2008 07:57:09 +0100 (CET)
In-Reply-To: <75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
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

Hi,

Thanks.

A quick follow up question. In the trigger function - I see that from substream->runtime->private_data, voice specific parameters are extracted. How and can somehow user space fill in some private data to the driver so that driver can process voice in a different way and music in a different way?

Thanks,
Harsha


-----Original Message-----
From: rlrevell@gmail.com [mailto:rlrevell@gmail.com] On Behalf Of Lee Revell
Sent: Saturday, December 06, 2008 10:29 AM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] question on hardware mixing

On Fri, Dec 5, 2008 at 12:03 PM, Harsha, Priya <priya.harsha@intel.com> wrote:
> Hi,
>
> If my sound card supports hardware mixing, how do I need to code my sound card driver such that I can send multiple streams through ALSA to the sound card driver at the same time?
>

Check out the emu10k1 driver.  You need something like the voice
allocator in that driver that assigns a hardware mixing channel or
channels when ALSA asks the driver for a new PCM stream.

User space would open the same device multiple times (up to the
hardware voice limit) and the driver manages the allocations.  From
userspace POV a hardware mixing device looks just like a single stream
device, but it doesn't return -EBUSY when you open it multiple times.

Lee
