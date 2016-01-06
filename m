From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 3/8] ASoC: intel: boards: add card for
 MinnowBoard I2S access
Date: Wed, 6 Jan 2016 14:59:05 -0600
Message-ID: <568D8019.3050407@linux.intel.com>
References: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1451949630-3475-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160105131539.GC16023@sirena.org.uk> <568BD823.3080703@linux.intel.com>
 <20160106174207.GC6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D0012654DC
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 21:59:08 +0100 (CET)
In-Reply-To: <20160106174207.GC6588@sirena.org.uk>
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

On 1/6/16 11:42 AM, Mark Brown wrote:
> On Tue, Jan 05, 2016 at 08:50:11AM -0600, Pierre-Louis Bossart wrote:
>> On 1/5/16 7:15 AM, Mark Brown wrote:
>
>>> I'm wondering how this is going to get loaded (I don't see what creates
>>> the platform device) and how we handle systems with a CODEC connected on
>>> the expansion headers?
>
>> Good question.
>
>> To solve this audio is disabled by default, and we have an EFI application
>> loaded by the startup.nsh file that sets the relevant codec information in
>> the SSDT table so that you can swap codec cards at will. The EFI application
>> will be open-sourced so that additional codecs can be added as needed with
>> changes in the ASL code. The whole thing was tested with experimental
>> releases in three different setups for now but will be formally released
>> next month.
>
> Sets the relevant codec information by...?

exposing devices and dependencies, setting the _HID, codec I2C address, 
Gpio lines, DSD properties if needed. Nothing new compared to a normal 
DSDT table except that you only add the audio-related information yourself.

>
>> On probe the sst_acpi part checks for the presence of known codecs and
>> registers the platform driver. For the case where no codec is present I just
>> added an entry at the end of the table that always works (checks for an
>> SOC-side HID) and is selected if no other codec was found. I need to add
>> this patch and submit it, forgot to add it in this batch.
>
> Can we punt on this until we've got the rest of the infrastructure to
> look at?  I'd feel safer and it sounds like it's going to need some
> manual hacking to get working anyway until the other bits are lined up.

that's fine, i will provide more documentation to explain the steps 
later this month. The 'infrastructure' isn't that bad really - and since 
the SSDT update application is open-source for once you can't blame the 
BIOS if your audio doesn't work :-)
