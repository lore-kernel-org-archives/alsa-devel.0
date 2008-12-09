From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware mixing
Date: Tue, 9 Dec 2008 22:34:27 +0530
Message-ID: <98769532B4BB14429434178695419EAE268E1595@bgsmsx501.gar.corp.intel.com>
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
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 02D8F103807
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 18:04:39 +0100 (CET)
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


-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Clemens Ladisch
Sent: Tuesday, December 09, 2008 7:36 PM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org; Lee Revell
Subject: Re: [alsa-devel] question on hardware mixing

Harsha, Priya wrote:
> If I define mixer controls to switch between each substream,

I wrote "mixer controls to switch between these settings for each
substream", i.e., each substream would have its own flag.
[Harsha] I am still not comfortable how to do this... I guess EMU10K1 handle this kind of mixer controls for switching... I shall look into this driver to learn more

> can I use snd_pcm_t->private_data to communicate if it's a voice or
> audio

ALSA does not have a predefined mechanism to set it from userspace.
Your driver can initialize it when it is probed, or it can change it
when opening the substream.
[Harsha] Thanks.... so can I assume that when I open a substream, I can set a private_data to communicate to the driver if its voice/music?

HTH
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
