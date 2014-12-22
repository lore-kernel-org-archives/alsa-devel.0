From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH v3 2/5] ASoC: dwc: Iterate over all channels
Date: Mon, 22 Dec 2014 14:08:44 +0000
Message-ID: <549825EC.80505@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <67cea1f0a74c333ec2048c7796cda37302d45e95.1418826016.git.Andrew.Jackson@arm.com>
 <20141222135301.GQ17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B43260583
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 15:08:45 +0100 (CET)
In-Reply-To: <20141222135301.GQ17800@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/22/14 13:53, Mark Brown wrote:
> On Fri, Dec 19, 2014 at 04:18:06PM +0000, Andrew Jackson wrote:
> 
>> The Designware core can be configured with up to four stereo channels.
>> Each stereo channel is individually configured so, when the driver's
>> hw_params call is made, each requested stereo channel has to be
>> programmed.
> 
> This is quite unclear to someone who doesn't know the hardware, is this
> a bug fix or a new feature?  It looks like it's a fix...
> 

It is a fix.  In the Designware core, each stereo channel is configured
individually.  So, when hw_params is called to configure N channels, 
N/2 stereo channels need to be configured in the core.  The existing
code doesn't do this and will only configure the highest numbered 
channel.

    Andrew
