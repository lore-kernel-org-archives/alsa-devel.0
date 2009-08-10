From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: issue at 44.1 Khz capturing
Date: Mon, 10 Aug 2009 11:14:44 +0100
Message-ID: <ad2655cb0908100314g45b39d6x21da633b625b216f@mail.gmail.com>
References: <98769532B4BB14429434178695419EAE5F937821@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C1C4103851
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 12:14:44 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so696011fga.21
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2009 03:14:44 -0700 (PDT)
In-Reply-To: <98769532B4BB14429434178695419EAE5F937821@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2009/8/10 Harsha, Priya <priya.harsha@intel.com>:
> Hi,
>
> I am using arecord for capturing data. When I try to record at 8 or 48 KHz, it's perfectly fine. But when I try to record at 44.1 Khz, there are spikes in the recorded data for every buffer. When I tried to tap the data captured at the firmware/hardware end, it's smooth but the same data when is checked from the user space after being recorded, it has spikes. On further analysis, looks like for every buffer recorded there is either 1 sample recorded extra or 1 sample dropped. But when I printed out the values passed from the pointer function, they are exactly at the intervals of 5513 bytes.
>
> Can anyone give me any clue as to what is going wrong? I am using indirect_* functions in the driver code. Is there any buffer size round off that is giving this error? Can I handle something in the driver to avoid this?
>

A lot of sound card hardware cannot work at anything other than 48kHz.
alsa is therefore resampling to the applications rate. In this case
trying to get 44.1kHz.
It is very difficult with the current alsa architecture to get good
quality resampling.
I would advise you to record at 48kHz and use something like SOX
afterwards, to get 44.1kHz. Note that also sound cards are not good at
playing 44.1kHz because the same resampling happens. So keeping
everything at 48kHz now days is probably best.

Kind Regards

James
