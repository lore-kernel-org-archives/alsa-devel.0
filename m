From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound
 regression on Dell XPS 13 [Was: Discussion around quirking the _REV
 behavior for the XPS 13 (2015) until 4.2]
Date: Tue, 12 May 2015 12:29:48 -0500
Message-ID: <5552388C.9000500@dell.com>
References: <55401602.5050907@dell.com>	<55480021.1090402@dell.com>	<20150511182658.GA8516@isilmar-3.linta.de>	<20150512101258.GL2761@sirena.org.uk>	<55521BA0.3030606@dell.com>	<20150512161849.GD3066@sirena.org.uk>
 <CAPeXnHtdU=9bMjHh8NSArYngxDC1wSp3ZDiN96e5gHB_LQjr5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ausxippc110.us.dell.com (ausxippc110.us.dell.com
 [143.166.85.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 78C47265379
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 19:30:04 +0200 (CEST)
In-Reply-To: <CAPeXnHtdU=9bMjHh8NSArYngxDC1wSp3ZDiN96e5gHB_LQjr5g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthew Garrett <matthew.garrett@coreos.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "robert.moore@intel.com" <robert.moore@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@coreos.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>, "han.lu@intel.com" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org



On 05/12/2015 12:21 PM, Matthew Garrett wrote:
> On Tue, May 12, 2015 at 9:18 AM, Mark Brown <broonie@kernel.org> wrote:
>> You need PulseAudio 6.0 but otherwise yes, it works for me.
> Since there's no way to get this working without using new userspace,
> we're basically stuck with having to support _REV 5. And since we're
> supposed to support old userspace basically forever, this isn't going
> to be something that we can just remove in a few months. But since the
> hardware is intended to be used in I2S mode, we don't want this quirk
> to be there forever. So we're basically left with adding
> CONFIG_ACPI_WORKAROUND_BROKEN_DELLS which enables the quirk, default
> it to Y and then let distributions set it to N when they've got
> sufficiently new userspace. Unless someone has a better plan?
Just to be clear, from the Dell side only the XPS 13 9343 has this _REV 
behavior.

What's wrong with a DMI quirk until I2S is mature on the kernel side and 
userspace is new enough in distros?  Is it too early in boot for DMI 
quirks?  That would enforce that no other machines can use _REV value of 
5 to detect Linux without breaking the 9343.
