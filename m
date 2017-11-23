From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v7 02/13] dt-bindings: Add SLIMbus bindings
Date: Thu, 23 Nov 2017 07:41:15 +0000
Message-ID: <20171123074115.5wvniuoiil4dplow@localhost.localdomain>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-3-srinivas.kandagatla@linaro.org>
 <20171116051500.qlzgxglom2s3dhkt@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E2806266CFB
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 08:41:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171116051500.qlzgxglom2s3dhkt@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, srinivas.kandagatla@linaro.org, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, broonie@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 11:15:00PM -0600, Rob Herring wrote:
> On Wed, Nov 15, 2017 at 02:10:32PM +0000, srinivas.kandagatla@linaro.org wrote:
> > From: Sagar Dharia <sdharia@codeaurora.org>
> > 
> > SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> > developed by MIPI (Mobile Industry Processor Interface) alliance.
> > SLIMbus is a 2-wire implementation, which is used to communicate with
> > peripheral components like audio-codec.
> > 
> > This patch adds device tree bindings for the slimbus.
> > 
> > Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/slimbus/bus.txt | 50 +++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I still have some reservations about the putting the MID and PID
in the compatible sting, are we sure this is what we want to do?
As has been discussed previous the discoverability of SLIMbus
is really theoretical since you really always need to bind a
driver to power on the device, since power is not part of the bus
itself.

Many devices (ours included) will support SLIMbus and other
interfaces, this means we will need a different compatible
string between SLIMbus and I2C/SPI, which feels a little
icky.  Additionally it does make the compatible strings really
unreadable and which is a little annoying when looking at device
trees as you can't easily see what things are.

Thanks,
Charles
