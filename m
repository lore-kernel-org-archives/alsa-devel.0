From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 02/13] dt-bindings: Add SLIMbus bindings
Date: Wed, 15 Nov 2017 23:15:00 -0600
Message-ID: <20171116051500.qlzgxglom2s3dhkt@rob-hp-laptop>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AE17A266D7D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 06:15:02 +0100 (CET)
Received: by mail-oi0-f65.google.com with SMTP id a81so7537324oii.13
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 21:15:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171115141043.29202-3-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, broonie@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 02:10:32PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Sagar Dharia <sdharia@codeaurora.org>
> 
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.
> SLIMbus is a 2-wire implementation, which is used to communicate with
> peripheral components like audio-codec.
> 
> This patch adds device tree bindings for the slimbus.
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/slimbus/bus.txt | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt

Reviewed-by: Rob Herring <robh@kernel.org>
