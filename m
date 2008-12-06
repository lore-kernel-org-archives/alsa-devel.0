From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: question on hardware mixing
Date: Fri, 5 Dec 2008 23:58:32 -0500
Message-ID: <75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id CF6B224422
	for <alsa-devel@alsa-project.org>; Sat,  6 Dec 2008 05:58:38 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so293976rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 20:58:37 -0800 (PST)
In-Reply-To: <98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
Content-Disposition: inline
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
