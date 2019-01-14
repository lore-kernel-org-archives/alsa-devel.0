From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] slimbus: minor fixes.
Date: Mon, 14 Jan 2019 15:53:11 +0100
Message-ID: <20190114145311.GA14821@kroah.com>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 14, 2019 at 01:44:45PM +0000, Srinivas Kandagatla wrote:
> Here are some minor fixes to slimbus core for issues found while testing wcd9335.
> First one is make the slimbus core match full device id,
> second one is to avoid using big lock in status callback function,
> third one is to use status function rather than directly invoking the status ops.
> finally last one is to fix missing spinlock init.

Should all of these go into 5.0-final?  backported to any older releases
as well?  Or can we wait until 5.1-rc1?

thanks,

greg k-h
