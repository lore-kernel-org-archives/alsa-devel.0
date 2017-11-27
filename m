From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 06/13] slimbus: Add messaging APIs to slimbus framework
Date: Mon, 27 Nov 2017 11:26:06 +0530
Message-ID: <20171127055606.GR3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-7-srinivas.kandagatla@linaro.org>
 <20171117074834.GM3187@localhost>
 <d58b8cca-7b28-75be-8081-dad6595f499d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d58b8cca-7b28-75be-8081-dad6595f499d@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 20, 2017 at 06:47:52AM +0000, Srinivas Kandagatla wrote:

> >>+ *	-ENOTCONN: If the transmitted message was not ACKed by destination
> >>+ *	device.
> >
> >I am preferring ENODATA in SDW for this case, as Slaves didnt respond or
> >ACK.
> Isn't that a timeout error then.
> 
> ENODATA is for "No data available", reporting ENODATA would be misleading.

Do you get a explict NACK or no response for this

> 
> >
> >ENOTCONN is defined as /* Transport endpoint is not connected */ which is
> >not the case here, connected yes but not responded.
> 
> Code as it is would not return this, so i will be deleting ENOTCONN from
> kernel doc.

ok

-- 
~Vinod
