From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v9 01/13] Documentation: Add SLIMbus summary
Date: Thu, 7 Dec 2017 10:32:53 -0700
Message-ID: <20171207103253.25834a68@lwn.net>
References: <20171207102720.21071-1-srinivas.kandagatla@linaro.org>
        <20171207102720.21071-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207102720.21071-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, sdharia@codeaurora.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, pombredanne@nexb.com, j.neuschaefer@gmx.net, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu,  7 Dec 2017 10:27:08 +0000
srinivas.kandagatla@linaro.org wrote:

A couple of overall comments...

>  Documentation/driver-api/index.rst           |   1 +
>  Documentation/driver-api/slimbus/index.rst   |  15 ++++
>  Documentation/driver-api/slimbus/summary.rst | 106 +++++++++++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 Documentation/driver-api/slimbus/index.rst
>  create mode 100644 Documentation/driver-api/slimbus/summary.rst

Do we really need a separate subdirectory for a single file?

It seems you have kerneldoc comments for your data structures and at least
some of your exported symbols.  If you really want to document this stuff
well, I'd suggest finishing out those comments, then pulling them into the
documentation in the appropriate places.

Thanks,

jon
