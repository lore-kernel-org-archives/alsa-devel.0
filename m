From: Jeremy Cline <jeremy@jcline.org>
Subject: Re: [PATCH v3] ASoC: Replace snd_soc_acpi_check_hid
 with acpi_dev_present
Date: Tue, 14 Nov 2017 19:12:27 +0000
Message-ID: <0100015fbbf26a1b-15f2d4e5-7c3d-4c15-83f9-1b719ae9a74c-000000@email.amazonses.com>
References: <0100015fa737dec2-4d7283d5-bba0-4270-9f92-8f258d2835dd-000000@email.amazonses.com>
 <20618d9a-4bd3-1653-b749-6db0c2162ac3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a8-61.smtp-out.amazonses.com (a8-61.smtp-out.amazonses.com
 [54.240.8.61]) by alsa0.perex.cz (Postfix) with ESMTP id 7688C2674D7
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 20:12:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20618d9a-4bd3-1653-b749-6db0c2162ac3@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 13, 2017 at 01:43:57PM -0600, Pierre-Louis Bossart wrote:
> On 11/10/2017 12:36 PM, Jeremy Cline wrote:
> > Replace snd_soc_acpi_check_hid() with the generic acpi_dev_present()
> > and remove the now unused snd_soc_acpi_check_hid function. This should
> > have no functional change.
> 
> The code looks ok, but I'd like to first add the fix for the quirk handling
> regression which appeared in 4.13 and is still there in 4.14. Current fix is
> at https://bugzilla.kernel.org/attachment.cgi?id=258581
> 
> Can we wait a couple of days on this one to avoid mixing bug fixes and
> renames? this would also make the stable branch fix easier to handle.

That makes perfect sense to me. I'm pretty new to all this, should I just
keep an eye on things and rebase this once that patch lands?

Thanks,
Jeremy
