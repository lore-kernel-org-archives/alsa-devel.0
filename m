From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Date: Thu, 22 Aug 2019 16:36:38 +0530
Message-ID: <20190822110638.GN12733@vkoul-mobl.Dlink>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
 <20190821214436.GA13936@bogus>
 <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rob Herring <robh@kernel.org>, broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 22-08-19, 11:12, Srinivas Kandagatla wrote:
> 
> 
> On 21/08/2019 22:44, Rob Herring wrote:
> > On Fri, Aug 09, 2019 at 02:34:04PM +0100, Srinivas Kandagatla wrote:
> > > This patch adds bindings for Soundwire Slave devices that includes how
> > > SoundWire enumeration address and Link ID are used to represented in
> > > SoundWire slave device tree nodes.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
> > >   1 file changed, 51 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
> > 
> > Can you convert this to DT schema given it is a common binding.
> > 
> 
> I will give that a go in next version!
> 
> > What does the host controller look like? You need to define the node
> > hierarchy. Bus controller schemas should then include the bus schema.
> > See spi-controller.yaml.
> 
> Host controller is always parent of these devices which is represented in
> the example.
> 
> In my previous patches, i did put this slave bindings in bus.txt, but Vinod
> suggested to move it to slave.txt.
> 
> Are you suggesting to add two yamls here, one for slave and one for bus
> Or just document this in one bus bindings?

That would be fine by me :-)

-- 
~Vinod
