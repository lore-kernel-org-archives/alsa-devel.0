From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/5] UCM: Deprecate index on Section{Device,
	Modifier}
Date: Mon, 6 Jun 2011 10:48:14 +0100
Message-ID: <4DECA25E.3090601@ti.com>
References: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FDCE10384C
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 11:48:18 +0200 (CEST)
In-Reply-To: <1307134594-32176-1-git-send-email-swarren@nvidia.com>
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

On 03/06/11 21:56, Stephen Warren wrote:
> The previous supported "legacy" syntax was:
> 
> SectionDevice."Speaker".0 {
> SectionModifier."Capture Voice".0 {
> 
> This change supports new syntax:
> 
> SectionDevice."Speaker" {
> SectionModifier."Capture Voice" {
> 
> ... but also allows the old syntax, iff the index is exactly "0". If an
> index is present, but not exactly "0", parsing will appear to succeed,
> but produce an empty device or modifier.
> 
> When naming devices and modifiers, even if the legacy format is used,
> any index is not included in the name; i.e. both sets of syntax above
> name the device just "Speaker".
> 
> The SupportedDevice list syntax still also accepts either "x" or "x.0",
> but internally strips ".0" from the tail of any device name. Any other
> name including "." is disallowed.
> 
> Finally, when comparing device or modifier names, a simple exact string
> compare is now used, since no index data is ever present in device or
> modifier names.
> 
> The one functional change introduced here is that a SupportedDevice
> entry of just "x" will now only ever match a single device. It previously
> acted as a wildcard for any device named "x.foo".
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

All

Acked-by: Liam Girdwood <lrg@ti.com>
