From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v2 2/6] ASoC: Allow the DAPM routes to be stored in
 device tree
Date: Mon, 12 Dec 2011 11:34:13 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1751860838@HQMAIL01.nvidia.com>
References: <1323291510-22338-1-git-send-email-swarren@nvidia.com>
 <1323291510-22338-2-git-send-email-swarren@nvidia.com>
 <20111208043149.GA31372@opensource.wolfsonmicro.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17518605B1@HQMAIL01.nvidia.com>
 <20111210124921.GA20568@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20111210124921.GA20568-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Saturday, December 10, 2011 5:49 AM:
> On Fri, Dec 09, 2011 at 01:52:00PM -0800, Stephen Warren wrote:
...
> > This would be a fair bit of work to implement, but what are your thoughts
> > on the binding example below? It's very strongly based on ASoC, but since
> > that's so strongly based on the HW, I think you can consider it a pure
> > HW model rather than something derived from the way the driver works.
> 
> It's starting to get an idiomatic way of representing the external
> nodes, HDA is probably a good source of inspiration :)  We do need to
> have a think about the jacks, though - simple ones are fine but
> multifinction is more fun.

I just wanted to confirm that you're talking about multiple audio
functions here (e.g. mic+headphones), rather than mixing audio with
other features (e.g. s-video + line out). I don't think the latter has
any kind of representation in the kernel right now though? That said,
it might be a good idea to represent jacks outside any audio complex
DT node, so that they could host functionality of different types if
the HW does so...

-- 
nvpublic
