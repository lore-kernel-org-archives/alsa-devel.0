From: Liam Girdwood <lrg@ti.com>
Subject: Re: UCM modifier names
Date: Fri, 3 Jun 2011 11:11:48 +0100
Message-ID: <4DE8B364.8000109@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498E1C68B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 797DE1038D9
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 12:11:55 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498E1C68B@HQMAIL01.nvidia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Stephen,

On 02/06/11 20:56, Stephen Warren wrote:
> Liam,
> 
> UCM syntax is e.g.:
> 
> SectionModifier."Capture Voice".0 {
> 
> This maps to a modifier->name of "Capture Voice.0".
> 
> However, when find_modifier searches for modifiers, it strips off the
> index (".0") from modifier->name, and just compares base name. As such,
> the index doesn't seem useful.
> 

Your right, the index is probably not very useful for modifiers atm. 

> I propose:
> 
> a) In parse_modifier, fail if index!=0.
> 
> b) In parse_modifier, store just the name in modifier->name.
> 
> c) In find_modifier, remove all the special handling of "." in the name,
>    and just strcmp(modifier->name, modifier_name).
> 
> Perhaps the index should be completely removed from the file syntax too?

Yeah, I would go with that for modifier.

> If an index was actually useful in any case, the author of the file could
> simply add it within the name string, i.e.:
> 
> typical: SectionModifier."Capture Voice" {
> 
> unusual: SectionModifier."Capture Voice 0" {
> 
> Of course, that wouldn't be backwards-compatible file syntax. Perhaps we
> could make the index optional, but always validate it was 0 if present,
> as I said above.
> 

we do have some users using the modifier.0 syntax so maybe best to deprecate it.

> I actually wonder if the index on the SectionDevice makes any sense
> either; functions like is_modifier_supported would be a lot simpler if
> devices simply never had an index, such that is_modifier_supported was
> a simple strcmp too. The worst fallout from that change might be a
> requirement to list more entries in SupportedDevice/ConflictingDevice.
> 

ok.

> 
> Second, when find_modifier is called from get_value, it'll fail with a
> valid modifier name that happens not to be supported on any currently
> active devices. Is that intended? I'd expect to be able to retrieve
> values from any/all devices and modifiers irrespective of whether those
> devices or modifiers could actually be activated given the currently
> active configuration.
> 
> I propose: Adding a parameter to find_modifier to indicate whether to
> call is_modifier_supported or not, this new parameter being false for
> get_value and true in other cases.
> 
> This issue will also be relevant to find_device when I modify that to
> call new function is_device_supported.
> 
> For find_device, we may also have to add a parameter for a device name
> that gets ignore when checking SupportedDevice/ConflictingDevice, which
> can be passed when switching devices.
> 
> Thanks for your thoughts.
> 

Sounds reasonable to me.

Liam
