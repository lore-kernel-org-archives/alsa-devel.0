From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] UCM: Implement ConflictingDevices,
 add device list to devices
Date: Fri, 3 Jun 2011 11:20:46 +0100
Message-ID: <4DE8B57E.2000701@ti.com>
References: <1307059431-4913-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id CA3ED2440F
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 12:20:50 +0200 (CEST)
In-Reply-To: <1307059431-4913-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/06/11 01:03, Stephen Warren wrote:
> Wherever SupportedDevice can appear, also allow ConflictingDevice. Only
> one or the other (or neither) may be specified. When neither is
> specified, allow anything. Sometimes, listing ConflictingDevices may
> result in a shorter list than explicitly listing all SupportedDevices.
> 
> Add support for SupportedDevice and ConflictingDevice to SectionDevice.
> This allows representing devices which are mutually exclusive, e.g. due
> to a mux that switches between capturing from two different microphones,
> without the possibility of mixing.
> 
> Enhance is_modifier_supported to allow ignoring SupportedDevice and
> ConflictingDevice. This is useful when querying values from a
> SectionModifier; there's no reason we shouldn't be able to query values
> just because the current configuration would prevent enabling that
> device. The new is_device_supported is implemented similarly.
> 
> Enhance switch_device to remove the old device from the current device
> list before querying for the new device, and add it back immediately
> afterwards. This allows the query for the new device to ignore any
> conflicts caused solely by the old device.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Liam Girdwood <lrg@ti.com>

> ---
> Depending on decisions in the thread I recently started entitled
> "UCM modifier names", this patch may change, e.g. name_match may not
> be needed, or could be simpler.
> 
> I should probably split some of this into separate patches, but I
> figured I'd get it out there for people to discuss first.
>

Code looks fine, but it maybe best to rework with the index changes discussed in your previous mail (at least so we can deprecate the index).

Liam
