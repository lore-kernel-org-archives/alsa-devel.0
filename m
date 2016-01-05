From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 3/8] ASoC: intel: boards: add card for
 MinnowBoard I2S access
Date: Tue, 5 Jan 2016 08:50:11 -0600
Message-ID: <568BD823.3080703@linux.intel.com>
References: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1451949630-3475-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160105131539.GC16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A3F3C2610C5
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 15:50:23 +0100 (CET)
In-Reply-To: <20160105131539.GC16023@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 1/5/16 7:15 AM, Mark Brown wrote:
> On Mon, Jan 04, 2016 at 05:20:25PM -0600, Pierre-Louis Bossart wrote:
>> Add card with dummy codec and DAI to make I2S signals observable.
>> Uses Mic and Speaker pins/widgets to control DAPM
>
> I'm wondering how this is going to get loaded (I don't see what creates
> the platform device) and how we handle systems with a CODEC connected on
> the expansion headers?

Good question.

On the minnowmax we can't use the default firmware since users may use 
different codecs and the pins may be used for different non-audio 
functions and lures. The firmare team also didn't want to maintain tons 
of options. Generating the image from source is possible but it requires 
a fair amount of work to keep track of unrelated non-audio firmware updates.

To solve this audio is disabled by default, and we have an EFI 
application loaded by the startup.nsh file that sets the relevant codec 
information in the SSDT table so that you can swap codec cards at will. 
The EFI application will be open-sourced so that additional codecs can 
be added as needed with changes in the ASL code. The whole thing was 
tested with experimental releases in three different setups for now but 
will be formally released next month.

On probe the sst_acpi part checks for the presence of known codecs and 
registers the platform driver. For the case where no codec is present I 
just added an entry at the end of the table that always works (checks 
for an SOC-side HID) and is selected if no other codec was found. I need 
to add this patch and submit it, forgot to add it in this batch.
